---
title: "README"
author: "Ahmad Abdulhameed"
date: "27/06/2020"
output: html_document
---

## Repository Description

This repository includes files related to the course project of the course Getting & Cleaning Data.
The owner of the repository is myself, Ahmad Abdulhameed, and the datasets used to create the files in this repository is extracted from  <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>, a project by UCI. You can download the dataset by using the link <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>.

## Files

The dataset contains the following files:

* **CodeBook.md**: explains, in detail, the methodology used to extract the data and clean the data  
* **run_analysis.R**: a file containing the R script that performs the following functions:
  +  Merges the training and the test sets to create one data set.  
  +  Extracts only the measurements on the mean and standard deviation for each measurement.  
  +  Uses descriptive activity names to name the activities in the data set.  
  +  Appropriately labels the data set with descriptive variable names.  
  +  From the data set in the previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
* **final.txt**: the final tidy dataset, grouped by each subject and activity, with the mean of the all variables.