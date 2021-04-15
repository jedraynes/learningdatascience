# set the working directory
setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\3 Getting and Cleaning Data\\Week 4")

#load dplyr
library(dplyr)

# question 1 ----------
# download and read the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, "2006acs.csv", method = "curl")
acs <- read.csv("2006acs.csv")

# strsplit and return the 123rd element of the list
splitNames <- strsplit(names(acs), "wgtp")
splitNames[[123]]

# question 2 ----------
# download and read the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, "gdp.csv", method = "curl")
gdp <- read.csv("gdp.csv", skip = 4)

# select the columns we want and rename the columns
gdp <- gdp[, c(1, 2, 4, 5)]
names(gdp) <- c("CountryCode", "Rank", "Economy", "USDm")

# parse the values for any non digit and return the average of the first 190
values <- gsub("\\D", "", gdp$USDm)
values <- as.numeric(values)
mean(values[1:190], na.rm = TRUE)

# question 3 ----------
# regex to count if it starts with United and then return the count
countUnited <- grep("^United", gdp$Economy)
length(countUnited)

# question 4 ----------
# download and read the second file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url, "FEDSTATS.csv", method = "curl")
fed_stats <- read.csv('FEDSTATS.csv', header = TRUE)

merged_df <- inner_join(gdp, fed_stats, by = "CountryCode")
View(merged_df)

merged_df$Special.Notes <- tolower(merged_df$Special.Notes)
has_fye <- grep("fiscal year end", merged_df$Special.Notes)
has_fye_list <- merged_df$Special.Notes[has_fye]
length(grep("june", has_fye_list))

# question 5 ----------
# load package
# install.packages("quantmod")
library(quantmod)

# get AMZN
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# how many in 2012
all_2012 <- sampleTimes[year(sampleTimes) == 2012]
length(all_2012)

# how many on Monday in 2012
all_monday_in_2012 <- all_2012[wday(all_2012) == 2]
length(all_monday_in_2012)
