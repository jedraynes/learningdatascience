setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\2 R Programming")


pollutantmean <- function(directory, pollutant, id = 1:332) {
  means <- c()
  for (monitor in id) {
    path <- paste(getwd(), "\\", directory, "\\", sprintf("%03d", monitor), ".csv", sep = "")
    data <- read.csv(path)
    spec <- data[pollutant]
    means <- c(means, spec[!is.na(spec)])
  }
  mean(means)
}
