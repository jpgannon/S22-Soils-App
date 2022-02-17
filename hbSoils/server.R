#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(lubridate)
library(ggplot2)
library(tidyverse)


setwd("~/S22-Soils-App/")

source("hbSoils/waterCleaningScript.R")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
    output$timePlot <- renderPlot({
      ggplot(clean_temperature_data, aes(x = date, y = input$selection)) +
        theme_classic() + geom_line()}, res = 80)
    
    output$testText <- renderText({
      
    })
    

})
