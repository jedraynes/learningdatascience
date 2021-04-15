###
# Coursera's Johns Hopkins Data Science Specialization R Programming
# Assignment 3
# jedraynes
###

# import dplyr to use the arrange function
library(dplyr)

# Set the working directory to the location of my assignment files
setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\2 R Programming\\Assignment 3")


###  FINDING THE BEST HOSPITAL IN A STATE
rankall <- function(outcome, num) {
  
  # Read the outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # define all states
  all_states <- unique(df$State)

  # initialize the result DF
  result <- data.frame(hospital = c(NA),
                       state = c(all_states))
  # convert the mortality rates to numeric
  df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
  df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
  df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
  
  # subset the entire dataframe to the columns we want
  df <- df[, c(2, 7, 11, 17, 23)]
  
  # rename the columns
  names(df) <- c("Name", "State", "Attack", "Failure", "Pneumonia")
  
  # select population based on the outcome and sort by rate, state, then hospital name ascending
  if (!is.element(outcome, c("heart failure", "heart attack", "pneumonia"))) {
    result <- NA
  } else if (outcome == "heart attack") {
    df <- df[, c(1, 2, 3)]
    df <- na.omit(df)
    df <- df %>% arrange(df$Attack, df$State, df$Name)
  } else if (outcome == "heart failure") {
    df <- df[, c(1, 2, 4)]
    df <- na.omit(df)
    df <- df %>% arrange(df$Failure, df$State, df$Name)
  } else if (outcome == "pneumonia") {
    df <- df[, c(1, 2, 5)]
    df <- na.omit(df)
    df <- df %>% arrange(df$Pneumonia, df$State, df$Name)
  }
  
  # loop over each state, get the hospital and update the result dataframe
  if (outcome == "heart attack") {
    for (x in all_states) {
      sub_df <- df %>% filter(df$State == x)
      if (num == "worst") {
        sub_df <- sub_df %>% arrange(-sub_df$Attack, sub_df$State, sub_df$Name)
        result$hospital[result$state == x] <- sub_df[1, 1]
      } else if (num == "best") {
        sub_df <- sub_df %>% arrange(sub_df$Attack, sub_df$State, sub_df$Name)
        result$hospital[result$state == x] <- sub_df[1, 1]
      } else {
        result$hospital[result$state == x] <- sub_df[num, 1]
      }
    }
  } else if (outcome == "heart failure") {
    for (x in all_states) {
      sub_df <- df %>% filter(df$State == x)
      if (num == "worst") {
        sub_df <- sub_df %>% arrange(-sub_df$Failure, sub_df$State, sub_df$Name)
        result$hospital[result$state == x] <- sub_df[1, 1]
      } else if (num == "best") {
        sub_df <- sub_df %>% arrange(sub_df$Failure, sub_df$State, sub_df$Name)
        result$hospital[result$state == x] <- sub_df[1, 1]
      } else {
        result$hospital[result$state == x] <- sub_df[num, 1]
      }
    }
  } else if (outcome == "pneumonia") {
    for (x in all_states) {
      sub_df <- df %>% filter(df$State == x)
      if (num == "worst") {
        sub_df <- sub_df %>% arrange(-sub_df$Pneumonia, sub_df$State, sub_df$Name)
        result$hospital[result$state == x] <- sub_df[1, 1]
      } else if (num == "best") {
        sub_df <- sub_df %>% arrange(sub_df$Pneumonia, sub_df$State, sub_df$Name)
        result$hospital[result$state == x] <- sub_df[1, 1]
      } else {
        result$hospital[result$state == x] <- sub_df[num, 1]
      }
    }
  }
  
  # sort the final result set by the state and return the result dataframe
  result <- result %>% arrange(result$state)
  result
}

# Test cases
head(rankall(outcome = "heart attack", num = 20), 10)
tail(rankall("pneumonia", "worst"), 3)
tail(rankall("heart failure"), 10)

# quiz cases
r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)

r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)
