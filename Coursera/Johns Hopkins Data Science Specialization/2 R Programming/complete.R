setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\2 R Programming")


complete <- function(directory, id = 1:332) {
  result <- data.frame(id=NA, nobs=NA)

  for (i in id) {
    path <- paste(getwd(), "\\", directory, "\\", sprintf("%03d", i), ".csv", sep = "")
    data <- read.csv(path, header = TRUE)
    number <- sum(complete.cases(data))
    append_df <- data.frame(id = i, nobs = number)
    result <- rbind(result, append_df)
  }
  result[complete.cases(result),]
}

