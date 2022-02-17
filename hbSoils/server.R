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
library(tibbletime)


setwd("~/S22-Soils-App/")

source("hbSoils/waterCleaningScript.R")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
    
  
  
    output$timePlot <- renderPlot({
      
      #Set Filtered Date
      filtered_date <- filter_time(allCleanData, input$dateRange[1] ~ input$dateRange[2])
      
      
      
      ggplot(allCleanData, aes(x = filtered_date, !!input$selection)) +
        theme_classic() + geom_line()}, res = 80)
    
    output$testText <- renderText({
      paste0("Date Range is ", input$dateRange[1])
    })
    

})
