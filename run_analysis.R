#########################################################
######### Getting and Cleaning Data Course Project ######
#########################################################

#########################
### load raw dataset ####
#########################

### Nevigate to my directory 
setwd("C:/Users/128267/Desktop/Learning and Research/MOOCS/Data Science Specialization/Get Data/week 3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

### read Features file ###
Features.file <- read.table("features.txt")

### create a vector containing all the features for training and testing datasets ##
Features<-Features.file[ ,2]


##################################################
##################################################

####### Test set ############

## load Test set (no heading) ##
Test<-read.table("./test/X_test.txt", sep="")

## load Test set labels ##
Label <- read.table("./test/y_test.txt")

## Load Test set subjects ##
Subject <- read.table("./test/subject_test.txt")

## Add feature names to the Test set ##
names(Test)<-Features

## Add labels to the Test set
Test<-cbind(Test, Label)

## Add subject number to the Test set
Test<-cbind(Test, Subject)


######################################

## load Train set (no heading) ##
Train<-read.table("./train/X_train.txt", sep="")

## load Train set labels ##
Label <- read.table("./train/y_train.txt")

## Load Test set subjects ##
Subject <- read.table("./train/subject_train.txt")

## Add feature names to the Train set ##
names(Train)<-Features

## Add labels to the Training set
Train<-cbind(Train, Label)

## Add subject number to the Test set
Train<-cbind(Train, Subject)

##############################################################################
##############################################################################

##### Step 1. Merge the training and the test set to create one dataset ###

## concatenate data in Training set and Test set and generate myData ##
masterData <- rbind(Train, Test)

###############################################################################
###############################################################################

##### Step 2. Extracts only the measurements on the mean and standard deviation for each measurement ###

## Convert variable names to all-lower-case names
names(masterData) <- tolower(names(masterData))

## identify the indices of features related to mean measures
meanVar <- grep("mean", names(masterData))

## identify the indices of features related to std measures
stdVar <- grep("std", names(masterData))

## combine mean feature list and std feature list together
targetVar <- c(meanVar, stdVar)
targetVar <- sort(sort(targetVar))
targetVar <- c(targetVar, 562, 563)     ## include the label variable

## subset the master dataset to only the features related to mean or std measures
masterData <- masterData[ , as.vector(targetVar)]

## check the names
names(masterData)

## manually drop the variables with names such as meanfreq, gravitymean ... ##
selectData <- masterData[ , -c(47,48,49,56,57,58,65,66,67,70,73,76,79,80:86)]

## the dataset after step2 cleaning contains 10299 obs and 68 variables 

#####################################################################
#####################################################################

###### Step 3. Uses descriptive activity names to name the activities in the data set #####

# rename activity label code
colnames(selectData)[67] <- "activityCode"
colnames(selectData)[68] <- "Subject"

# Create a variable for descriptive activity names

selectData$Activity[selectData$activityCode==1] <- "WALKING"
selectData$Activity[selectData$activityCode==2] <- "WALKING_UPSTAIRS"
selectData$Activity[selectData$activityCode==3] <- "WALKING_DOWNSTAIRS"
selectData$Activity[selectData$activityCode==4] <- "SITTING"
selectData$Activity[selectData$activityCode==5] <- "STANDING"
selectData$Activity[selectData$activityCode==6] <- "LAYING"

## Tabulate the new variable 
# table(selectData$Activity)

## drop the activityCode
selectData$activityCode<-NULL

## Tabulate the subjects
# table(selectData$Subject)

#####################################################################
#####################################################################

###### Step 4. Appropriately labels the data set with descriptive activity names #####

names(selectData)

### use gsub() function to replace old feature names with more descriptive feature names #####

## t signals

names(selectData)<-gsub("tbodyacc", "time_body_acceleration_signal", names(selectData))
names(selectData)<-gsub("tgravityacc", "time_gravity_acceleration_signal", names(selectData))
names(selectData)<-gsub("tbodygyro", "time_body_gyro_signal", names(selectData))

## f signals

names(selectData)<-gsub("fbodyacc", "FFT_body_acceleration_signal", names(selectData))
names(selectData)<-gsub("fbodyaccjerk", "FFT_body_acceleration_jerk_signal", names(selectData))
names(selectData)<-gsub("fbodygyro", "FFT_body_gyro_signal", names(selectData))
names(selectData)<-gsub("fbodyaccmag", "FFT_body_acceleration_magnuitude", names(selectData))
names(selectData)<-gsub("fbodybodyaccjerkmag", "FFT_body_acceleration_jerk_magnuitude", names(selectData))
names(selectData)<-gsub("fbodybodygyromag", "FFT_body_gyro_magnuitude", names(selectData))
names(selectData)<-gsub("fbodybodygyrojerkmag", "FFT_body_gyro_jerk_magnuitude", names(selectData))

#####################################################################
#####################################################################

###### Step 5. Creates a second, independent tidy data set with the  ###
######  average of each variable for each activity and each subject #####

library(plyr)
library(reshape2)


meltData <- melt(selectData, id=c("Subject", "Activity"))
head(meltData)

finalDF <- dcast(meltData, Subject+Activity~variable, mean)

### output the dataset into a new file
write.table(finalDF, file="Project dataset.txt")

mytxt<-read.table("Project dataset.txt")
