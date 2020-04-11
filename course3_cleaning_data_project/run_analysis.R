## Date: April 9th, 2020
## Author: J. Lei

## Getting and Cleaning Data Course Project

## The purpose of this project is to demonstrate my ability to collect, 
## work with, and clean a data set. 
## The goal is to prepare tidy data for later analysis.

## Wearable Computing - Companies like Fitbit, NIke, and Jawbone Up are racing
## to develop the most advanced algorithms to attract new users.
## The data linked represent data collected from the accelerometers from the 
## Samsung Galaxy S smartphone. 

## A full description is available at the site: 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Here are the data for the project:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

setwd("./course3_cleaning_data_project/")
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(zipUrl, destfile = "./UCI HAR Dataset.zip", method = "curl")
unzip("UCI HAR Dataset.zip"); file.remove("UCI HAR Dataset.zip")

## Read in data from "./UCI HAR Dataset/"
file1 <- "./UCI HAR Dataset/features.txt"
file2 <- "./UCI HAR Dataset/activity_labels.txt"
features561 <- read.table(file1)
activity_labels <- read.table(file2)

file_sub_train <- "./UCI HAR Dataset/train/subject_train.txt"
file_X_train <- "./UCI HAR Dataset/train/X_train.txt"
file_y_train <- "./UCI HAR Dataset/train/y_train.txt"
file_sub_test <- "./UCI HAR Dataset/test/subject_test.txt"
file_X_test <- "./UCI HAR Dataset/test/X_test.txt"
file_y_test <- "./UCI HAR Dataset/test/y_test.txt"

subject_train <- read.table(file_sub_train)
subject_test <- read.table(file_sub_test)
X_train <- read.table(file_X_train)
X_test <- read.table(file_X_test)
y_train <- read.table(file_y_train)
y_test <- read.table(file_y_test)


## Part 1 - Merge the training and test sets to create one data set

## Change the column names for X_test and X_train to the 561 features
colnames(X_test) <- features561$V2
colnames(X_train) <- features561$V2

## Combine y_test and y_train to X_test and X_train, respectively
## to label each observation with the activity type
## Also combine subject to label each observation with subject ID
colnames(y_test) <- "activity_labels"
colnames(y_train) <- "activity_labels"
colnames(subject_test) <- "subjectID"
colnames(subject_train) <- "subjectID"
testset <- cbind(subject_test, y_test, X_test)
trainset <- cbind(subject_train, y_train, X_train)

## Combine training and test sets
dataset1 <- rbind(trainset, testset)

## Part 2 - Extracts only the measurements on the mean and standard deviation
## for each measurement

## Get the column indices for "mean()|std()"
## Hint: use "\\" to capture the literal meaning of left parenthesis
## [don't forget the first 2 columns need to be maintained.]
get_col_index <- grep("mean\\()|std\\()|subjectID|activity_labels", 
                      colnames(dataset1))
dataset2 <- dataset1[get_col_index]

## Part 3 - Use descriptive activity names to name the activities in the data set

## merge 'activity_labels' data frame with dataset2
dataset3 <- merge(dataset2, activity_labels, 
                  by.x = "activity_labels", by.y = "V1", sort=FALSE)

## Load 'dplyr' package
library(dplyr)
## reorder the columns and rename the activity column
dataset4 <- act_test2 %>% 
        select(subjectID, activityID=activity_labels, activity=V2, everything())

write.csv(dataset4, "combined_tidy_dataset.csv")

## Part 4 - Appropriately labels the data set with descriptive variable names
## This has been done/embedded in Part 1 with renaming colnames to features

## Part 5 - From the data set in Part 4, create a second, independent tidy data set
## with the average of each variable for each activity and each subject.

dataset4_mean <- dataset4 %>% 
        group_by(subjectID, activity) %>% 
        summarise_at(vars(-activityID), funs(mean))

write.csv(dataset4_mean, "mean_measurements_tidy_dataset.csv")


## extract the column names
column_names <- colnames(dataset4)
write.csv(column_names, "combined_variable_names.csv")

column_names2 <- colnames(dataset4_mean)
write.csv(column_names2, "mean_measurements_variable_names.csv")
