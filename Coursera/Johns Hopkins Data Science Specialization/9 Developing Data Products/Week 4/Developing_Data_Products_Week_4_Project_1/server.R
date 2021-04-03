#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

suppressPackageStartupMessages(pacman::p_load(shiny, 
                                              ggplot2, 
                                              plotly))

# setwd
#setwd('C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\9 Developing Data Products\\Week 4\\Developing_Data_Products_Week_4_Project_1\\data')

# load data
project1_data <- read.csv('data/project1_data.csv')
project1_data$Date <- as.Date(project1_data$Date, format = '%Y-%m-%d')
                  
str(project1_data)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$plot1 <- renderPlotly({

        
        # set date max and min
        date_min <- input$daterange[1]
        date_max <- input$daterange[2]
        
        # subset based on ticker and date
        plot_df <- project1_data %>%
            filter(Date >= date_min, 
                   Date <= date_max, 
                   variable %in% input$ticker)
        
        # plot
        ggplotly(ggplot(plot_df) +
                      geom_line(aes(x = Date, y = value, color = variable)) +
                      xlab('Date') +
                      ylab('Value ($)') +
                      theme_bw() +
                      theme(panel.background = element_blank(),
                            panel.grid.major = element_blank(),
                            panel.grid.minor = element_blank(), 
                            legend.position = 'bottom', 
                            legend.title = element_blank(), 
                              plot.title = element_text(face = 'bold', hjust = 0.5)))
        
            

    })
    output$return_max <- reactive({
        
        # set date max and min
        date_min <- input$daterange[1]
        date_max <- input$daterange[2]
        
        # subset based on ticker and date
        plot_df <- project1_data %>%
            filter(Date >= date_min, 
                   Date <= date_max, 
                   variable %in% input$ticker)
        
        # calculate
        paste('The highest value in your plot is:', round(max(plot_df$value), 2))
        
        
        
    })

})
