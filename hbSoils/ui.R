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


shinyUI(fluidPage(

    # Application title
    titlePanel("Data Vizualization Of Hubbard Brook (Using Tabsets)"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            dateRangeInput("dateRange", "Date Range for Analysis",
                           start = "2012-11-1",
                           end = "2013-11-1"),
            varSelectInput("selection", "Column Name:", allCleanData)
        ),
       
   
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("timePlot"),
            textOutput("testText")
        )
    )
))
