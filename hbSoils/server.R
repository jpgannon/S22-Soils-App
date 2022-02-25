#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  data_selected <- reactive({
    selectData(input$tabs)
  })
  
  
  
  
  #Reactive data for updating between certain dates
  data <- reactive(
    allCleanData %>% filter(between(date, as.POSIXct(input$dateRange[1]),
                                    as.POSIXct(input$dateRange[2])))
  )  
  
  
  #Output plot for any selected variable
  output$timePlot <- renderPlot({
    ggplot(data_selected(), aes(x = date, !!input$selection)) +
      theme_classic() + geom_line() + labs(x = "Time",
                                           title = "Specified Variable over time")}, res = 80)
  
  
  #Output text for DEBUGGING and seeing specific date range
  output$testText <- renderText({
    paste0("Date Range is ", input$dateRange)
  })
  
  
  selectData <- function(name) {
    if (name == "Soil Data") {
      return(master_soil)
    }
    else if(name == "Aquatic Data") {
      return(allCleanData)
    }
    return(master_soil)
  }
  
})
