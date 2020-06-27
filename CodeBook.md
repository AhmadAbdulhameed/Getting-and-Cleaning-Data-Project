---
title: "CodeBook"
author: "Ahmad Abdulhameed"
date: "26/06/2020"
output: html_document
---

## Introduction

This codebook describes the steps taken to implement the run_analysis.R script to get and clean the data for wearable computing technology study performed by the University of Califronia Irvine. You can find more details about the research in <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>.


## Explaining the code

### Step 1: Checking the availability of required packages & loading the packages
We want to make sure that the **dplyr** package is available and loaded.

### Step 2: Checking availability of directory and setting a new working directory

### Step 3: Checking the availability of the folder containing the dataset
This step is done to prevent downloading the dataset several times.

### Step 4: Reading the files
We read the files required to perform our analysis.

#### R Objects loaded

* `features`: contains all 561 variable names measured by sensors on the mobile phone as well as other calculated variables  
* `activity_labels`: contains the 6 types of activities done by the volunteer subjects and assigns a code to each activity; it becomes a **factor variable** later on  
* `subject_test`: a column of the subject code that will be binded later on with the respective measurements coming from that subject; **test** stands for test dataset that would have initially used to test the machine learning model  
* `x_test`: a table containing the variable measurements and claculations  
* `y_test`: a table of indeces representing the code of the activity; it will be substituted later on with the `activity_labels`  
* the `x_train`, `y_train`, and `subject_train` variables are the datasets that would have been initially used to train the machine learning model

### Step 5: Merging test and training datasets into one
Now that we loaded the train and test datasets individually, we merge the dataframes together so that we have the subject column initially, followed by the activity index, followed by all the other variables.
This is performed by the **rbind()** and **cbind()** functions
### Step 6: Extracting measurements on mean and standard deviation
We start using the dplyr package here with the function **select()**. As per the assignment requirements, we want all the variables that contain meean and standard deviation measurements.

### Step 7: Describing activity names
Up till now, the activity names have been represented by number 1 to 6. We change the whole index cloumn to a factor variable, and the labels will come from the vector `activity_labels$activity`, where each activity is matched to its corresponding index number.

### Step 8: Renaming the variables so that they are more descriptive
We work on the `tidy` dataset here to rename all the column names into more descriptive ones, and then making them more readable. Steps taken are shown below: 

* remove the repition of *BodyBody*  
* rename the part called *freq* to become Frequency. This step **must** be performed before renaming all variables starting with *f* into Frequency, or else you will have some variables starting with **Frequencyuency**.  
* rename the parts called *std*, *mag*, *gyro*, and *acc* into Standard.Deviation, Magnitude, Gyroscope, and Acceleromter respectively  
* capitalise the words *angle*, *gravity*, *subject*, and *activity* into Angle, Gravity, Subject, and Activity  
* variables that start with *t* and *f* are changed to Time and Frequency respectively  
* variables that start with `^Angle.t` are changed into Angle.Time  

Now the variables are all clearer and understandable. But they contain dots in a random way. We remove all the dots from the variable names and then placing a **dot** before each word starting with a capital letter except the first word.

### Step 9: Creating the averaged database grouped by activity & subject
The database is then grouped by subject and activity, and the mean is taken for each group. We then finish by writing the `final` dataset into final.txt format.
