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


temperatureRawData <- read_csv("hbSoils/data_raw/HBF Temperature.csv")


clean_temperature_data <- temperatureRawData %>% mutate(date = mdy_hm(Date.Time.EST)) %>%
  select(date, TempC)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
    output$timePlot <- renderPlot({
      ggplot(clean_temperature_data, aes(x = date, y = TempC)) +
        theme_classic() + geom_smooth()}, res = 98)
    
    output$testText <- renderText({
      
    })
    

})
