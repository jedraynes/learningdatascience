# install packages
install.packages("readxl")
install.packages("XML")
install.packages("data.table")

# load libraries
library(dplyr)
library(readxl)
library(XML)
library(data.table)

# set working director
setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\3 Getting and Cleaning Data\\Week 1")

# questions 1 and 2
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, "2006housing.csv")
df <- read.csv("2006housing.csv")
head(df)
q1 <- df %>% filter(VAL == 24)
nrow(q1)
q1$FES

# question 3
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url, "NGAP.xlsx", method = "curl")
dat <- read_excel("NGAP.xlsx", skip = 17)
dat <- dat[1:5,]
dat$Zip <- as.numeric(dat$Zip)
dat$Ext <- as.numeric(dat$Ext)
sum(dat$Zip*dat$Ext,na.rm=T)

# question 4
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(url, useInternal = TRUE)
rootNode <- xmlRoot(doc)
zipcodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
df <- data.frame(zip = zipcodes)
nrow(df %>% filter(zip == 21231))

# questions 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
# download.file(url, "2006microdata.csv")
DT <- fread(url)

system.time(rowMeans(DT[DT$SEX==1]), rowMeans(DT[DT$SEX==2]))
system.time(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))


