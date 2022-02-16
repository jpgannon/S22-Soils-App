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

    
    output$timePlot <- renderPlot({
      ggplot(mtcars, aes(x = input$selection, y = cyl)) +
        theme_classic() + geom_smooth()}, res = 98)
    
    output$testText <- renderText({
      
    })
    

})
