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

    #Reactive data for updating between certain dates
    data <- reactive(
      merged_clean_data %>% filter(between(date, as.POSIXct(input$dateRange[1]),
                       as.POSIXct(input$dateRange[2])))
    )  
    #Output multiple plots
    output$multiplot <- renderPlot({
      ggplot(data(), aes(x = date, !!input$selection)) +
        theme_classic() + geom_line() + labs(x = "Time", 
                                             title = "")
    })
    
  
    #Output plot for any selected variable
    output$timePlot <- renderPlot({
      
      ggplot(data(), aes(x = date, !!input$selection)) +
        theme_classic() + geom_line() 
    })
    #Output plot for second selected variable
    output$timePlot2 <- renderPlot({
      ggplot(data(), aes(x = date, !!input$selection2)) +
        theme_classic() + geom_line() })

    
    #Output text for DEBUGGING and seeing specific date range
    output$testText <- renderText({
      paste0("Date Range is ", input$dateRange)
    })
    

})
