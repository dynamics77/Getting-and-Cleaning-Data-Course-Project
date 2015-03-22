#usage: source("run_analysis.R)
#output: "tidydata.txt" and "tidy_data_avg.txt"

#Make sure you have dowloaded and unzipped the data following this link:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#You should now have "UCI HAR Dataset" folder. 
#Change directory to "UCI HAR Dataset" folder. 
#Copy the "run_analaysis.R" script in the UCI HAR Dataset folder.
#make sure all required packages are installed.
#usage: source("run_analysis.R")
#Read more here:
#https://github.com/dynamics77/Getting-and-Cleaning-Data-Course-Project/blob/master/README.md

#Troubleshoot: If for some reason this R script fails to run. 
#I suggest restarting R and then reruning the script.

#clear workspace
rm(list=ls())
#load libraries

library(tidyr)
library(magrittr)
library(dplyr)

#make sure requried packagees are installed and loaded
if(!require(dplyr) | !require(tidyr) | !require(magrittr)) {
  stop('The required packages not installed')
}


#Read the X test and training data from respective subfolders "test" and "train"

X_test <- read.table("test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
X_train <- read.table("train/X_train.txt", quote="\"", stringsAsFactors=FALSE)

#Combine test and train "X" datasets
#Do rowise binding of two datasets using "bind_rows()" from dplyr
df.x<-bind_rows(X_train,X_test)

#Label the data set with descriptive variable names.
#First, read features.txt 
#Then use make.names() to create legal R variable names.
features <- read.table("features.txt", quote="\"", stringsAsFactors=FALSE)
names(df.x)<-make.names(features[,2],unique=TRUE)

#Extract only the measurements on the mean() and standard deviation std() for each measurement.
#I have made sure that I do NOT include variable names like "meanFreq" as these are not true means. 
# Features_info.txt is quite clear about it. Sum of Count feature vector for each pattern is 33!
# Following lines of code will return 10299 obs. of  66 variables: 33 std() and 33 mean()

df.x%<>%select(contains(".mean."),contains("std"))

# Now make variable names even prettier
# For example remove extra dots from variable names, etc.

names(df.x)%<>%
  gsub("...X",".X", .)%>%
  gsub("...Y",".Y", .)%>%
  gsub("...Z",".Z", .)%>%
  gsub("..","", .,fixed=TRUE)

#Read "subject" train and test data files from test and train subdirectories
subject_train <- read.table("train/subject_train.txt", quote="\"", stringsAsFactors=FALSE)
subject_test <- read.table("test/subject_test.txt", quote="\"", stringsAsFactors=FALSE)

#Combine test and train subject data files into one data.frame "df.s"
df.s<-bind_rows(subject_train,subject_test)

#Label the new variable as "subject"
names(df.s)<-"subject"

#Now read Y test and train data sets from subdirectories test and train respectively.
y_train <- read.table("train/y_train.txt", quote="\"", stringsAsFactors=FALSE)
y_test <- read.table("test/y_test.txt", quote="\"", stringsAsFactors=FALSE)

#Combine Y test and train data sets into one data.frame "df.y"
df.y<-bind_rows(y_train,y_test)

#Label the variable  as "activity"
names(df.y)<-"activity"

# Name the activities in the data set using descriptive activity names
# Following code replaces numbers with meaningful acitivity labels 
#using naming convention from activity_labels.txt

df.y%<>%transmute(activity=ifelse(activity=="1","walking",
                    ifelse(activity=="2","walking_upstairs",
                        ifelse(activity=="3","walking_downstairs",
                           ifelse(activity=="4","sitting",
                                  ifelse(activity=="5","standing",
                                         ifelse(activity=="6","laying",NA)))))))

#Finally, combine X, Y and subject data frames to get tidy data
#df.all is the combined final tidy data set

df.all<-bind_cols(df.s,df.y,df.x)

#Write tidy data to txt file for uploading on github
write.table(df.all,file="tidydata.txt",row.names=FALSE)

#To read the above saved tidy data--uncomment line below.
#read.table("tidydata.txt", header=TRUE)

#Calculate independent tidy data set with the average of each variable 
#for each activity and each subject.
#Transform tidy data created above to extract only average per subject and activity
# Final data frame has 180 obs. of  68 variables:

df.by_subject_activity<-df.all%>%
                        group_by(subject,activity)%>%
                        summarise_each(funs(mean))

#Write final tidy data to txt file that includes
#average of each variable for each activity and each subject.
write.table(df.by_subject_activity,file="tidy_data_avg.txt",row.names = FALSE)

#To read the file -uncomment line below
#read.table("tidy_data_avg.txt", header=TRUE)
