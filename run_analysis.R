library(data.table)
library(dplyr)

X_train <- data.table::fread('./UCI HAR Dataset/train/X_train.txt')
y_train <- data.table::fread('./UCI HAR Dataset/train/y_train.txt')
subject_train <- data.table::fread('./UCI HAR Dataset/train/subject_train.txt')

X_test  <- data.table::fread('./UCI HAR Dataset/test/X_test.txt')
y_test  <- data.table::fread('./UCI HAR Dataset/test/y_test.txt')
subject_test <- data.table::fread('./UCI HAR Dataset/test/subject_test.txt')

train_data <- cbind(subject_train, y_train, X_train)
test_data  <- cbind(subject_test, y_test, X_test)
# Step 1:
raw_data   <- rbind(train_data, test_data)

# Step 2:
extracted_data <- raw_data[,c(1, 2, 201, 202)]
colnames(extracted_data) <- c('v1', 'v2', 'v3', 'v4')

# Step 3:
extracted_data$v2[extracted_data$v2 == 1] <- 'walking'
extracted_data$v2[extracted_data$v2 == 2] <- 'walkingupstairs'
extracted_data$v2[extracted_data$v2 == 3] <- 'walkingdownstairs'
extracted_data$v2[extracted_data$v2 == 4] <- 'sitting'
extracted_data$v2[extracted_data$v2 == 5] <- 'standing'
extracted_data$v2[extracted_data$v2 == 6] <- 'laying'

# Step 4:
colnames(extracted_data) <- c('Subject Number', 'Activity', 'Mean', 'SD')
sorted_data <- arrange(extracted_data, `Subject Number`)

# Step 5: 
groupedData <- group_by(sorted_data, `Subject Number`, Activity)
finalData <- summarise(groupedData, Avgmean = mean(Mean), Avgsd = mean(SD))
tidyData <- write.table(finalData, 'tidydata.txt', row.names = FALSE)
        
