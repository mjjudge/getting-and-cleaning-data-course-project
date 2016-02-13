#Introduction

##The script  run_analysis.R 
* Assumes the data is in the working directory and already unzipped
* Merges training and test data sets to create one data set
* Replaces  activity  values in the dataset with descriptive activity names per the activity_labels.txt file
* Extracts mean and standard deviation for each measurement only
* Labels columns with descriptive names
* creates a second, independent tidy dataset with an average of each variable for each each activity and each subject. In other words, same type of measurements for a particular subject and activity are averaged into one value and the tidy data set contains these mean values only. The processed tidy data set is also exported as csv file.

#run_analysis.R

The script is parititioned into functions such that each function performs one of the steps described above. To run whole cleaning procedure, call  clean.data  function. The script also assumes that  plyr  library is already installed.

#The original data set

The original data set is split into training and test sets (70% and 30%, respectively) where each partition is also split into three files that contain
* measurements from the accelerometer and gyroscope
* activity label
* identifier of the subject

#Getting and cleaning data

If the data is not already available in the  data  directory, it is downloaded from UCI repository.

The first step of the preprocessing is to merge the training and test sets. Two sets combined, there are 10,299 instances where each instance contains 561 features (560 measurements and subject identifier). After the merge operation the resulting data, the table contains 562 columns (560 measurements, subject identifier and activity label).

After the merge operation, mean and standard deviation features are extracted for further processing. Out of 560 measurement features, 33 mean and 33 standard deviations features are extracted, yielding a data frame with 68 features (additional two features are subject identifier and activity label).

Next, the activity labels are replaced with descriptive activity names, defined in  activity_labels.txt  in the original data folder.

The final step creates a tidy data set with the average of each variable for each activity and each subject. 10299 instances are split into 180 groups (30 subjects and 6 activities) and 66 mean and standard deviation features are averaged for each group. The resulting data table has 180 rows and 68 columns. The tidy data set is exported to  tidydata.csv  where the first row is the header containing the names for each column.

1. Script uses the reshape2 package
2. Merge the training and the test sets to create one data set read data into data frames
### Subjects
*subject_train.txt
*subject_test.txt
### train and test data
*X_train.txt
*X_test.txt
*y_train.txt
*y_test.txt
####Above combined in one data set

3. Extracts only the measurements on the mean and standard deviation for each measurement.
*script determines which columns contain "mean()" or "std()"
*ensures that we also keep the subjectID and activity columns
*removes unnecessary columns

4. Uses descriptive activity names to name the activities
*Walking
*Walking Upstairs
*Walking Downstairs
*Sitting
*Standing
*Laying

5. Creates a second, independent tidy data set with the mean of each variable for each activity and each subject using reshape2 and writes tidydata.csv and displays on console

