## Checking the availability of required packages & loading the packages

dplyr <- "dplyr" %in% rownames(installed.packages())

if(dplyr == FALSE){
        install.packages("dplyr")
}


library(dplyr)

## Checking the availability of the folder

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipName <- "projectDataset.zip"
folderName <- "UCI HAR Dataset"

if(!file.exists(folderName)) {
        download.file(fileUrl, zipName)
        unzip(zipName)
}

## Reading the files

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("i", "feature"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("index", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "index")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "index")

## Merging test and training datasets into one

subject <- rbind(subject_test, subject_train)
y <- rbind(y_test, y_train)
x <- rbind(x_test, x_train)
complete_dataset <- cbind(subject, y, x)

## Extracting measurements on mean and standard deviation

tidy <- select(complete_dataset, subject, index, contains("mean"), contains("std") )

## Describing activity names

tidy$index <- factor(tidy$index,labels = activity_labels$activity)

## Renaming the variables so that they are more descriptive

names(tidy) <- gsub("BodyBody", "Body", names(tidy), ignore.case = T)
names(tidy) <- gsub("freq", "Frequency", names(tidy), ignore.case = T)
names(tidy) <- gsub("std", "Standard.Deviation", names(tidy), ignore.case = T)
names(tidy) <- gsub("mag", "Magnitude", names(tidy), ignore.case = T)
names(tidy) <- gsub("gyro", "Gyroscope", names(tidy), ignore.case = T)
names(tidy) <- gsub("acc", "Accelerometer", names(tidy), ignore.case = T)
names(tidy) <- gsub("^angle", "Angle", names(tidy), ignore.case = T)
names(tidy) <- gsub("gravity", "Gravity", names(tidy), ignore.case = T)
names(tidy) <- gsub("mean", "Mean", names(tidy), ignore.case = T)
names(tidy) <- gsub("^Angle.t", "Angle.Time", names(tidy))
names(tidy) <- gsub("^f", "Frequency", names(tidy))
names(tidy) <- gsub("^t", "Time", names(tidy))
names(tidy)[1] <- "Subject"
names(tidy)[2] <- "Activity"

## Placing dots between every word in the variable name

names(tidy) <- gsub("\\.", "", names(tidy))                             ## removes all dots
names(tidy) <- gsub("(?!^)(?=[[:upper:]])", ".", names(tidy), perl=T)   ## adds new dots

## Creating the averaged database grouped by activity & subject 

summaryDB <- group_by(tidy, Subject, Activity)
final <- summarise_all(summaryDB, mean)
write.table(final, "final.txt", row.name=FALSE)


