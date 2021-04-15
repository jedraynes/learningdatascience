# set working directory
setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\4 Exploratory Data Analysis\\Week 1\\Project 1")

# load packages
# library(ggplot2)
library(lubridate)
library(dplyr)

# load and view the data
hpc <- read.table(".\\Data\\household_power_consumption.txt", sep = ";", header = TRUE)
hpc$Date <- dmy(hpc$Date)

# subset the date range
df <- hpc %>% filter(Date <= "2007-02-02" & Date >= "2007-02-01")

# convert global active power to numeric
df$Global_active_power <- as.numeric(df$Global_active_power)

# save as png file
png("plot1.png", width = 480, height = 480)

# plot the histogram using the base package
with(df, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

# close file
dev.off()
