# Description of the variables

1. Raw data for analysis was downloaded following this link:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
    - Please see "[features_info.txt](https://github.com/dynamics77/Getting-and-Cleaning-Data-Course-Project/blob/master/UCI%20HAR%20Dataset/features_info.txt)" from the zip file for information on the original data set columns or see "[README.txt](https://github.com/dynamics77/Getting-and-Cleaning-Data-Course-Project/tree/master/UCI%20HAR%20Dataset)" for additional information". 
    - Addtional information of variables in the dataset can be found here:
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    
2. Steps taken to clean the data as implemented in the "run_analysis.R script" are as follows:
    - Read the X test and training data from respective subfolders "test" and "train"
    - Combine test and train "X" datasets.
    - Label the data set with descriptive variable names. First, read "[features.txt](https://github.com/dynamics77/Getting-and-Cleaning-Data-Course-Project/blob/master/UCI%20HAR%20Dataset/features.txt)" and store the data in a variable called features. 
    - Then use make.names() to create legal R variable names.
    - Extract only the measurements on the mean() and standard deviation std() for each measurement.This results in a 66 indices list. I have made sure that I do NOT include variable names like "meanFreq" as these are not true means. Clearly,  "[features_info.txt](https://github.com/dynamics77/Getting-and-Cleaning-Data-Course-Project/blob/master/UCI%20HAR%20Dataset/features_info.txt)" suggests that the sum of Count feature vector for each pattern is 33! Total of std() and mean() makes 66 variables. 
    - Then make variable names even prettier by removing extra dots from variable names, etc.
    - Read "subject" train and test data files from test and train subdirectories.
    - Combine test and train subject data files into one data.frame "df.s"
    - Label the new variable as "subject"
    - Read Y test and train data sets from subdirectories test and train respectively.
    - Combine Y test and train data sets into one data.frame "df.y"
    - Label the variable  as "activity"
    - Following code replaces numbers with meaningful acitivity labels  using naming convention from "[activity_labels.txt](https://github.com/dynamics77/Getting-and-Cleaning-Data-Course-Project/blob/master/UCI%20HAR%20Dataset/activity_labels.txt)".
    - Finally, combine X, Y and subject data frames to get tidy data "df.all" is the combined final tidy data set.
    - Write tidy data to txt file named "tidydata.txt" for uploading on github.
    - Calculate independent tidy data set with the average of each variable for each activity and each subject. For this transform tidy data created above ("df.all") to extract only average per subject and activity. Final data frame has 180 obs. of  68 variables.
    -  Write final tidy data to txt file "tidy_data_avg.txt" that includes average of each variable for each activity and each subject.
    