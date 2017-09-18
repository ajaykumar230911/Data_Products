server <- function(input, output) {
    output$countryOutput <- renderUI({
        selectInput("countryInput", "Country",
                    sort(unique(bcl$Country)),
                    selected = "CANADA")
    })  
    
    filtered <- reactive({
        if (is.null(input$countryInput)) {
            return(NULL)
        }    
        
        bcl %>%
            filter(Price >= input$priceInput[1],
                   Price <= input$priceInput[2],
                   Type == input$typeInput,
                   Country == input$countryInput
            )
    })
    
    output$documentation <- renderText({
        "This Shiny App is developed to for Week 4 Assignment
        
        On the left pane filters are placed and on the right pane there are 3 tabs plots tables and documentation is displayed
        
        On the filters panel users can select Brewerage type, its price range and the country.
        
        In the center panel 2nd tab is a histogram chart is displayed which shows count of brewerage available in the selected country and within that price range and with the alcohol content %.
        
        3rd tab is a table format of the data.
        
        1st tab is documentation about how to use this shiny app"
        
    })    
    
    output$coolplot <- renderPlot({
        if (is.null(filtered())) {
            return()
        }
        ggplot(filtered(), aes(Alcohol_Content, fill=Type)) +
            geom_histogram()
        
        
    })
    
    
    
    ####   output$documentation <- renderPrint({
    ####       summary(filtered())
    
    ####   })
    
    output$results <- renderTable({
        filtered()
    })
}