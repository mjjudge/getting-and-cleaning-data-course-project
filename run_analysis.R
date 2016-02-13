library(reshape2)

# Merges the training and the test sets to create one data set

# read data into data frames
subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")
X_train <- read.table("X_train.txt")
X_test <- read.table("X_test.txt")
y_train <- read.table("y_train.txt")
y_test <- read.table("y_test.txt")

# add column name for subject files
names(subject_train) <- "subjectRef"
names(subject_test) <- "subjectRef"

# add column names for measurement files
featureNames <- read.table("features.txt")
names(X_train) <- featureNames$V2
names(X_test) <- featureNames$V2

# add column name for label files
names(y_train) <- "activity"
names(y_test) <- "activity"

# combine files into one dataset
train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
combinedData <- rbind(train, test)

# Extracts only the measurements on the mean and standard
# deviation for each measurement.

mean_std <- grepl("mean\\(\\)", names(combinedData)) |
  grepl("std\\(\\)", names(combinedData))
mean_std[1:2] <- TRUE
combinedData <- combinedData[, mean_std]

# Labels the data set with descriptive names
combinedData$activity <- factor(combinedData$activity, labels=c("Walking",
                                                                "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

# Creates a second, independent tidy data set with average of each variable for 
# each activity and each subject, write to a file and prints to console
melted <- melt(combinedData, id=c("subjectRef","activity"))
tidyData <- dcast(melted, subjectRef+activity ~ variable, mean)

write.csv(tidyData, "tidydata.txt", row.names=FALSE)
print(tidyData)
