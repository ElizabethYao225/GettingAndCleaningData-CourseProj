# CodeBook of the code describing the variables and information of the project 

## the URL and downloading as well as the unzipping of the file of the data. This data within the file comes from data collected from accelerometers from Samsung smartphones
ProjUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(ProjUrl, destfile = "getdata_projectfiles_UCI HAR Dataset.zip", method = "curl")


unzip("getdata_projectfiles_UCI HAR Dataset.zip")

## the features variable specifies the features.txt file within the data within the file
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
## the activity_labels variable specifies the activity labels data within the file
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = "subject")
## the subject_test variable specifies the subject test data within the file
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
## the x_test variable specifies the x test data within the file
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
## the y_test variable specifies the y test data within the file
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
## the subject_train variable specifies the subject train data within the file
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
## the x_train variable specifies the x train data within the file
x_train <- read.table("UCI HAR Dataset/train/x_train.txt", col.names = features$functions)
## the y_train variable specifies the y train data within the file
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")



## each of the following variables represent the combination of the earlier objects with common variables 
all_x <- rbind(x_train, x_test)
all_y <- rbind(y_train, y_test)
all_subject <- rbind(subject_train, subject_test)
all_merged <- cbind(all_subject, all_y, all_x)


## this variable represents the fully combined data's mean and standard deviation
tidied_data <- all_merged %>% select(subject, code, contains("mean"), contains("std"))

## represents the relabeling of the tidied data
tidied_data$code <- activity_labels[tidied_data$code, 2]

## the new names wihtin thin each of the variables within the data set
names(tidied_data) [2] = "activity"
names(tidied_data) <- gsub("Acc", "Accelerometer", names(tidied_data))
names(tidied_data) <- gsub("Gyro", "Gyroscope", names(tidied_data))
names(tidied_data) <- gsub("BodyBody", "Body", names(tidied_data))
names(tidied_data) <- gsub("Mag", "Magnitude", names(tidied_data))
names(tidied_data) <- gsub("^t", "Time", names(tidied_data))
names(tidied_data) <- gsub("^f", "Frequency", names(tidied_data))
names(tidied_data) <- gsub("tBody", "TimeBody", names(tidied_data))
names(tidied_data) <- gsub("-mean()", "Mean", names(tidied_data), ignore.case = TRUE)
names(tidied_data) <- gsub("-std()", "STD", names(tidied_data), ignore.case = TRUE)
names(tidied_data) <- gsub("-freq()", "Frequency", names(tidied_data), ignore.case = TRUE)
names(tidied_data) <- gsub("angle", "Angle", names(tidied_data))
names(tidied_data) <- gsub("gravity", "Gravity", names(tidied_data))


## this is a new and independent data set 
completed_data <- tidied_data %>%
  group_by(subject, activity) %>% 
  summarise_all(funs(mean))
write.table(completed_data, "CompleteData.txt", row.name = FALSE)


## the final command which checks the work above
str(completed_data)
