library(shiny)
library(ggplot2)
library(dplyr)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

##Please select Price Range or Type of bewerage or Country to make the charts change based on your selection.

ui <- fluidPage(titlePanel("BC Store prices",windowTitle = "BC Store Prices"),
                sidebarLayout(
                    sidebarPanel(h4("Interactive Input Filters Panel"),br(),
                                 sliderInput("priceInput", "Select Price Range", min = 0, max = 100,
                                             value = c(1, 40), pre = "$"),
                                 checkboxGroupInput("typeInput", "Select Product type",
                                                    choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                                                    selected = "WINE"),
                                 selectInput("countryInput", "Select Country",
                                             choices = c("CANADA", "FRANCE", "ITALY"))),
                    
                    mainPanel(
                        tabsetPanel(type = "tabs",
                                    tabPanel("Plot",plotOutput("coolplot")),
                                    tabPanel("Table",tableOutput("results")),
                                    tabPanel("Documentation",verbatimTextOutput("documentation"))
                        )
                    )                                
                    ###                    mainPanel(h4("Interactive Charts Panel"),
                    ###                              br(),br(),plotOutput("coolplot"),
                    ###                              br(),br(),tableOutput("results"))
                    ###        
                ))