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

#check if the file is located in the current working directory

#if (!file.exists("household_power_consumption.txt")){
#  stop("Error, file household_power_consumption.txt not found in current directory")
#}

#read data

X_test <- read.table("~/Downloads/UCI HAR Dataset/test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
X_train <- read.table("~/Downloads/UCI HAR Dataset/train/X_train.txt", quote="\"", stringsAsFactors=FALSE)

#Combine test and train "X" dataset
df.x<-bind_rows(X_train,X_test)

#name variables. 
features <- read.table("~/Downloads/UCI HAR Dataset/features.txt", quote="\"", stringsAsFactors=FALSE)
names(df.x)<-make.names(features[,2],unique=TRUE)

#subset data --select only mean() and std() variables
#I have made sure  that I do not include variable names like "meanFreq"
# will return 10299 obs. of  66 variables: 33 std() and 33 mean()

df.x%<>%select(contains(".mean."),contains("std"))

#make variable names even prettier
#remove extra dots from variable names
  names(df.x)%<>%
  gsub("...X",".X", .)%>%
  gsub("...Y",".Y", .)%>%
  gsub("...Z",".Z", .)%>%
  gsub("..","", .,fixed=TRUE)

#Read "subject" train and test data files
subject_train <- read.table("~/Downloads/UCI HAR Dataset/train/subject_train.txt", quote="\"", stringsAsFactors=FALSE)
subject_test <- read.table("~/Downloads/UCI HAR Dataset/test/subject_test.txt", quote="\"", stringsAsFactors=FALSE)

#Combine test and train subject data and name the variable as "subject"
df.s<-bind_rows(subject_train,subject_test)
names(df.s)<-"subject"

#read Y test and train data sets
y_train <- read.table("~/Downloads/UCI HAR Dataset/train/y_train.txt", quote="\"", stringsAsFactors=FALSE)
y_test <- read.table("~/Downloads/UCI HAR Dataset/test/y_test.txt", quote="\"", stringsAsFactors=FALSE)

#Combine Y test and train data sets and name the variable "activity"
df.y<-bind_rows(y_train,y_test)
names(df.y)<-"activity"

# Descriptive activity names
# Replace numbers with meaningful acitivity labels in the "activity" column
df.y%<>%transmute(activity=ifelse(activity=="1","walking",
                    ifelse(activity=="2","walking_upstairs",
                        ifelse(activity=="3","walking_downstairs",
                           ifelse(activity=="4","sitting",
                                  ifelse(activity=="5","standing",
                                         ifelse(activity=="6","laying",NA)))))))

#Finally combine X, Y and subject data frames to get tidy data
#df.all is the tidy data set

df.all<-bind_cols(df.s,df.y,df.x)

#write tidy data to file
#write.table(df.all,file="tidydata.txt",row.names=FALSE)

#independent tidy data set with the average of each variable for each activity and each subject.
#Transform clean data to extract only average per subject and activity
# final data frame has 180 obs. of  68 variables:

df.by_subject_activity<-df.all%>%
  group_by(subject,activity)%>%
  summarise_each(funs(mean))

#write data to file
#write.table(df.by_subject_activity,file="tidy_data_avg.txt",row.names = FALSE)

