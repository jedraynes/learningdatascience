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

# create datetime
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format = "%Y-%m-%d %H:%M:%S")

# convert to numeric
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

# save as png file
png("plot3.png", width = 480, height = 480)

# create plot
with(df, plot(DateTime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", col = "black"))
with(df, lines(DateTime, Sub_metering_2, col = "red"))
with(df, lines(DateTime, Sub_metering_3, col = "blue"))
with(df, legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1))

# close file
dev.off()