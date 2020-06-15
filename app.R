#!/usr/bin/env Rscript

library(shiny)
library(dplyr)

# Defining a fluid page for the frontend of the application

ui <- fluidPage(
    # Application title using HTML in the center
    titlePanel( title = h1("A dynamic Scatterplot of the Iris Dataset", align = "center"),
                windowTitle = "Iris Scatterplot"
                ),
    hr(),
    mainPanel(plotOutput('plot')),
    br(),
    br(),
    br(),
    br(), # Adding line breaks to align the side panel easily

    fluidRow( # Adding specific input choices
    column(3, selectInput('xCol', 'Choose the X-axis', names(iris)[-5])),
    column(3, selectInput('yCol', 'Choose the Y-axis', names(iris)[-5])),
    column(3, selectInput('species', 'Species', unique(iris$Species))),
    column(3, uiOutput("link")) # information links
    )

)

server <- function(input, output, session) {
    # Pulling the iris dataset and filtering it with the input species
    df <- reactive({filter(iris, Species == input$species)[, c(input$xCol, input$yCol)]})

    # Building the entire scatter plot
    output$plot <- renderPlot({plot(df(), pch = 20, cex = 3, col = "blue",
                                    main = paste("A Scatterplot of the iris dataset for the species:", input$species))})

    # Some UI links for more information for the user
    url1 <- a("Setosa", href="https://en.wikipedia.org/wiki/Iris_setosa")
    url2 <- a("Versicolor", href="https://en.wikipedia.org/wiki/Iris_versicolor")
    url3 <- a("Virginica", href="https://en.wikipedia.org/wiki/Iris_virginica")

    output$link <- renderUI({ tagList("Learn more about:", url1, ',' , url2, ',', url3) })
}


options(shiny.autoreload = TRUE)

options(shiny.host = '0.0.0.0')
options(shiny.port = 8080)

# Create Shiny app ----
shinyApp(ui = ui, server = server)
