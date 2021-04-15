#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(tidyverse)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # custom css
    includeCSS('www/custom_css.css'),
    
    # Application title
    titlePanel("Predictionary"),
    h6('jedraynes'),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            textInput('user_input', 'String Input'),
            sliderInput("return_length",
                        "Number of Predictions",
                        min = 1,
                        max = 10,
                        value = 3), 
            actionButton('submit', 'Submit')
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = 'tabs', 
                        tabPanel('Plot', plotOutput('result_plot')),
                        tabPanel('Table', tableOutput('result'))
            
        )
    )
)))
