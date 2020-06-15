#!/usr/bin/env Rscript

library(shiny)
library(dplyr)

# Defining the UI as a Fluid Page that can be easily managed for multiple elements.
# The use of SidePanel has been avoided for simplicity.

ui <- fluidPage(
    # Application title
    titlePanel( title = h1("A dynamic Scatterplot of the Iris Dataset", align = "center"),
                windowTitle = "Iris Scatterplot"
                ),
    hr(), # Divider
    mainPanel(plotOutput('plot')),
    br(),
    br(),
    br(),
    br(), # A few line breaks to align the dashboard properly
          # A column of three main input choices to edit the visualisation
    fluidRow(
    column(3, selectInput('xCol', 'Choose the X-axis', names(iris)[-5])),
    column(3, selectInput('yCol', 'Choose the Y-axis', names(iris)[-5])),
    column(3, selectInput('species', 'Species', unique(iris$Species))),
    column(3, uiOutput("link"))
    )

)

server <- function(input, output, session) {

    # Getting the iris data and filtering it for the given species and columns
    df <- reactive({filter(iris, Species == input$species)[, c(input$xCol, input$yCol)]})

    # Creating the main scatter plot
    output$plot <- renderPlot({plot(df(), pch = 20, cex = 3, col = "blue",
                                    main = paste("A Scatterplot of the iris dataset for the species:", input$species))})

    # Additional URLs for information to the user
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
