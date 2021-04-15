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
df$datetime <- as.POSIXct(paste(df$Date, df$Time), format = "%Y-%m-%d %H:%M:%S")

# convert global active power to numeric
df$Global_active_power <- as.numeric(df$Global_active_power)

# convert voltage to numeric
df$Voltage <- as.numeric(df$Voltage)

# convert submetering to numeric
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

# convert global reactive power to numeric
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)


# save as png file
png("plot4.png", width = 480, height = 480)

# attach df
attach(df)

# set the plot area
par(mfrow = c(2,2))

# plot 1
plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")

# plot 2
plot(datetime, Voltage, type = "l")

# plot 3
plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", col = "black")
lines(datetime, Sub_metering_2, col = "red")
lines(datetime, Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = "n")

# plot 4
plot(datetime, Global_reactive_power, type = "l", lwd = .5)

# close file
dev.off()