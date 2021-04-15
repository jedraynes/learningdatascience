###
# Coursera Johns Hopkins Data Science Specialization
# Getting and Cleaning Data
# Week 4 Project
# jedraynes
###

# set the working directory
setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\3 Getting and Cleaning Data\\Week 4\\Project")

# load dplyr
library(dplyr)

# read in the files

# read features and activity labels
features <- read.table(".\\UCI HAR Dataset\\features.txt", col.names = c("index", "feature"))
activity_labels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt", col.names = c("activity_number", "activity_label"))

# testing sets
subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", col.names = c("subject"))
X_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt", col.names = features$feature)
y_test <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt", col.names = c("activity_number"))

# training sets
subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", col.names = c("subject"))
X_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", col.names = features$feature)
y_train <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt", col.names = c("activity_number"))

# merge the test sets
test_set <- cbind(X_test, y_test)
test_set <- cbind(subject_test, test_set)

# merge the training sets
train_set <- cbind(X_train, y_train)
train_set <- cbind(subject_train, train_set)

# merge the training set and the testing set into one dataset
df_dirty <- rbind(test_set, train_set)


# label the activities
df_clean <- left_join(df_dirty, activity_labels, by = "activity_number")

# create a second independent tidy dataset with the means
df_mean <- df_clean %>% group_by(df_clean$subject, df_clean$activity_label) %>%
  summarize_all(.funs = mean)

# write the second dataset for submission
write.table(df_mean, "step5.txt",row.names = FALSE)

# now we have our two final datasets that are commented out below
# View(df_clean)
# View(df_mean)
