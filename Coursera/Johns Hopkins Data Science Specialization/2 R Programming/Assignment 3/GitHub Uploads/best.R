# Set the working directory to the location of my assignment files
setwd("C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\2 R Programming\\Assignment 3")

# Read the file and inspect the file
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
ncol(outcome)
names(outcome)

### 1 PLOT THE 30-DAY MORTALITY RATES FOR HEART ATTACK

# Histogram of 30-day death rates from heart attacks
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])


unique(outcome$State)

### 2 FINDING THE BEST HOSPITAL IN A STATE
best <- function(state, outcome) {
  result <- c()
  
  # Read the outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  #df <- df[complete.cases(df),]
  
  # Check the state and outcome are valid
  if (sum(df == state) <= 0) {
    stop("invalid state")
  } else if (!is.element(outcome, c("heart failure", "heart attack", "pneumonia"))) {
    stop("invalid outcome")
  } else if (outcome == "heart failure") {
    # Return the best ranking hospital - heart failure
    df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
    pop <- subset(df, State == state, c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
    pop <- pop[complete.cases(pop),]
    minimum <- min(pop$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
    result <- subset(pop, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == minimum, Hospital.Name)
  } else if (outcome == "heart attack") {
    # Return the best ranking hospital - heart attack
    df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
    pop <- subset(df, State == state, c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
    pop <- pop[complete.cases(pop),]
    minimum <- min(pop$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
    result <- subset(pop, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == minimum, Hospital.Name)
  } else if (outcome == "pneumonia") {
    # Return the best ranking hospital - pneumonia
    df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(df$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
    pop <- subset(df, State == state, c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
    pop <- pop[complete.cases(pop),]
    minimum <- min(pop$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
    result <- subset(pop, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == minimum, Hospital.Name)
  }
  result
}


# Test cases
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")
best("NY", "hert attack")

# quiz cases
best("SC", "heart attack")
best("NY", "pneumonia")
best("AK", "pneumonia")