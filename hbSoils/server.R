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

    #Reactive data for updating between certain dates
    data <- reactive(
      allCleanData %>% filter(between(date, as.POSIXct(input$dateRange[1]),
                       as.POSIXct(input$dateRange[2])))
    )  
  
    
    #Output plot for any selected variable
    output$timePlot <- renderPlot({
      ggplot(data(), aes(x = date, !!input$selection)) +
<<<<<<< HEAD
        theme_classic() + geom_line() + labs(x = "Time",
                                             title = "Specified Variable over time")}, res = 80)
=======
        theme_classic() + geom_line()}, res = 80)
>>>>>>> 78ab1fe216f2cc4dcae7a87d9a17621669d48a31
    
    #Output text for DEBUGGING and seeing specific date range
    output$testText <- renderText({
      paste0("Date Range is ", input$dateRange)
    })
    

})
