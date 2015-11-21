library(dplyr)

#Read the training and test sets:

#set working directory:
setwd('C:/Users/Arjen/Documents/Coursera/GettingData/Project/UCI HAR Dataset')
options(stringsAsFactors =  FALSE)


#read the separate files to data frames:

#general files:

#activity_labels:
activity_labels <- read.table('activity_labels.txt')

#features:
features <- read.table('features.txt')

#test data:
filenames <- list.files('test', pattern="*.txt", full.names=TRUE,recursive = TRUE ,include.dirs = FALSE)
testdata <- lapply(filenames, read.table)
names(testdata) <- substr(filenames, 6, 50)

#training data:

filenames <- list.files('train', pattern="*.txt", full.names=TRUE,recursive = TRUE ,include.dirs = FALSE)
trainingdata <- lapply(filenames, read.table)
names(trainingdata) <- substr(filenames, 7, 50)

#You should create one R script called run_analysis.R that does the following. 

#This script assumes that the relevant data has been loaded in dataframes, trainingdata and testdata.

#1)Merges the training and the test sets to create one data set.
#merge datasets:

Dataset <- rbind(trainingdata$X_train.txt,testdata$X_test.txt)
Activity <- rbind(trainingdata$y_train.txt,testdata$y_test.txt)
Subjects <- rbind(trainingdata$subject_train.txt,testdata$subject_test.txt)

#2)Extracts only the measurements on the mean and standard deviation for each measurement. 

#filter from dataframe features those entries containging mean and standarddeviation:
mean_std_features <-filter(features,grepl('Mean|std',V2))

#select from Dataset only those columns whose names correspond with mean_std features:

Dataset <- select(Dataset, .dots = mean_std_features$V1)

#3)Uses descriptive activity names to name the activities in the data set

#Activity contains the activity ids, activity_labels contain the activities:

Activity <- merge(Activity,activity_labels,by.x = 'V1', by.y='V1')

Dataset <- cbind(Activity$V2,Dataset)

#4)Appropriately labels the data set with descriptive variable names. 

names(Dataset) <- c('Activity',mean_std_features$V2) 

#5)From the data set in step 4, creates a second, independent tidy data set 

#  with the average of each variable for each activity and each subject.

Dataset2 <- cbind(Subjects,Dataset)

names(Dataset2) <- c('Subject',names(Dataset))

Dataset2 <- aggregate(Dataset2[,3:42], by=list(Subject = Dataset2$Subject,Activity = Dataset2$Activity), FUN=mean)
