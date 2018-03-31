################################################################################
#                                                                              #
# FILE                                                                         #
#   run_analysis.R                                                             #
#                                                                              #
# OVERVIEW                                                                     #
#   Using data collected from the accelerometers from the Samsung Galaxy S     #
#   smartphone, work with the data and make a clean data set, outputting the   #
#   resulting tidy data to a file named "tidy_data.txt".                       #
#   See README.md for details.                                                 #
#                                                                              #
################################################################################

library(dplyr)

setwd("C:/Users/ASwar/gcdProj1")

##############################################################
#### Download the dataset zip file to read                ####
##############################################################

# download zip file containing data if it hasn't already been downloaded
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "UCI_HAR_Dataset.zip"

if (!file.exists(filename)) {
  download.file(fileUrl, filename, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
dataDir <- "UCI HAR Dataset"
if (!file.exists(dataDir)) {
  unzip(filename)
}

###################################################################
#### Read data from the extracted files                        ####
###################################################################

# Read activity labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
colnames(activityLabels) <- c("activityId", "activityName")
# activityLabels

# Read features
features <- read.table("./UCI HAR Dataset/features.txt", sep="", header=FALSE)
features[,2] <- as.character(features[,2])
# View(features)


##########################################################################
#### Extract only the measurements on the mean and standard deviation ####
#### for each measurement                                             ####
##########################################################################


# Extract only the features containing phrase mean() and std()
# features2 <- grep(".*mean.*|.*std.*", features[,2])
myFeatures <- grep("mean\\(\\)|std\\(\\)", features[,2])
myFeatures.Names <- features[myFeatures,2]

# Read training data
train <- read.table("./UCI HAR Dataset/train/X_train.txt")[myFeatures]
trainActivityIds <- read.table("./UCI HAR Dataset/train/Y_train.txt")
trainSubjectIds <- read.table("./UCI HAR Dataset/train/subject_train.txt")
training <- cbind(trainSubjectIds, trainActivityIds, train)

# Read test data
test <- read.table("./UCI HAR Dataset/test/X_test.txt")[myFeatures]
testActivityIds <- read.table("./UCI HAR Dataset/test/Y_test.txt")
testSubjectIds <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testing <- cbind(testSubjectIds, testActivityIds, test)


##############################################################################
#### Merge the training and the test sets to create one data set          ####
##############################################################################

# Merge training and test datasets and assign column names
allData = rbind(training, testing)
colnames(allData) <- c("subject", "activity", myFeatures.Names)
# str(allData)

# Remove intermediate data tables to save memory
rm(train, trainSubjectIds, trainActivityIds, test, testSubjectIds, testActivityIds)

###############################################################################
#### Use descriptive activity names to name the activities in the data set ####
###############################################################################

# Turn activities & subjects into factors
# Replace activity values with named factor levels
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

##############################################################################
#####  Appropriately label the data set with descriptive variable names  #####
##############################################################################

# Get variable names (column names)
allDataCols <- colnames(allData)

# Remove special characters
allDataCols <- gsub("[\\(\\)-]", "", allDataCols)

# Expand abbreviations and clean up names
allDataCols <- gsub("^t", "time", allDataCols)
allDataCols <- gsub("^f", "frequency", allDataCols)
allDataCols <- gsub("Acc", "Accelerometer", allDataCols)
allDataCols <- gsub("Gyro", "Gyroscope", allDataCols)
allDataCols <- gsub("Mag", "Magnitude", allDataCols)
allDataCols <- gsub("Freq", "Frequency", allDataCols)
allDataCols <- gsub("mean", "Mean", allDataCols)
allDataCols <- gsub("std", "StandardDeviation", allDataCols)
# Also, correct a typo in a variable name
allDataCols <- gsub("BodyBody", "Body", allDataCols)

# Assign new labels as column names
colnames(allData) <- allDataCols

#######################################################################
##### Create a 2nd tidy data set with the average of each variable ####
##### for each activity and subject                                ####
#######################################################################

# Group by subject and activity and summarise using mean
activityMeans <- allData %>%
   group_by(subject, activity) %>%
   summarise_all(mean)

# Write output to file "tidy_data.txt"
write.table(activityMeans, "tidy_data.txt", row.names = FALSE, quote = FALSE)

