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
library(ggpmisc)

source("soilAquaticDataMerging.R")

shinyUI(fluidPage(
    
    # Application title
    titlePanel("Data Vizualization Of Hubbard Brook"),
    
    # Creates three tabs for timeseries, bivariate, & about
    navbarPage("Type of Analysis", theme = shinytheme("flatly"), position = "fixed-top",
               tabPanel("About",
                        h2("About the App"),
                        fluidRow(
                          tags$h4("This app visualizes terrestrial and aqautic data collected from the Hubbard
                                    Brook Experimental Forest through reactive visualizations. Users can manipulate 
                                  the data using various interactive elements found in both tabs."),
                          tags$h4(strong('Information about the functionality and parts of this app are below:')),
                          strong('Timeseries Analysis'), 
                          tags$li('Up to four graphs can be created based on the users desired variable of analysis 
                          and date range. All plots are reactive with the ability to change the variable and date.'),
                          strong('Bivariate Analysis'),
                          tags$li('Up to four graphs can be created based on the users desired variables of analysis. 
                                  All plots are reactive with the ability to change the variables.'),
               )),
               
               tabPanel("Bivariate",
                        h2("Bivariate Tab"),
                        sidebarLayout(
                          sidebarPanel(
                            #Option to show linear model.
                            checkboxInput("linearadd", "Show linear model", FALSE),
                            varSelectInput("BV_selection1", "Bivarate Variable 1", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                                                                 Soil_Moisture_at_15cm,
                                                                                                                 Soil_Moisture_at_30cm,
                                                                                                                 Air_Temp_at_150cm,
                                                                                                                 Temp_of_Chamber,
                                                                                                                 Soil_Temp_at_5cm,
                                                                                                                 Soil_Temp_at_15cm,
                                                                                                                 Soil_Temp_at_30cm,
                                                                                                                 CO2_Flux, 
                                                                                                                 Stream_Temp_Celcius,
                                                                                                                 Stream_Specific_Conductance,
                                                                                                                 Stream_NO3_mgL,
                                                                                                                 Stream_FDOM_QSU,
                                                                                                                 Stream_Discharge_L)
                                           
                            ),
                            varSelectInput("BV_selection2", "Bivarate Variable 2", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                                               Soil_Moisture_at_15cm,
                                                                                               Soil_Moisture_at_30cm,
                                                                                               Air_Temp_at_150cm,
                                                                                               Temp_of_Chamber,
                                                                                               Soil_Temp_at_5cm,
                                                                                               Soil_Temp_at_15cm,
                                                                                               Soil_Temp_at_30cm,
                                                                                               CO2_Flux, 
                                                                                               Stream_Temp_Celcius,
                                                                                               Stream_Specific_Conductance,
                                                                                               Stream_NO3_mgL,
                                                                                               Stream_FDOM_QSU,
                                                                                               Stream_Discharge_L)
                                           
                            ),
                            checkboxInput("BVmulti1", "BVPlot 2", FALSE),
                            conditionalPanel(condition = "input.BVmulti1 == 1",
                                             varSelectInput("BV_selection2_1", "Bivarate Variable 1", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                                                                                   Soil_Moisture_at_15cm,
                                                                                                                                   Soil_Moisture_at_30cm,
                                                                                                                                   Air_Temp_at_150cm,
                                                                                                                                   Temp_of_Chamber,
                                                                                                                                   Soil_Temp_at_5cm,
                                                                                                                                   Soil_Temp_at_15cm,
                                                                                                                                   Soil_Temp_at_30cm,
                                                                                                                                   CO2_Flux, 
                                                                                                                                   Stream_Temp_Celcius,
                                                                                                                                   Stream_Specific_Conductance,
                                                                                                                                   Stream_NO3_mgL,
                                                                                                                                   Stream_FDOM_QSU,
                                                                                                                                   Stream_Discharge_L)
                                                            
                                             ),
                                             varSelectInput("BV_selection2_2", "Bivarate Variable 2", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                                                                                   Soil_Moisture_at_15cm,
                                                                                                                                   Soil_Moisture_at_30cm,
                                                                                                                                   Air_Temp_at_150cm,
                                                                                                                                   Temp_of_Chamber,
                                                                                                                                   Soil_Temp_at_5cm,
                                                                                                                                   Soil_Temp_at_15cm,
                                                                                                                                   Soil_Temp_at_30cm,
                                                                                                                                   CO2_Flux, 
                                                                                                                                   Stream_Temp_Celcius,
                                                                                                                                   Stream_Specific_Conductance,
                                                                                                                                   Stream_NO3_mgL,
                                                                                                                                   Stream_FDOM_QSU,
                                                                                                                                   Stream_Discharge_L)
                                                            
                                             )),
                            conditionalPanel(condition = "input.BVmulti3 == 1 || input.BVmulti2 == 1 || input.BVmulti1 == 1",
                                             checkboxInput("BVmulti2", "BVPlot 3", FALSE),),
                            conditionalPanel(condition = "input.BVmulti2 == 1",
                                             varSelectInput("BV_selection3_1", "Bivarate Variable 1", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                                                                                   Soil_Moisture_at_15cm,
                                                                                                                                   Soil_Moisture_at_30cm,
                                                                                                                                   Air_Temp_at_150cm,
                                                                                                                                   Temp_of_Chamber,
                                                                                                                                   Soil_Temp_at_5cm,
                                                                                                                                   Soil_Temp_at_15cm,
                                                                                                                                   Soil_Temp_at_30cm,
                                                                                                                                   CO2_Flux, 
                                                                                                                                   Stream_Temp_Celcius,
                                                                                                                                   Stream_Specific_Conductance,
                                                                                                                                   Stream_NO3_mgL,
                                                                                                                                   Stream_FDOM_QSU,
                                                                                                                                   Stream_Discharge_L)
                                                            
                                             ),
                                             varSelectInput("BV_selection3_2", "Bivarate Variable 2", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                                                                                   Soil_Moisture_at_15cm,
                                                                                                                                   Soil_Moisture_at_30cm,
                                                                                                                                   Air_Temp_at_150cm,
                                                                                                                                   Temp_of_Chamber,
                                                                                                                                   Soil_Temp_at_5cm,
                                                                                                                                   Soil_Temp_at_15cm,
                                                                                                                                   Soil_Temp_at_30cm,
                                                                                                                                   CO2_Flux, 
                                                                                                                                   Stream_Temp_Celcius,
                                                                                                                                   Stream_Specific_Conductance,
                                                                                                                                   Stream_NO3_mgL,
                                                                                                                                   Stream_FDOM_QSU,
                                                                                                                                   Stream_Discharge_L)
                                                            
                                             ),),
                            conditionalPanel(condition = "input.BVmulti3 == 1 || input.BVmulti2 == 1",
                                             checkboxInput("BVmulti3", "BVPlot 4", FALSE),),
                            conditionalPanel(condition = "input.BVmulti3 == 1 || input.BVmulti4 == 1",
                                             varSelectInput("BV_selection4_1", "Bivarate Variable 1", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                                                                                   Soil_Moisture_at_15cm,
                                                                                                                                   Soil_Moisture_at_30cm,
                                                                                                                                   Air_Temp_at_150cm,
                                                                                                                                   Temp_of_Chamber,
                                                                                                                                   Soil_Temp_at_5cm,
                                                                                                                                   Soil_Temp_at_15cm,
                                                                                                                                   Soil_Temp_at_30cm,
                                                                                                                                   CO2_Flux, 
                                                                                                                                   Stream_Temp_Celcius,
                                                                                                                                   Stream_Specific_Conductance,
                                                                                                                                   Stream_NO3_mgL,
                                                                                                                                   Stream_FDOM_QSU,
                                                                                                                                   Stream_Discharge_L)
                                             ),
                                             varSelectInput("BV_selection4_2", "Bivarate Variable 2", merged_clean_data %>% select(Soil_Moisture_at_5cm,
                                                                                                                                   Soil_Moisture_at_15cm,
                                                                                                                                   Soil_Moisture_at_30cm,
                                                                                                                                   Air_Temp_at_150cm,
                                                                                                                                   Temp_of_Chamber,
                                                                                                                                   Soil_Temp_at_5cm,
                                                                                                                                   Soil_Temp_at_15cm,
                                                                                                                                   Soil_Temp_at_30cm,
                                                                                                                                   CO2_Flux, 
                                                                                                                                   Stream_Temp_Celcius,
                                                                                                                                   Stream_Specific_Conductance,
                                                                                                                                   Stream_NO3_mgL,
                                                                                                                                   Stream_FDOM_QSU,
                                                                                                                                   Stream_Discharge_L)
                                                            
                                             ),)
                            
                            
                            
                          ),
                          
                          # Displays Bivariate updatable graph and specific date range text
                          mainPanel(
                            plotOutput("bvPlot", height = 375, width = 375),
                            conditionalPanel(
                              condition = "input.BVmulti1 == 1",
                              plotOutput("bvPlot2", height = 375, width = 375),
                            ),
                            conditionalPanel(
                              condition = "input.BVmulti2 == 1",
                              plotOutput("bvPlot3", height = 375, width = 375),
                            ),
                            conditionalPanel(
                              condition = "input.BVmulti3 == 1",
                              plotOutput("bvPlot4", height = 375, width = 375)
                            )
                            
                          )
                        )
                        
                        
               ),
               tabPanel("Timeseries",
                        h2("Timeseries Tab"),
                        sidebarLayout(
                          sidebarPanel(
                            dateRangeInput("dateRange", "Desired Date Range",
                                           start = "2012-11-1",
                                           end = "2015-11-1"),
                            #Smoothing line option adding
                            checkboxInput("smoothingadd", "Add smoothing line", FALSE),
                  
                            #Add Horizontal Line selection
                            checkboxInput("hlineadd", "add horizontal reference line", FALSE),
                            conditionalPanel(
                              condition = "input.hlineadd == 1",
                            numericInput("hline", label = h4("Add horizontal Line"), value = 1, FALSE)),
                          
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
                                                                                               Stream_Temp_Celcius,
                                                                                               Stream_Specific_Conductance,
                                                                                               Stream_NO3_mgL,
                                                                                               Stream_FDOM_QSU,
                                                                                               Stream_Discharge_L)
                                           
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
                                                                                            Stream_Temp_Celcius,
                                                                                            Stream_Specific_Conductance,
                                                                                            Stream_NO3_mgL,
                                                                                            Stream_FDOM_QSU,
                                                                                            Stream_Discharge_L)
                              ),), 
                            
                            #Configure if second plot is visible.
                            conditionalPanel(condition = "input.multiplots == 1 || input.multiplots3 == 1 || input.multiplots2 == 1",
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
                                                                                            Stream_Temp_Celcius,
                                                                                            Stream_Specific_Conductance,
                                                                                            Stream_NO3_mgL,
                                                                                            Stream_FDOM_QSU,
                                                                                            Stream_Discharge_L)
                              ),),
                            #Configure if second plot is visible.
                            conditionalPanel(condition = "input.multiplots2 == 1 || input.multiplots3 == 1 || input.multiplots2 == 1",
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
                                                                                            Stream_Temp_Celcius,
                                                                                            Stream_Specific_Conductance,
                                                                                            Stream_NO3_mgL,
                                                                                            Stream_FDOM_QSU,
                                                                                            Stream_Discharge_L)
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
                            )
                          )

                        )

                        
               )
               
    
    )
  )
)