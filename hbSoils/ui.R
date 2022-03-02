# Test
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

source("hbSoils/soilAquaticDataMerging.R")


shinyUI(fluidPage(
    
    # Application title
    titlePanel("Data Vizualization Of Hubbard Brook"),
    
    # Creates two tabs for timeseries & bivariate data
    navbarPage("Type of Analysis", theme = shinytheme("flatly"), position = "fixed-top",
               tabPanel("Bivariate",
                        h2("Bivariate Tab"),
               ),
               navbarMenu("Timeseries",
                          tabPanel("Soil Data",
                                   h2("Soil Data")
                          ),
                          tabPanel("Aquatic Data",
                                   h2("Aquatic Data")
                          )
               )),
    
    # Sidebar Panel responsible for selecting date Range and Variable
    sidebarLayout(
        sidebarPanel(
            dateRangeInput("dateRange", "Desired Date Range",
                           start = "2012-11-1",
                           end = "2015-11-1"),
            #Select only columns that we need for variables to look at
            varSelectInput("selection", "Variable", merged_clean_data %>% select(Soil_Moisture_5cm,
                                                                                 Soil_Moisture_15cm,
                                                                                 Soil_Moisture_30cm,
                                                                                 Air_Temp_150cm,
                                                                                 Chamber_Temp,
                                                                                 Soil_Temp_5cm,
                                                                                 Soil_Temp_15cm,
                                                                                 Soil_Temp_30cm,
                                                                                 CO2_Flux,
                                                                                 CO2_Flux_2,
                                                                                 CO2_Flux_3,
                                                                                 nee.int, 
                                                                                 TempC,
                                                                                 SpConductivity,
                                                                                 NO3_corrected_mgL,
                                                                                 FDOM_corrected_QSU,
                                                                                 Q_Ls)
            
            ),
            conditionalPanel(
            condition = "input.multiplots == 1",
            varSelectInput("selection2", "Variable 2", merged_clean_data %>% select(Soil_Moisture_5cm,
                                                                                 Soil_Moisture_15cm,
                                                                                 Soil_Moisture_30cm,
                                                                                 Air_Temp_150cm,
                                                                                 Chamber_Temp,
                                                                                 Soil_Temp_5cm,
                                                                                 Soil_Temp_15cm,
                                                                                 Soil_Temp_30cm,
                                                                                 CO2_Flux,
                                                                                 CO2_Flux_2,
                                                                                 CO2_Flux_3,
                                                                                 nee.int)
                           )),
            #Configure if second plot is visible.
            checkboxInput("multiplots", "Show Multiple Plots", FALSE),
        ),
        
        
        # Displays timeseries updatable graph and specific date range text
        mainPanel(
            plotOutput("timePlot"),
            conditionalPanel(
            condition = "input.multiplots == 1",
            plotOutput("timePlot2")
            ),
            textOutput("testText")
        )
    )
))