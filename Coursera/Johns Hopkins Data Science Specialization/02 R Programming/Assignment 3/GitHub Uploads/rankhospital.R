# import dplyr to use the arrange function
library(dplyr)

# Set the working directory to the location of my assignment files
setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\2 R Programming\\Assignment 3")

# Read the file and inspect the file
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

###  FINDING THE BEST HOSPITAL IN A STATE
rankhospital <- function(state, outcome, num) {
  
  # Read the outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Check the state and outcome are valid
  if (sum(df == state) <= 0) {
    stop("invalid state")
  
  } else if (!is.element(outcome, c("heart failure", "heart attack", "pneumonia"))) {
    stop("invalid outcome")
  
  } else if (outcome == "heart failure") {
    # Return the best ranking hospital - heart failure
    df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
    pop <- subset(df, State == state, c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
    pop <- na.omit(pop)
    names(pop) <- c("Name", "Rate")
    pop <- pop %>% arrange(pop$Rate, pop$Name)

  
  } else if (outcome == "heart attack") {
    # Return the best ranking hospital - heart attack
    df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
    pop <- subset(df, State == state, c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
    pop <- na.omit(pop)
    names(pop) <- c("Name", "Rate")
    pop <- pop %>% arrange(pop$Rate, pop$Name)

  } else if (outcome == "pneumonia") {
    # Return the best ranking hospital - pneumonia
    df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
    pop <- subset(df, State == state, c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
    pop <- na.omit(pop)
    names(pop) <- c("Name", "Rate")
    pop <- pop %>% arrange(pop$Rate, pop$Name)

  }
  # if conditions to return worst if worst, best if best, NA if invalid, or the selection if a valid integer is passed
  if (num == "worst") {
    pop <- pop %>% arrange(-pop$Rate, pop$Name)
    pop[1, 1]
  } else if (num == "best") {
    pop <- pop %>% arrange(pop$Rate, pop$Name)
    pop[1, 1]    
  } else if (nrow(pop) < num) {
    print(NA)
  } else if (num == 0) {
    print(NA)
  } else {
    pop[num, 1]
  }
}

# Test cases
rankhospital("TX", "heart failure", 4)
rankhospital("MD", "heart attack", "worst")
rankhospital("MN", "heart attack", 5000)

# quiz cases
rankhospital("NC", "heart attack", "worst")
rankhospital("WA", "heart attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)