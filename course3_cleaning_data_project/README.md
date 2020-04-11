---
title: "README.md"
author: "J. Lei"
date: "4/10/2020"
output: text markdown document
---


**Getting and Cleaning Data Course Project**
=================================================

Wearable Computing - Companies like Fitbit, NIke, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
The data linked represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

A full description is available at the site: 
[link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project:
[link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

This directory includes the following file:
==========================================
* README.md
* run_analysis.R
* UCI HAR Datatset

        + it contains the raw data and its own README.txt file explaining details
* codebook.txt
* output files from run_analysis.R

        + combined_tidy_dataset.csv
        + combined_variable_names.csv
        + mean_measurements_tidy_dataset.csv
        + mean_measurements_tidy_dataset.txt
        + mean_measurements_variable_names.csv
        

run_analysis.R does the following to the UCI HAR Dataset:
========================================================
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
        + outputs 'combined_tidy_dataset.csv'
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        + outputs 'mean_measurements_tidy_dataset.csv' & 'mean_measurements_tidy_dataset.txt'
