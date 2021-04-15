# set working directory
setwd('C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\10 Data Science Capstone\\Capstone Project\\final\\en_US')

# question 1 -----
file.size('en_US.blogs.txt')/1024

# question 2 -----
length(readLines('en_US.twitter.txt'))

# question 3 -----
twitter <- readLines('en_US.twitter.txt')
news <- readLines('en_US.news.txt')
blogs <- readLines('en_US.blogs.txt')

l_twitter <- max(nchar(twitter))
l_news <- max(nchar(news))
l_blogs <- max(nchar(blogs))
as.data.frame(row.names = c('twitter', 'news', 'blogs'), c(l_twitter, l_news, l_blogs))

# question 4 -----
n_love <- length(grep('love', twitter))
n_hate <- length(grep('hate', twitter))
n_love / n_hate

# question 5 -----
grep('biostats', twitter, value = TRUE)

# question 6 -----
length(grep('A computer once beat me at chess, but it was no match for me at kickboxing', twitter))
