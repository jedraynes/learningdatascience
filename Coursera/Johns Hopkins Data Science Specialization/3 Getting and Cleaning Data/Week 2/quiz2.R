setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\3 Getting and Cleaning Data\\Week 2")

# -----------------------
# question 1
install.packages("httpuv")

library(httr)
library(jsonlite)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "b7e762d5d6a313d144e2",
                   secret = "fe52166cbd3f20e39406bcbf4fbaa574a25dcd85"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# using JSON
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
jsonData[, c(3, 47)]

# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)

# -----------------------
# question 2
install.packages("sqldf")
library(sqldf)

# download file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url, "acs.csv", method = "curl")
acs <- read.csv("acs.csv")


sqldf("select pwgtp1 from acs where AGEP < 50")

# -----------------------
# question 3
unique(acs$AGEP) == sqldf("select distinct AGEP from acs")

# -----------------------
# question 4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[c(10, 20, 30, 100)])

# -----------------------
# question 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
df <- read.fwf(url, widths = c(12, 7, 4, 9, 4, 9, 4, 9, 4), skip = 4)
sum(df[, 4])
