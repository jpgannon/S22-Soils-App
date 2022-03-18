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

    #Set reactive date range.
    ranges <- reactiveValues(x = c("2012-10-11", "2020-11-30"))
  
  
  
  
    #Reactive data for updating between certain dates
    data <- reactive(
      merged_clean_data %>% filter(between(date, as.POSIXct(input$dateRange[1]),
                       as.POSIXct(input$dateRange[2])))
    )  
    #Output multiple plots
    output$multiplot <- renderPlot({
      ggplot(data(), aes(x = date, !!input$selection)) +
        theme_classic() + geom_point() + labs(x = "Time", 
                                             title = "") 
    })
    
    #Output plot for any selected variable
    output$bvPlot <- renderPlot({
      
      ggplot(data(), aes(x = !!input$BV_selection1, !!input$BV_selection2)) +
        theme_classic() + geom_line() +
        coord_cartesian(xlim = as.POSIXct(ranges$x, origin = "1970-01-01"), expand = FALSE) +
        scale_y_continuous()+
        scale_x_continuous()+
        theme(text = element_text(size = 16))
    })
  
    #Output plot for any selected variable
    output$timePlot <- renderPlot({
      
      ggplot(data(), aes(x = date, !!input$selection)) +
        theme_classic() + geom_line() +
        coord_cartesian(xlim = as.POSIXct(ranges$x, origin = "1970-01-01"), expand = FALSE) +
        theme(text = element_text(size = 16))
    })
    #Output plot for second selected variable
    output$timePlot2 <- renderPlot({
      ggplot(data(), aes(x = date, !!input$selection2)) +
        theme_classic() + geom_line() +
        coord_cartesian(xlim = as.POSIXct(ranges$x, origin = "1970-01-01"), expand = FALSE) +
        theme(text = element_text(size = 16))
      })
    
    #Output plot for third selected variable
    output$timePlot3 <- renderPlot({
      ggplot(data(), aes(x = date, !!input$selection3)) +
        theme_classic() + geom_line() +
        coord_cartesian(xlim = as.POSIXct(ranges$x, origin = "1970-01-01"), expand = FALSE) +
        theme(text = element_text(size = 16))
      })
    #Output plot for fourth selected variable
    output$timePlot4 <- renderPlot({
      ggplot(data(), aes(x = date, !!input$selection4)) +
        theme_classic() + geom_line() +
        coord_cartesian(xlim = as.POSIXct(ranges$x, origin = "1970-01-01"), expand = FALSE) +
        theme(text = element_text(size = 16))
      })
    
    
    
    ##HANDLE BRUSHING
    observeEvent(input$plot1_dblclick, {
      brush = input$plot1_brush
      
      if(!is.null(brush)) {
        ranges$x <- c(brush$xmin, brush$xmax)
      }
      
      else {
        ranges$x <- c(input$dateRange[1], input$dateRange[2])
      }
    }
    )
    
    
    
    

})
