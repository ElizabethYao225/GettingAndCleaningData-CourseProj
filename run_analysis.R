ProjUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(ProjUrl, destfile = "getdata_projectfiles_UCI HAR Dataset.zip", method = "curl")


unzip("getdata_projectfiles_UCI HAR Dataset.zip")


features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = "subject")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/x_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")



#merging to create one data set 
all_x <- rbind(x_train, x_test)
all_y <- rbind(y_train, y_test)
all_subject <- rbind(subject_train, subject_test)
all_merged <- cbind(all_subject, all_y, all_x)


#extracting mean and SD for each measurement 
tidied_data <- all_merged %>% select(subject, code, contains("mean"), contains("std"))

#naming activities in the data set 
tidied_data$code <- activity_labels[tidied_data$code, 2]

#labeling data set with variable names 
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


#second independent tidy data set with averages
completed_data <- tidied_data %>%
  group_by(subject, activity) %>% 
  summarise_all(funs(mean))
write.table(completed_data, "CompleteData.txt", row.name = FALSE)



str(completed_data)

