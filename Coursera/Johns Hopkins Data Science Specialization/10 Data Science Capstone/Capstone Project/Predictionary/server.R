#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(tidyverse)
library(ggplot2)


# read in the dictionary
dictionary <- fread('data/allgrams_dictionary.csv')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # calc table upon submission button
    table_result <- eventReactive(input$submit, {
        
        # set seed
        set.seed(1337)
        
        # prevent scientific notation
        options(scipen=10000)
        
        # function to process the string input
        text_process <- function(str) {
            str %>% 
                tolower() %>% 
                str_remove_all('[[:punct:]]') %>%
                str_remove_all('[^[:ascii:]]') %>%
                str_remove_all('[\\$]') %>%
                str_remove_all('[[:digit:]]') %>%
                str_trim() %>%
                str_squish()
        }
        
        # prediction functions
        dict_predict <- function(input, penalty = 1) {
            dict_predict <- dictionary %>% 
                filter(stem == input) %>% 
                mutate(score = score * penalty) %>%
                select(end, score)
        }
        
        # trigram predict
        tri_predict <- function(df) {
            # full score trigram predictions
            predictions <- rbind(predictions, dict_predict(word(processed_input, count - 1, count)))
            ## penalized bigram predictions
            predictions <- rbind(predictions, dict_predict(word(processed_input, count, count), 0.40))
            ## penalized unigram predictions
            predictions <- rbind(predictions, dict_predict('unigram', 0.40 * 0.40))
            ## remove the possibility of same-result predictions
            predictions <- predictions[predictions$end != word(processed_input, count, count), ]
        }
        
        # bigram predict
        bi_predict <- function(df) {
            ## full score bigram predictions
            predictions <- rbind(predictions, dict_predict(word(processed_input, count - 1, count)))
            ## penalized unigram predictions
            predictions <- rbind(predictions, dict_predict('unigram', 0.40))
            ## remove the possibility of same-result predictions
            predictions <- predictions[predictions$end != word(processed_input, count, count), ]
        }
        
        # unigram predict
        uni_predict <- function(df) {
            ## full score unigram predictions
            predictions <- rbind(predictions, dict_predict('unigram'))
            ## remove the possibility of same-result predictions
            predictions <- predictions[predictions$end != word(processed_input, count, count), ]
        }
        
        # validate for blank input
        validate(need(input$user_input != '', 'Please enter a text string of at least length one.'))
        
        # clean the user input
        processed_input <- text_process(input$user_input)

        # length of the input string
        count <- str_count(processed_input, '\\S+')
        
        # initialize empty data table to hold our results
        predictions <- data.table(end = character(), score = numeric())
        
        # model
        if (count >= 3) {
            predictions <- tri_predict(predictions)
        } else if (count > 1) {
            predictions <- bi_predict(predictions)
        } else {
            predictions <- uni_predict(predictions)
        }
        
        predictions <- head(predictions, input$return_length)
        
        # add rank
        predictions <- cbind(Rank = 1:input$return_length, predictions)
        predictions <- predictions %>% rename(Word = end, Score = score)


    })
    # output for table
    output$result <- renderTable({
        table_result <- table_result()
    })
    # event reactive for plot
    plot_result <- eventReactive(input$submit, {
        ggplot(table_result(), aes(x = reorder(Word, Score), y = Score)) + 
            geom_bar(stat = 'identity', color = 'black', fill = 'cadetblue') + 
            xlab('Predicted Word') + 
            ylab('Score') + 
            ggtitle('Predicted Word') + 
            labs(caption = 'Predictions sourced from corpora provided by JHU/SwiftKey') + 
            coord_flip() + 
            theme_classic() + 
            theme(plot.title = element_text(size = 14, face = 'bold'),
                  plot.caption = element_text(size = 9, face = 'italic'), 
                  plot.background = element_rect(fill = 'transparent'), 
                  panel.background = element_rect(fill = 'transparent'), 
                  panel.border = element_blank(), 
                  panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank())
    })
    # output for plot
    output$result_plot <- renderPlot({
        plot_result()
    }, bg = 'transparent')

    
    
    

})
