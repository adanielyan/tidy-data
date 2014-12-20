library(data.table)
library(plyr)

#dir_name <- "data"
output_file_name <- "tidy_data.txt"
file_name <- "dataset.zip"

# if(!file.exists(dir_name) & (nchar(dir_name) > 0)) {
#   dir.create(dir_name)
# }

## Uncomment the code below to automate data download and unzip
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", file_name, "curl")

# # If file was successfully downloaded extract its content
# if(file.exists(file_name)) {
#  message('Unzipping data...')
#  unzip(file_name)
#  message('Done.')
# }
# # End of data download and unzip

# If file was successfully extracted perform the rest of operations
if(file.exists("UCI HAR Dataset")) {
  
  # Read test data
  message('Reading test data...')
  test_data <- read.table(file.path("UCI HAR Dataset/test/X_test.txt"), strip.white=TRUE)
  message('Done.')
  
  # Read train data
  message('Reading train data...')
  train_data <- read.table(file.path("UCI HAR Dataset/train/X_train.txt"), strip.white=TRUE)
  message('Done.')
  
  # Read subjects
  message('Reading subjects...')
  test_subjects <- read.table(file.path("UCI HAR Dataset/test/subject_test.txt"), strip.white=TRUE)
  train_subjects <- read.table(file.path("UCI HAR Dataset/train/subject_train.txt"), strip.white=TRUE)
  message('Done.')
  
  # Read activities
  message('Reading activities...')
  test_activities <- read.table(file.path("UCI HAR Dataset/test/y_test.txt"), strip.white=TRUE)
  train_activities <- read.table(file.path("UCI HAR Dataset/train/y_train.txt"), strip.white=TRUE)
  message('Done.')
  
  # Read activity labels
  message('Reading activity labels...')
  activity_labels <- read.table(file.path("UCI HAR Dataset/activity_labels.txt"), strip.white=TRUE)
  message('Done.')
  
  # Read variable names
  message('Reading variable names...')
  variable_names <- read.table(file.path("UCI HAR Dataset/features.txt"), strip.white=TRUE)
  message('Done.')
  
  # Extract only names we need
  message('Extracting only names we need...')
  columns_to_extract <- grep("mean\\(\\)|std\\(\\)", variable_names[,2])
  variable_names <- c("Subject", "Activity", as.vector(variable_names[columns_to_extract, 2]))
  message('Done.')
  
  # Merge datasets, subjects, and activities
  message('Merging datasets, subjects, and activities...')
  data <- rbind(test_data, train_data)
  activities <- rbind(test_activities, train_activities)
  subjects <- rbind(test_subjects, train_subjects)
  message('Done.')
  
  # Extract only the measurements on the mean and standard deviation.
  message('Extracting only the measurements on the mean and standard deviation...')
  data <- data[, columns_to_extract]
  message('Done.')
  
  # Replacing activities with activity labels
  message('Replacing activities with activity labels...')
  activities <- merge(activities, activity_labels)
  message('Done.')

  # Adding activities and subjects to the dataset
  message('Adding activities and subjects to the dataset.')
  data <- cbind(subjects, activities[, 2], data)
  message('Done.')
  
  # Naming columns
  colnames(data) <- variable_names
  
  # Creating tidy_data
  message('Creating tidy_data data.frame...')
  tidy_data <- ddply(data, .(Subject, Activity), numcolwise(mean))
  message('Done.')
  
  message('Writing tidy_data content to "tidy_data.txt file."')
  write.table(tidy_data, file='tidy_data.txt', row.names=FALSE)
  message('tidy_data.txt file was successfully created!')
  
} else {
  message('Folder "UCI HAR Dataset" was not found in working directory.')
}
