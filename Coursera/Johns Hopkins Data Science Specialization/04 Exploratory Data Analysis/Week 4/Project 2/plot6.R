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
motor_vehicle_codes <- subset(SCC, SCC.Level.Two == "Highway Vehicles - Gasoline")$SCC

# subset
cities <- c("24510", "06037")
p6 <- subset(NEI, SCC %in% motor_vehicle_codes & fips %in% cities)

# summarize the total emissions by year
p6 <- p6 %>% 
  # remap the fips to the respective city so the end user can visualize the trend better
  mutate(city = ifelse(fips == "24510", "Baltimore, MD", "Los Angeles, CA")) %>%
  group_by(year, city) %>%
  summarize(total = sum(Emissions))

# save as png object
png("plot6.png", width = 1080, height = 1080)

# plot
g <- ggplot(p6, aes(x = year, y = total, color = city))
g + 
  geom_point() + 
  geom_line() + 
  theme_bw() + 
  xlab("Year") + 
  ylab("PM2.5 Emissions (in tons)") + 
  ggtitle("Total Emissions 1999 to 2008 Baltimore vs Los Angeles from Motor Vehicles")

# close connection
dev.off()