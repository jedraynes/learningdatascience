# set working directory
setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\4 Exploratory Data Analysis\\Week 4\\Project 2")

# load packages
library(ggplot2)
library(dplyr)

# load the data
NEI <- readRDS(".\\exdata_data_NEI_data\\summarySCC_PM25.rds")
SCC <- readRDS(".\\exdata_data_NEI_data\\Source_Classification_Code.rds")

# inspect the data
View(NEI)
View(SCC)

# inspect the structure of the data
str(NEI)
str(SCC)

# subset
selected_years <- c(1999:2008)
p2 <- subset(NEI, year %in% selected_years)
p2 <- subset(p2, fips == "24510")

# summarize the total emissions by year
p2 <- p2 %>% 
  group_by(year) %>%
  summarize(total = sum(Emissions))

# save as png object
png("plot2.png", width = 1080, height = 1080)

# plot
options(scipen = 5)
plot(p2, type = "b", pch = 19, col = "blue", xlab = "Year", ylab = "PM2.5 Emissions (in tons)")
title(main = "Total Emissions 1999 to 2008 for Baltimore, Maryland")

# close connection
dev.off()