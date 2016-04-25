# Summary

run_analysis.R:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


* Data that refers to the same variables is merged using rbind().
* Only those columns with the mean and standard deviation measures are extracted from the merged dataset. 
* Renamed these columns using values from features.txt
* Renamed columns to the activity names and IDs from activity_labels.txt
* Renamed columns that had nonsensical column names 
* Created a new dataset averages_results.txt with all the average measures for each subject and activity type 


# Variables

* x_train, y_train, x_test, y_test, subject_train, and subject_test are extracted from donwloaded data
* x_data is composed of x_train and x_test, y_data is composed of y_train and y_test, and subject_data is composed of subject_train and subject_test 
* features contains the names for the x_data data set and are applied to the column names stored in mean_and_std_features
*activity_labels contains the names for the y_data data set and are applied to the column names stored in activites
* all_data merges x_data, y_data, and subject_data in a single data set.
* averages_results contains the averages and is written to averages_results.txt