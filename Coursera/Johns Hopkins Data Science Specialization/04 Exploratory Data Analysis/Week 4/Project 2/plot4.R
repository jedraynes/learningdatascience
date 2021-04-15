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

# subset SCC
coal_codes <- subset(SCC, EI.Sector == "Fuel Comb - Comm/Institutional - Coal")$SCC

# subset
p4 <- subset(NEI, SCC %in% coal_codes)

# summarize the total emissions by year
p4 <- p4 %>% 
  group_by(year) %>%
  summarize(total = sum(Emissions))

# save as png object
png("plot4.png", width = 1080, height = 1080)

# plot
g <- ggplot(p4, aes(x = year, y = total))
g + 
  geom_point(color = "blue") + 
  geom_line(color = "grey") + 
  theme_bw() + 
  xlab("Year") + 
  ylab("PM2.5 Emissions (in tons)") + 
  ggtitle("Total Emissions 1999 to 2008 for the United States from Coal Combustion Sources")

# close connection
dev.off()