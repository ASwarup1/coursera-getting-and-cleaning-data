# Code Book

This code book describes various tables of input data used in the
project, the output data format of the \"tidy\" data set, and the
processing steps used to get the latter.

A description of the Human Activity Recognition Using Smartphones Data Set project is at URL:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

## Input Dataset

The original data represents experiments carried out with a group of 30
volunteers, called \"Subjects\" in the study. Each volunteer performed
six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS,
SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on
the waist. Data captured signals from the embedded accelerometer and
gyroscope.

This source data is not included in this repository and needs to be
downloaded from here:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

## Files in the Input Data Set

Data is split into two sets: \"test\" and \"train\". Information that is common
to both data sets resides in the parent folder.

-   features\_info.txt: Shows information about the variables used on
    the feature vector.

-   features.txt: List of all features (variable names).

-   activity\_labels.txt: Links the class labels with their activity
    name (names of the activities). As mentioned above, there are 6
    activity types, namely, WALKING, WALKING\_UPSTAIRS,
    WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING.

Further explanations of the variables used in the above three files are
given below as Appendix.

-   train/X\_train.txt: Training set (experimental observations). Total
    of 7352 observations across 561 variables.

-   train/y\_train.txt: Training labels (activities, matching the
    experiments). 7352 observations.

-   test/X\_test.txt: Test set (experimental observations). Total of
    2947 observations across 561 variables.

-   test/y\_test.txt: Test labels (activities, matching the
    experiments). 2947 observations.

Additionally, following files are available for train and test data.
Their descriptions are equivalent.

-   train/subject\_train.txt: Each row identifies the subject who
    performed the activity for each window sample. Its range is from 1
    to 30.

## Processing Steps

The goal of this project was to create a data set that identifies
average values of some source variables grouped by subject (person perfomring the activity) and the type of the performed activity. All processing is performed by the **\"run\_analysis.R\"** script. When run for the first time, the script
downloads the **\"UCI HAR Dataset\"** zip file, unpacks it and places in a
folder of the same name in the current working directory.

In the first run, as well as in the subsequent runs, the script take the
input dataset files, and produces a data set that is then written to a
file named **\"tidy\_data.txt\"** in the current working directory.

### The script steps are as follows
**( Also, included as comments in the run\_analysis.R file) :**

1.  Read activity\_labels and the features files. From the features
    file, extracts the features containing phrase mean() and std() into
    a vector named \"myFeatures\".

2.  Read the three Training Data related files:

  Read X\_train.txt: Normally, this would get 7352 obs. of 561 variables
(with columns designated as V1 through V561. However, by using the
myFeatures vector, we read only the relevant 66 features columns.

  Read y\_train.txt: Reads the ActivityIds (between 1 and 6) of the 7352
observations.

  Read subject\_train.txt: Read the SubjectIds (between 1 and 30) of the
7352 observations.

  Column-bind the above three tables to get the \"training\" data set.

3.  Repeat the same for the Test Data related files, namely, X\_test.txt
    and y\_test.txt and subject\_test.txt, containing 2947 observations.
    Again, use cbind to get the \"test\" data set.

4.  Merge the \"training\" \"test\" sets into \"allData\" and assign
    column names from myFeatures.Names.

5.  Turn activities and subjects into factors.

6.  Expand column names to longer explantory names, e.g., Acc -\>
    Accelerometer, Gyro -\> Gyroscope, etc. Also, change mean() to Mean
    and std() to StandardDeviation. As an example, column name
    tBodyAcc-std()-X would become
    timeBodyAccelerometerStandardDeviationX.

7.  Group the combined data set by subject id and activity name,
summarizing all variables using mean(), i.e., the averaging function. By
using the piping feature (see the script run\_analysis.R), resulting
data set will be ordered by subject Id and activity name.

8.   Write the output data set to disk, as a file named \"tidy\_data.txt\".

### How to read the file tidy\_data.txt

The output file tidy\_data.txt can be read by the following code:

data \<- read.table(file\_path, header = TRUE)

View(data)

## Appendix

The file features\_info.txt explains how the measurements were taken
from accelerometer and gyroscope, and what filtering and transformations
were done on signals from those. There were two types of signals in
measurements - either time domain or frequency domain. (Note: First
alphabet \'f\' or \'t\' of the corresponding variable name incidates
signal type.) These signals were used to estimate variables of the
feature vector for each pattern: \'-XYZ\' is used to denote 3-axial
signals in the X, Y and Z directions. Following signals were used:

```
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
```

Among the set of variables that were estimated from these signals, those
of interest to us are the Mean Value (designated as mean()) and Standard
Deviation (designated as std()) in the variable names.

The complete list of variables of each feature vector is available in
another file \'features.txt\' This file has 561 entries. The file is not
readable if you open it using Notepad. However, it shows up ok if opened
by Wordpad or Word. This file has 561 entries.

### Variables of Interest
**Whose expanded forms are columns in the file tidy\_data.txt**

Among the 561 variables, the following 66 are of interest to us in this
assignment. The numbers on the left indicate the variableId (V1) among
1-561, in the file features.txt.

```
    1-3 tBodyAcc-mean()-X/Y/Z
    4-6 tBodyAcc-std()-X/Y/Z
  41-43 tGravityAcc-mean()-X/Y/Z
  44-46 tGravityAcc-std()-X/Y/Z  
  81-83 tBodyAccJerk-mean()-X/Y/Z  
  84-86 tBodyAccJerk-std()-X/Y/Z
121-123 tBodyGyro-mean()-X/Y/Z
124-126 tBodyGyro-std()-X/Y/Z
161-163 tBodyGyroJerk-mean()-X/Y/Z
164-166 tBodyGyroJerk-std()-X/Y/Z
201-202 tBodyAccMag-mean()/std()
214-215 tGravityAccMag-mean()/std()
227-228 tBodyAccJerkMag-mean()/std()
240-241 tBodyGyroMag-mean()/std()
253-254 tBodyGyroJerkMag-mean()/std()
266-268 fBodyAcc-mean()-X/Y/Z
269-271 fBodyAcc-std()-X/Y/Z
345-347 fBodyAccJerk-mean()-X/Y/Z
348-350 fBodyAccJerk-std()-X/Y/Z
424-426 fBodyGyro-mean()-X/Y/Z
427-429 fBodyGyro-std()-X/Y/Z
503-504 fBodyAccMag-mean()/std()
516-517 fBodyBodyAccJerkMag-mean()/std()
529-530 fBodyBodyGyroMag-mean()/std()
542-543 fBodyBodyGyroJerkMag-mean()/std()
```

These are renamed to the equivalent expanded names without any special
characters. A typo error - use of BodyBody instead of single Body in few
names is also corrected by the code. Thus, as a couple of examples:
```
tBodyAcc-std()-X -> timeBodyAccelerometerStandardDeviationX,
fBodyBodyAccJerkMag-mean() -> frequencyBodyAccelerometerJerkMagnitudeMean,
etc.
```

### Activity Labels

```
WALKING (value 1): subject was walking during the test
WALKING_UPSTAIRS (value 2): subject was walking up a staircase during the test
WALKING_DOWNSTAIRS (value 3): subject was walking down a staircase during the test
SITTING (value 4): subject was sitting during the test
STANDING (value 5): subject was standing during the test
LAYING (value 6): subject was laying down during the test
```
