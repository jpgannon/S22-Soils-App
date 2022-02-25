#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#This is a test.
#add lines

library(shiny)
library(shinythemes)
library(shinydashboard)
library(lubridate)
library(ggplot2)
library(tidyverse)


setwd("~/S22-Soils-App/")

source("hbSoils/waterCleaningScript.R")


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Data Vizualization Of Hubbard Brook"),
  
  # Creates two tabs for timeseries & bivariate data
  navbarPage("Type of Analysis", theme = shinytheme("flatly"),
             tabPanel("Bivariate", h2("Bivariate Tab")),
             navbarMenu("Timeseries", id = "tabs",
                                    tabPanel("Soil Data",
                                             h2("Soil Data"), id = "Soil Data"
                                    ),
                                    tabPanel("Aquatic Data",
                                             h2("Aquatic Data"), id = "Aquatic Data"
                                    )
                        )),
  
  # Sidebar Panel responsible for selecting date Range and Variable
  sidebarLayout(
    
    conditionalPanel(condition="input.tabselected==1",h4("Soil Data"),
                     dateRangeInput("dateRange", "Desired Date Range",
                                    start = "2012-11-1",
                                    end = "2013-11-1"),
                     varSelectInput("selection", "Variable", master_soil %>% select(
                     ))
                     ),
   
    
    
    conditionalPanel(condition="input.tabselected==2",
                     selectInput("dataset", "select the desired dataset", choices=ls('package:datasets'), 
                                 selected = "mtcars"),
                     radioButtons("choice","Choose an option", choices=c("Dataset" = 1, "Structure" = 2,
                                                                         "Summary" = 3 ))
                     
    )
    
    sidebarPanel(
      dateRangeInput("dateRange", "Desired Date Range",
                     start = "2012-11-1",
                     end = "2013-11-1"),
      #Select only columns that we need for variables to look at
      varSelectInput("selection", "Variable", allCleanData %>% select(TempC,
                                                                      SpConductivity,
                                                                      NO3_corrected_mgL,
                                                                      FDOM_corrected_QSU,
                                                                      Q_Ls
      ))
    ),
    
    
    # Displays timeseries updatable graph and specific date range text
    mainPanel(
      plotOutput("timePlot"),
      textOutput("testText")
    )
  )
))