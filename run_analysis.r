# Getting and Cleaning Data
# Stenio Fernandes - Jan 26 2016

# You will be required to submit: 

# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis, and 
# 3) a code book that describes the variables, the data, and 
#    any transformations or work that you performed to clean up the data 
#    called CodeBook.md. 
#    You should also include a README.md in the repo with your scripts. 
#    This repo explains how all of the scripts work and how they are connected.

# You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.

library(dplyr)

cat("Reading data...\n")

# read training files
X_train <- read.table("~/My Work/UFPE/CIn/Sabatical 2015/Studies/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
Y_train <- read.table("~/My Work/UFPE/CIn/Sabatical 2015/Studies/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
subject_train <- read.table("~/My Work/UFPE/CIn/Sabatical 2015/Studies/Coursera/Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")

# read testing files
subject_test <- read.table("~/My Work/UFPE/CIn/Sabatical 2015/Studies/Coursera/Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
X_test <- read.table("~/My Work/UFPE/CIn/Sabatical 2015/Studies/Coursera/Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
Y_test <- read.table("~/My Work/UFPE/CIn/Sabatical 2015/Studies/Coursera/Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")

features <- read.table("~/My Work/UFPE/CIn/Sabatical 2015/Studies/Coursera/Getting and Cleaning Data/UCI HAR Dataset/features.txt", quote="\"", comment.char="")

# 1. Merges the training and the test sets to create one data set.
cat("Merging datasets...\n")
X_data <- rbind(X_train, X_test)
Y_data <- rbind(Y_train, Y_test)
subject_data <- rbind(subject_train, subject_test)

names(X_data) <- features$V2
X_data <- cbind("subjectid" = as.factor(subject_data$V1), 
            "activity" = as.factor(Y_data$V1), 
            X_data)

# 2. Extracts only the measurements on the 
#    mean and standard deviation for each measurement.

subset_data <- X_data[,grepl("subjectid|activity|mean\\(|std\\(", names(X_data))]

# 3. Use descriptive activity names to name the activities in the data set

cat("load activity labels, then clean it and apply them to the main dataset...\n")
al <- read.table("~/My Work/UFPE/CIn/Sabatical 2015/Studies/Coursera/Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
al$V2 <- tolower(sub("_","",al$V2))
subset_data$activity <- sapply(subset_data$activity,function(x)
  {
  al[al$V1==x,"V2"]
  }
)

# 4. Appropriately label the data set with descriptive variable names.
cat("remove noisy characters from names...\n")

names(subset_data) <- tolower(gsub("-|\\(\\)","",names(subset_data)))
cat("changing the mean and standard deviation factors names...\n")
names(subset_data) <- gsub("mean","MEAN",names(subset_data))
names(subset_data) <- gsub("std","STDEV",names(subset_data))

# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.

finaldata <- subset_data %>% 
              group_by(subjectid,activity) %>% 
              summarise_each(funs(mean))
write.csv(file = "tidydata.txt", finaldata)
