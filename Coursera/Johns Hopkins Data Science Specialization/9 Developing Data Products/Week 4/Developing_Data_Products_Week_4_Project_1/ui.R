#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Plotting BTC, ETH, and SPY"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectizeInput("ticker", 
                           "Select one or more tickers:", 
                           choices = c('BTC', 
                                       'ETH', 
                                       'SPY'), 
                           selected = 'SPY', 
                           multiple = TRUE), 
            dateRangeInput('daterange', 
                           'Input date range:', 
                           start = as.Date('2016-04-02', '%Y-%m-%d'), 
                           end = as.Date('2021-04-02', '%Y-%m-%d'), 
                           min = as.Date('2016-04-02', '%Y-%m-%d'), 
                           max = as.Date('2021-04-02', '%Y-%m-%d'))

        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotlyOutput("plot1"),
            textOutput('return_max')
        )
    )
))
