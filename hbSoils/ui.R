#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#This is a test.

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
               tabPanel("Timeseries",
                        h2("Timeseries Tab")
               ),
               tabPanel("Bivariate",
                        h2("Bivariate Tab")
               )
    ),
    

    # Sidebar Panel responsible for selecting date Range and Variable
    sidebarLayout(
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
