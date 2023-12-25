# Load the xlsx package to read Excel files
library(xlsx)

# Import an Excel file named "data.xlsx" from the current working directory
# Assume the file has a header row and the data is in the first sheet
data <- read.xlsx("data.xlsx", sheetIndex = 1, header = TRUE)

# View the first six rows of the data frame
head(data)

# Get the number of rows and columns of the data frame
dim(data)

# Get the names of the variables in the data frame
names(data)

# Subset the data frame by selecting only the rows where the variable "gender" is equal to "female"
data_female <- data[data$gender == "female", ]

# Subset the data frame by selecting only the columns "age", "height", and "weight"
data_subset <- data[, c("age", "height", "weight")]

# Create a new variable named "bmi" that is the ratio of weight (in kg) to height (in m) squared
data$bmi <- data$weight / (data$height / 100)^2

# Recode the variable "gender" from "male" and "female" to "M" and "F"
data$gender <- recode(data$gender, "male" = "M", "female" = "F")

# Change the reference level of the factor variable "gender" from "F" to "M"
data$gender <- relevel(data$gender, ref = "M")

# Rename the variable "bmi" to "BMI"
names(data)[names(data) == "bmi"] <- "BMI"

# Remove the rows with missing values in any variable
data_complete <- na.omit(data)

# Impute the missing values in the variable "BMI" with the mean value of the non-missing values
data$BMI[is.na(data$BMI)] <- mean(data$BMI, na.rm = TRUE)

# Scale the variables "age", "height", and "weight" to have zero mean and unit variance
data_scaled <- scale(data[, c("age", "height", "weight")])

# Create a date variable from year, month, and day variables
data$date <- as.Date(paste(data$year, data$month, data$day, sep = "-"))

# Extract the year, month, and day from the date variable
data$year <- format(data$date, "%Y")
data$month <- format(data$date, "%m")
data$day <- format(data$date, "%d")

# Export the data frame as a CSV file named "data_modified.csv" to the current working directory
write.csv(data, file = "data_modified.csv", row.names = FALSE)
