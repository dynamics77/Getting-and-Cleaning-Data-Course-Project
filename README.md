---
output: html_document
---

#Following steps describe how to run the "run_analysis.R" script and what it does:

1. Dowload and unzip/uncompress the data file following this link:
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. You should now a have "UCI HAR Dataset" folder and subfolders named "test" and "train". Change directory to "UCI HAR Dataset" folder. You may rename the UCI HAR Dataset folder but it is not required.
    - Please see "features_info.txt" from the zip file for information on the original data set columns or see "README.txt" for additional information".

4. Copy the "run_analaysis.R" script in the "UCI HAR Dataset"" folder or to whatever name
you gave to the folder with the "test" and train" data in Step 2.

5.  source("run_analysis.R") to run the script. **Please** make sure you run this script from the folder/directory that has "test" and "train" subdirectories and contains other text files including "features.txt", etc. Additionally, before running the script you may have to install required R packages "tidyr", "dplyr" and "magrittr" if not already installed.

6. After the successful completion of the script in Step 4 you should now have two new text 
files named "tidydata.txt" and "tidy_data_avg.txt" in your current folder. 
    - The "tidydata.txt" file contains merged training and the test sets and has 10299 rows (observations) and 68 columns including 66 variables (33 std() and 33 mean() corresponding to measured signals) and one column each for the subject and activity. 
    - The "tidy_data_avg.txt" contains average of each variable for each activity and each subject. Since there are total 6 activities and 30 subjects, we have 180 rows with all combinations for each of the 66 features.

7. Previously, saved tidy datasets in Step 4 can be downloaded and read as following in R:

     **Download files**:
      - url<-"https://raw.githubusercontent.com/dynamics77/Getting-and-Cleaning-Data-Course-Project/master/tidydata.txt"
    - download.file(url,destfile = "tidydata.txt",method="curl")
    - url1<-"https://github.com/dynamics77/Getting-and-Cleaning-Data-Course-Project/blob/master/tidy_data_avg.txt"
    - download.file(url1,destfile = "tidy_data_avg.txt",method="curl")
    
     **Read files**:
     - data.set1<-read.table("tidydata.txt", header=TRUE)
     - data.set2<-read.table("tidy_data_avg.txt", header=TRUE)

