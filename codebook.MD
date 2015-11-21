#Codebook to run_analysis.R

The script follows the steps listed in the assignment: 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To start with, the script loads the package 'dplyr' 
Then the working directory is set. This is a specific working directory for my system, it should be edited if the script is to be run on a different system.

The files containing the activity labels and the features are loaded individually into dataframes.
The data from the train and test direcories is loaded in two dataframes, trainingdata and testdata.

The data from x_train.txt and x_test.txt is combined in one dataframe, Dataset, by using rbind()
This is repeated for  y_train.txt and y_test.txt (into Activity) and subject_train.txt and subtject_test.txt (into Subject).

Since only nean and standard deviation data is required, those features with 'Mean' or 'std' in the name are filtered from the features and loaded into a new dataframe.
The first column from the dataframe is used to select the relevant columns from the dataframe containing the measurements.

In order to represent the activity names in the final dataset the dataset Activity is merged with the dataset activity_label. This produces a dataframe containing the activity_labels on the rows corresponding to the individual measurement.
The column containing the activity labels per measurement is added to the Dataset dataframe by cbind() and the name of the column is set .

In order to correctly label the measurements the feature descriptions are added to the Dataset with the name for the Activity column hardcoded.

Then a second dataset is created, the subjects are added. 

By aggregating the dataset by Subject and Activity and applying the function mean the average values are calculated per group of subject and activityty.
