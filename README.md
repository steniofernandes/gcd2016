# Getting and Cleanind Data
## Final Project - Feb 2016
### Stenio Fernandes

##Goal
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set.

The goal is to prepare tidy data that can be used for later analysis. 

I am submitting: 

1) a tidy data set as described below, 

2) a link to a Github repository with my script for performing the analysis, and 

3) a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data called <b>codebook3.md</b>.

####This repo explains how all of the scripts work and how they are connected.

## Preamble
One of the most exciting areas in all of data science right now is wearable computing - see for example

http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##This repo contains:

###One R script called run_analysis.R that does the following:

<li> Merges the training and the test sets to create one data set. </li>
<li> Extracts only the measurements on the mean and standard deviation for each measurement.</li>
<li> Uses descriptive activity names to name the activities in the data set</li>
<li> Appropriately labels the data set with descriptive variable names.</li>
<li> From the data set in step 4, creates a second, independent 
tidy data set with the average of each variable for each activity and each subject.</li>

###The final dataset called tidydata.txt, in csv format

##Steps of the cleaning process

<li> After reading data, join variables with rbind into another variable</li>
<li> Subset data with the variables that has mean and standard deviation</li>
<li> Load activity factor from numbers to character factor found in the activity_labels.txt  </li>
<li> Clean variable names</li>
<li> Create a different dataset grouped by subject and activity with the average for the remainin variable</li>
<br></br>
##Codebook
###File: codebook3.md

