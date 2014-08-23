##      INITIALIZATION (load the required files (UCI HAR Dataset into memory)
##
##              load all the required files from the dataset
##              ===================================================================
##              File (from UCI HAR Dataset)                     ||      variable
##              ===================================================================
##              TRAINING SET FILES
##              ./UCI HAR Dataset/train/X_train.txt                     xtrainraw
##              ./UCI HAR Dataset/train/subject_train.txt               subtrainraw
##              ./UCI HAR Dataset/train/y_train.txt                     ytrainraw
##
##              TEST SET FILES
##              ./UCI HAR Dataset/test/X_test.txt                       xtestraw
##              ./UCI HAR Dataset/test/subject_test.txt                 subtestraw
##              ./UCI HAR Dataset/test/y_train.txt                      ytestraw
##
##              VARIABLE NAMES
##              ./UCI HAR Dataset/test/features.txt                     featuresraw
##
##              ACTIVITY LABELS
##              ./UCI HAR Dataset/activity_labels.txt                   activitylabels

xtrainraw <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
subtrainraw <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
ytrainraw <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
xtestraw <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
subtestraw <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
ytestraw <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
featuresraw <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, colClasses="character")
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, colClasses="character")


##      1. Merges the training and test sets to create one dataset
##              a. merge the training and test set together...
##              the structure of the merged dataset is as follows:
##
##              ===================================================================
##              Variable Name   ||      featuresraw     || subject      ||  activity
##              ===================================================================
##              Data            ||      xtrainraw       || subtrainraw  ||  ytrainraw
##                              ||      ytestraw        || subtestraw   ||  ytestraw
##              ===================================================================

traindata <- cbind(xtrainraw, subtrainraw, ytrainraw)
testdata <- cbind(xtestraw, subtestraw, ytestraw)
fulldata <- rbind(traindata, testdata)

##              b. ... to create one data set
##              COMMENTS:
##              This will create the merged dataset called fulldata.txt
write.table(fulldata, file="./fulldata.txt", row.name=FALSE)



##      2. Extracts only the measurements on the mean and standard deviation
##      for each measurement
##
##              picking out the mean and standard deviation columns
##              COMMENTS:
##              I used grepl to search for the terms "mean" and "std"
##              and combined the two search result to get
##              a logic table to the variables on the mean and standard deviation
##
meancol <- grepl("mean", featuresraw$V2, ignore.case = FALSE)
stdcol <- grepl("std", featuresraw$V2, ignore.case = FALSE)
reqcol <- meancol | stdcol



##      3. Uses descriptive activity names to name the activities in the dataset
##      descriptive variable labels
##
##              COMMENTS:
##              I do a for/loop to assign the names of the activities
##              based on the activitylabels, intially to a tmp variable
##              then at the end, assign the descriptive activities name 
##              to the full table

tmp <- NULL
for (i in seq_along(fulldata$Activity)) {tmp <- c(tmp, activitylabels$V2[fulldata$Activity[i]])}
fulldata$Activity <- tmp



##      4. Appropriately labels the data set with descriptive variable names
##
##              COMMENTS:
##              I assign the labels from the original dataset and 
##              Add "Subject": Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
##              and "Activity": Activity name performed by subjects.

featureslabels <- c(featuresraw$V2, "Subject", "Activity")
names(fulldata) <- featureslabels



##      5. Creates a second, independent tidy data set with the average of each
##      variable for each activity and each subject

reqfulldata <- cbind(fulldata[,reqcol], fulldata$Subject, fulldata$Activity)
names(reqfulldata) <- c(names(fulldata[,reqcol]), "Subject", "Activity")
tidydata <- aggregate(reqfulldata[,1:79], list(Subject = reqfulldata[,80], Activity = reqfulldata[,81]), mean)

write.table(tidydata, file="./tidydata.txt", row.name=FALSE)
