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
               tabPanel("Timeseries",
                        h2("Timeseries Tab")
                        
               )),
    
    # Sidebar Panel responsible for selecting date Range and Variable
    sidebarLayout(
        sidebarPanel(
            dateRangeInput("dateRange", "Desired Date Range",
                           start = "2012-11-1",
                           end = "2015-11-1"),
            #Select only columns that we need for variables to look at
            varSelectInput("selection", "Plot 1", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                                 Soil_Moisture_at_15cm,
                                                                                 Soil_Moisture_at_30cm,
                                                                                 Air_Temp_at_150cm,
                                                                                 Temp_of_Chamber,
                                                                                 Soil_Temp_at_5cm,
                                                                                 Soil_Temp_at_15cm,
                                                                                 Soil_Temp_at_30cm,
                                                                                 CO2_Flux,
                                                                                 CO2_Flux_2,
                                                                                 CO2_Flux_3,
                                                                                 CO2_Flux_Interpolated, 
                                                                                 Temp_Celcius,
                                                                                 Spectral_Conductivity,
                                                                                 NO3_corrected_mgL,
                                                                                 FDOM_corrected_QSU,
                                                                                 Q_Ls)
            
            ),
            #Configure if second plot is visible.
            checkboxInput("multiplots", "Plot 2", FALSE),
            conditionalPanel(
            condition = "input.multiplots == 1",
            varSelectInput("selection2", "", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                                    Soil_Moisture_at_15cm,
                                                                                    Soil_Moisture_at_30cm,
                                                                                    Air_Temp_at_150cm,
                                                                                    Temp_of_Chamber,
                                                                                    Soil_Temp_at_5cm,
                                                                                    Soil_Temp_at_15cm,
                                                                                    Soil_Temp_at_30cm,
                                                                                    CO2_Flux,
                                                                                    CO2_Flux_2,
                                                                                    CO2_Flux_3,
                                                                                    CO2_Flux_Interpolated, 
                                                                                    Temp_Celcius,
                                                                                    Spectral_Conductivity,
                                                                                    NO3_corrected_mgL,
                                                                                    FDOM_corrected_QSU,
                                                                                    Q_Ls)
                           ),
            #Configure if thirsd plot is visible.
            checkboxInput("multiplots2", "Plot 3", FALSE),),
        conditionalPanel(
          condition = "input.multiplots2 == 1",
          varSelectInput("selection3", "", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                                  Soil_Moisture_at_15cm,
                                                                                  Soil_Moisture_at_30cm,
                                                                                  Air_Temp_at_150cm,
                                                                                  Temp_of_Chamber,
                                                                                  Soil_Temp_at_5cm,
                                                                                  Soil_Temp_at_15cm,
                                                                                  Soil_Temp_at_30cm,
                                                                                  CO2_Flux,
                                                                                  CO2_Flux_2,
                                                                                  CO2_Flux_3,
                                                                                  CO2_Flux_Interpolated, 
                                                                                  Temp_Celcius,
                                                                                  Spectral_Conductivity,
                                                                                  NO3_corrected_mgL,
                                                                                  FDOM_corrected_QSU,
                                                                                  Q_Ls)
          ),
          #Configure if second plot is visible.
          checkboxInput("multiplots3", "Plot 4", FALSE),),
    conditionalPanel(
      condition = "input.multiplots3 == 1",
      varSelectInput("selection4", "", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                              Soil_Moisture_at_15cm,
                                                                              Soil_Moisture_at_30cm,
                                                                              Air_Temp_at_150cm,
                                                                              Temp_of_Chamber,
                                                                              Soil_Temp_at_5cm,
                                                                              Soil_Temp_at_15cm,
                                                                              Soil_Temp_at_30cm,
                                                                              CO2_Flux,
                                                                              CO2_Flux_2,
                                                                              CO2_Flux_3,
                                                                              CO2_Flux_Interpolated, 
                                                                              Temp_Celcius,
                                                                              Spectral_Conductivity,
                                                                              NO3_corrected_mgL,
                                                                              FDOM_corrected_QSU,
                                                                              Q_Ls)
      ),)
),
        
        
        # Displays timeseries updatable graph and specific date range text
        mainPanel(
            plotOutput("timePlot", height = 275,
                       dblclick = "plot1_dblclick",
                       brush = brushOpts(
                           id = 'plot1_brush',
                           resetOnNew = TRUE)),
            conditionalPanel(
            condition = "input.multiplots == 1",
            plotOutput("timePlot2", height = 275,
                       dblclick = "plot1_dblclick",
                       brush = brushOpts(
                           id = "plot1_brush",
                           resetOnNew = TRUE)),
            ),
            conditionalPanel(
              condition = "input.multiplots2 == 1",
              plotOutput("timePlot3", height = 275,
                         dblclick = "plot1_dblclick",
                         brush = brushOpts(
                             id = "plot1_brush",
                             resetOnNew = TRUE)),
            ),
            conditionalPanel(
              condition = "input.multiplots3 == 1",
              plotOutput("timePlot4", height = 275,
                         dblclick = "plot1_dblclick",
                         brush = brushOpts(
                             id = "plot1_brush",
                             resetOnNew = TRUE)),
            ),
            textOutput("testText")
        )
    )
))