# **Coursera *Getting and Cleaning Data* course project**

One of the most exciting areas in all of data science right now is
wearable computing - see for example [this
article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/).
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the
most advanced algorithms to attract new users.

In this project, we worked on tidying up the data collected in a UCI
Study. The data on the Coursera course web site which is the starting
point for our project's data was obtained from the UCI web site:  
**Human Activity Recognition Using Smartphones** (see URL in the UCI study section below)

The UCI website lists the method by which the data was collected from
the accelerometers from the Samsung Galaxy S smartphone, given to 30
subjects, performing various activities.

We downloaded our starting dataset from a Coursera site link:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The initial dataset -- being quite large - is not uploaded to this
repository.

This repository contains the following files:

-   README.md, this file, which provides an overview of the data set and
    how it was created.

-   tidy\_data.txt, which contains the final data set.

-   CodeBook.md, the code book, which describes the contents of the data
    sets (data, variables and transformations used to generate the
    data), and explanation of the processing steps performed by the
    script run\_analysis.R

-   run\_analysis.R, the R script that was used to create the data set
    (see the [Creating the data
    set](https://github.com/spujadas/getting-and-cleaning-data-course-project/blob/master/README.md#creating-data-set)
    section below)

## **UCI Study** **-- source of our initial dataset**

The source data set that this project was based on was obtained from the
[Human Activity Recognition Using Smartphones Data
Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones),
which describes how the data was initially collected as follows:

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The experiments have been video-recorded to label the data
manually. The obtained dataset has been randomly partitioned into two
sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by
applying noise filters and then sampled in fixed-width sliding windows
of 2.56 sec and 50% overlap (128 readings/window). The sensor
acceleration signal, which has gravitational and body motion components,
was separated using a Butterworth low-pass filter into body acceleration
and gravity. The gravitational force is assumed to have only low
frequency components, therefore a filter with 0.3 Hz cutoff frequency
was used. From each window, a vector of features was obtained by
calculating variables from the time and frequency domain.

Training and test data were first merged together to create one data
set, then the measurements on the mean and standard deviation were
extracted for each measurement (79 variables extracted from the original
561), and then the measurements were averaged for each subject and
activity, resulting in the final data set.

## **Creating the final 'tidy' dataset**

The R script run\_analysis.R can be used to create the 'tidy' data set,
which should be starting point of any actual data analysis (like
regression, plotting, etc.). The script retrieves the source data set
and transforms it to produce the final data set by implementing the
following steps (see the CodeBook for details, as also the comments in
the script itself):

-   Download and unzip source data if it doesn\'t exist.

-   Read data.

-   Merge the training and the test sets to create one data set.

-   Extract only the measurements on the mean and standard deviation for
    each measurement.

-   Use descriptive activity names to name the activities in the data
    set.

-   Appropriately label the data set with descriptive variable names.

-   Create a second, independent tidy set with the average of each
    variable for each activity and each subject.

-   Write the data set to the tidy\_data.txt file.

The tidy\_data.txt in this repository was created by running the
run\_analysis.R script using R version 3.4.3 (2017-11-30) on 64-bit
Windows 10.

This script requires the dplyr package (version 0.7.4 was used)

**Please refer to CodeInfo.md for variables and processing details.**
