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
p3 <- subset(NEI, fips == "24510")

# summarize the total emissions by year
p3 <- p3 %>% 
  group_by(year, type) %>%
  summarize(total = sum(Emissions))

# save as png object
png("plot3.png", width = 1080, height = 1080)

# plot
g <- ggplot(p3, aes(x = year, y = total, color = type))
g + 
  geom_point() + 
  geom_line() + 
  theme_bw() + 
  xlab("Year") + 
  ylab("PM2.5 Emissions (in tons)") + 
  ggtitle("Total Emissions 1999 to 2008 for Baltimore, Maryland by Type")

# close connection
dev.off()