# G-CD-Course-Project
## The script run_analysis.R does the following things
### Creates a test and training dataframe selecting only the features that are concerned with averages and standard deviations. It uses dpylr and regular expressions to accomplish this.
### Merges these data sets into a data.table named "clean"
### Creates a new data.table named step5 which collapses the clean dataset into the average for all the varaibles by subject and activitity
##Be aware that the varaibles "subjects" and current_activ" are the last two variables in the table, and may not be obvious at first glance. 