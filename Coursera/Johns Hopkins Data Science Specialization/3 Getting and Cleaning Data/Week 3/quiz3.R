# set the working directory
setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\3 Getting and Cleaning Data\\Week 3")

#load dplyr
library(dplyr)

# question 1 ----------
# download and read the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, "2006acs.csv", method = "curl")
acs <- read.csv("2006acs.csv")

# mutate the new column and sort by true
acs <- acs %>% mutate(agricultureLogical = if_else(ACR == 3 & AGS == 6, TRUE, FALSE))
which(acs[, 189])[1:3]

# question 2 ----------
# install and load packages
install.packages("jpeg")
library(jpeg)

# download and read the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url, "jeff.jpg", method = "curl")
df <- readJPEG('jeff.jpg', native = TRUE)

# 30th and 80th quantiles
quantile(df, probs = c(0.30, 0.80))

# question 3 ----------
# download and read the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, "FGDP.csv", method = "curl")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url, "FEDSTATS.csv", method = "curl")

# load the two dataframes and rename the columns for df1
df1 <- read.csv('FGDP.csv', header = TRUE, skip = 4)
df2 <- read.csv('FEDSTATS.csv', header = TRUE)

# transform df1
df1 <- df1[, c(1, 2, 4, 5)]
names(df1) <- c("CountryCode", "Ranking", "Economy", "USD")
df1$Ranking <- as.numeric(df1$Ranking)

# merge the two dfs and sort by desc ranking
df <- inner_join(df1, df2, by = "CountryCode")
df <- df %>% arrange(-Ranking)

# 13th entry
df[13, ]

# matching entries
sum(!is.na(df$Ranking))

# question 4 ----------
# mean ranking by income group
df %>% group_by(Income.Group) %>% summarize(mean(Ranking, na.rm = TRUE))

# question 5 ----------
# count where it's top 38 and lower middle income
df5 <- df %>% filter(Income.Group == "Lower middle income" & Ranking <= 38)
nrow(df5)

# using cut and in a table format
df$group <- cut(df$Ranking, breaks = quantile(df$Ranking, probs = c(0, 0.2, 0.4, 0.6, 0.8, 1), na.rm = TRUE))
table(df$group, df$Income.Group)

