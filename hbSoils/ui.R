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
library(lubridate)
library(ggplot2)
library(tidyverse)

setwd("~/S22-Soils-App/")
source("hbSoils/waterCleaningScript.R")

shinyUI(fluidPage(

    # Application title
    titlePanel("Data Vizualization Of Hubbard Brook"),

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
                                                                            )),
            checkboxInput("smoothOption", "Add smoothing lines", )
            
        ),
       
   
        # Displays timeseries updatable graph and specific date range text
        mainPanel(
            plotOutput("timePlot"),
            textOutput("testText")
        )
    )
))

