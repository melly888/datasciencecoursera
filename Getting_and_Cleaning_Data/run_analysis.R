
install.packages("plyr")
library("plyr")


file_name <- "get_data.zip"

#### download data
if (!file.exists(file_name)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, file_name, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(file_name) 
}


#### 1. Merges the training and the test sets to create one data set.

#read train data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

#read test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

x_data <- rbind(x_train, x_test) 
y_data <- rbind(y_train, y_test)

subject_data <- rbind(subject_train, subject_test)



#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("UCI HAR Dataset/features.txt")

# searches second column of features for values conatining "mean" or "std
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# extracts columns specified by those in the list mean_and_std_features
x_data <- x_data[, mean_and_std_features]

# changes column names from V# to those in features
names(x_data) <- features[mean_and_std_features, 2]



#### 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# change names to match activity names specified in second column of activity_labels.txt
y_data[, 1] <- activities[y_data[, 1], 2]

# change column name from V1 to activity
names(y_data) <- "activity"



#### 4. Appropriately labels the data set with descriptive variable names.

# change column name from V1 to subject
names(subject_data) <- "subject"

# merge data into a single data set
all_data <- cbind(x_data, y_data, subject_data)



#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#columns 1-66 contain values to be averaged; columns 6-68 specifiy activity and subject
averages_results <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_results, "UCI HAR Dataset/averages_results.txt", row.name=FALSE)