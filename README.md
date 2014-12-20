# Getting and Cleaning Data Course Project

The "run_analysis.R" file has an R code that reads data from "UCI HAR Dataset" folder and processes it in order to create a tidy_data dataset that will contain average values for mean() and std() fields of the original dataset.

If data folder was found the following operations are performed:

- Read test data
- Read train data
- Read subjects
- Read activities
- Read activity labels
- Read variable names
- Extract only names we need
- Merge datasets, subjects, and activities
- Extract only the measurements on the mean and standard deviation.
- Replacing activities with activity labels
- Adding activities and subjects to the dataset
- Naming columns
- Creating tidy_data
- Writing tidy_data content to "tidy_data.txt" file.
