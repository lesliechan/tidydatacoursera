==================================================================
Getting and Cleaning Data Project (coursera.org)
==================================================================
lesliechan
github.com/lesliechan
==================================================================
The purpose of this project is to demonstrate ability to collect,
work with, and clean a data set [1]. The goal is to prepare tidy data
that can be used for later analysis.

A description of the data can be found from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data used (RAWDATA.zip) is taken from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Assumptions:
- The RAWDATA.zip is unzipped into the working directory (i.e. the folder "./UCI HAR Dataset")


The dataset includes the following files:
run_analysis.R		The R Script
README.md			This file
CodeBook.md			The file than contains the variables and its description

Running the run_analysis.R will generated the following files:
fulldata.txt		first full merged data set
tidydata.txt		second independent tidy data set



==================================================================
run_analysis.R

==================================================================
0. INITIALIZATION
the required files from the UCI HAR Dataset is loaded into memory
File (from UCI HAR Dataset)                     ||      variable
TRAINING SET FILES
./UCI HAR Dataset/train/X_train.txt                     xtrainraw
./UCI HAR Dataset/train/subject_train.txt               subtrainraw
./UCI HAR Dataset/train/y_train.txt                     ytrainraw
TEST SET FILES
./UCI HAR Dataset/test/X_test.txt                       xtestraw
./UCI HAR Dataset/test/subject_test.txt                 subtestraw
./UCI HAR Dataset/test/y_train.txt                      ytestraw
VARIABLE NAMES
./UCI HAR Dataset/test/features.txt                     featuresraw
ACTIVITY LABELS
./UCI HAR Dataset/activity_labels.txt                   activitylabels



===================================================================
1. MERGES THE TRAINING AND TEST SETS TO CREATE ONE DATASET
the structure of the merged dataset is as follows:
--
Variable Name   ||      featuresraw     || subject      ||  activity
--
Data            ||      xtrainraw       || subtrainraw  ||  ytrainraw
                ||      ytestraw        || subtestraw   ||  ytestraw
This will create the merged dataset called "./fulldata.txt"


==================================================================
2. EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION 
FOR EACH MEASUREMENT, PICKING OUT THE MEAN AND STANDARD DEVIATION COLUMNS
I used grepl to search for the terms "mean" and "std"
and combined the two search result (with the use of logical OR) to get
a logic table to the variables on the mean and standard deviation (reqcol)


==================================================================
3. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATASET
DESCRIPTIVE VARIABLE LABELS
I do a for/loop to assign the names of the activities
based on the activitylabels, intially to a tmp variable
then at the end, assign the descriptive activities name 
to the full table


==================================================================
4. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
I assign the labels from the original dataset and added two "new variables":
	i. "Subject" 
	Each row identifies the subject who performed the activity for each window sample.
	Its range is from 1 to 30.
	ii. "Activity"
	Activity name performed by subjects.


==================================================================
5. Creates a second, independent tidy data set with the average of each
variable for each activity and each subject
This will create the tidy data set called "./tidydata.txt"


==================================================================
References:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
