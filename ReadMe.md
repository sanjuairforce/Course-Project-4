---
title: "ReadMe"
author: "Alvaro Sanjuan"
date: "9/27/2020"
output: pdf_document
---

## Step 0

First of all the untidy datasets are downloaded and imported into R using the ```data.frame::fread``` function. This includes the measurement data, the subject id and the activity id, for each the train and test populations.

Then, the data for each population is put together into two different datasets, **train_data** and **test_data**. For this the function ```cbind``` has been used.

## Step 1

Both **train_data** and **test_data** datasets are rowbinded together into **raw_data** using ```rbind```

## Step 2

We extract the columns which contain the desired measurements (subject id, activity id, mean and standard deviation) using data subsetting. The resulting is a new dataset named **extracted_data**. Then we temporarily label the column names as *V1*,*V2*,*V3*,*V4*. 

## Step 3

From the variable **V2**, we rename every value to get the activity names. 
```
extracted_data$v2[extracted_data$v2 == 1] <- 'walking'
extracted_data$v2[extracted_data$v2 == 2] <- 'walkingupstairs'
extracted_data$v2[extracted_data$v2 == 3] <- 'walkingdownstairs'
extracted_data$v2[extracted_data$v2 == 4] <- 'sitting'
extracted_data$v2[extracted_data$v2 == 5] <- 'standing'
extracted_data$v2[extracted_data$v2 == 6] <- 'laying'
```
## Step 4

We label the column names of **extracted_data** to have tidy names: 'Subject Number', 'Activity', 'Mean', 'SD'. Then we arrange the 'Subject Number' column in ascending order using:  
``` 
sorted_data <- arrange(extracted_data, `Subject Number`)
```
The result into a new data set named **sorted_data**.

## Step 5

We then split **sorted_data** by two groups, 'Subject Name' and 'Activity'. The function ```group_by``` has been used for this purpose and the result is stored in **groupedData**. Then we use: 
```
finalData <- summarise(groupedData, Avgmean = mean(Mean), Avgsd = mean(SD))

``` 
to get the average values of the two variables 'Mean' and 'SD', and we store the result in **finalData**. Finally, we write the tidy data set into a txt file using ``` write.table``` using default values.

