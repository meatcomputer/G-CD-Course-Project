##Run this file from a directory containing the UCI HAR Dataset. This script requires the dpylr package.
library(dplyr)

##Aquire the feature variable names
features <- read.table("UCI HAR Dataset/features.txt")
labels <- as.character(features$V2)

##Aquire factor vectors of subjects for the test and train sets
test_subjects <- as.factor(scan("UCI HAR Dataset/test/subject_test.txt"))
train_subjects <- as.factor(scan("UCI HAR Dataset/train/subject_train.txt"))

##Create a table with activity labels and levels then aquire factor vectors of the activities described 
## by each sample
activ <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("levels","labels"))
test_activ <- factor(scan("UCI HAR Dataset/test/y_test.txt"),levels = activ$levels, labels = activ$labels)
train_activ <- factor(scan("UCI HAR Dataset/train/y_train.txt"), levels = activ$levels, labels = activ$labels)

##Leverage dplyr to create a cleaned version of the test and training datasets, then merge them.
test <- (
  read.table("UCI HAR Dataset/test/X_test.txt", col.names = labels) %>%
           select(matches("mean|std")) %>%
           mutate(subjects = test_subjects, current_activ = test_activ)
)
train <- (
  read.table("UCI HAR Dataset/train/X_train.txt", col.names = labels) %>%
    select(matches("mean|std")) %>%
    mutate(subjects = train_subjects, current_activ = train_activ)
)

clean <- merge(test,train, all = TRUE)

#Find the average of each variable for each activity and subject
step5 <- (
  clean %>% 
  group_by(subjects, current_activ) %>%
  summarise_each(funs(mean))
)