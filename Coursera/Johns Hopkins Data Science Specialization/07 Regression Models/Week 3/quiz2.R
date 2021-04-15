# step 1
install.packages("devtools")
devtools::install_github("jhudsl/collegeIncome")
library(collegeIncome)
data(college)
devtools::install_github("jhudsl/matahari")
library(matahari)

# start


# analysis -----

# load libraries and setup
library(dplyr)
library(ggplot2)
options(scipen = 100000)

# inspect data
head(college)
unique(college$major_category)

# initial plot
ggplot(college, aes(x = median, y = major_category, color = major_category)) + 
  geom_boxplot() + 
  theme_classic()

'''
At first glance, Business has the highest maximum point into the six-figure area but Physical Sciences has the highest median.
'''

# one factor I'd like to consider is unemployment within the major categories

# created df
df1 <- college %>%
  group_by(major_category) %>%
  summarize(mean_income = mean(median), 
            mean_unemployed = mean(perc_employed))

# plot
ggplot(df1, aes(x = mean_unemployed, y = major_category)) + 
  geom_bar(stat = 'identity', fill = 'steelblue') + 
  geom_text(aes(label = round(mean_unemployed, 2)), hjust = 1.1) + 
  theme_classic()

'''
Unemployment rates are fairly similar regardless of major with the exception being social science.
'''

# initial regression
fit <- lm(median ~ major_category, data = college)
summary(fit)
plot(fit)

'''
There are some outliers looking at the plots. Let\'s remove some points.
'''
# next regression
df2 <- college[-c(16, 63, 81), ]
fit2 <- lm(median ~ major_category, data = df2)
summary(fit2)
plot(fit2)

# box plot
ggplot(df2, aes(x = median, y = major_category, color = major_category)) + 
  geom_boxplot() + 
  theme_classic()

'''
Based on the visual, and it appears some majors have increased income values compared to other majors. For example, Physical Sciences has the highest median income and more downside but Business, with a lower median, has a higher upside. I believe, college major category, barring any external factors has a significant association with income. 
'''


