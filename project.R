# app.R

library(shiny)
library(readxl)
library(tidyverse)
library(caret)
library(randomForest)

# Load data
data <- read.csv("C:/Users/jasha/Downloads/Delhi_NCR_1990_2022_Safdarjung.xlsx")
View(data)
# Define UI
ui <- fluidPage(
  titlePanel("Weather Data Analysis"),
  sidebarLayout(
    sidebarPanel(
      # Add sidebar components if needed
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Exploratory Data Analysis", tableOutput("summary_table")),
        tabPanel("Machine Learning Model", 
                 selectInput("predictor", "Select predictor variable:", 
                             choices = names(data), selected = names(data)[1]),
                 actionButton("train_model", "Train Model"),
                 verbatimTextOutput("model_summary"))
      )
    )
  )
)

# Define server
server <- function(input, output) {
  
  # Exploratory Data Analysis
  output$summary_table <- renderTable({
    summary(data)
  })
  
  # Machine Learning Model
  trained_model <- reactiveVal(NULL)
  
  observeEvent(input$train_model, {
    predictor_col <- input$predictor
    response_col <- "your_response_variable"  # Replace with the actual response variable
    
    # Prepare data
    training_data <- select(data, c(predictor_col, response_col))
    
    # Train machine learning model (using random forest as an example)
    model <- train(training_data[, predictor_col] ~ ., data = training_data, method = "rf")
    
    # Save the trained model
    saveRDS(model, "models/trained_model.rds")
    
    # Update the reactive value
    trained_model(model)
  })
  
  output$model_summary <- renderPrint({
    model <- trained_model()
    
    if (!is.null(model)) {
      print(model)
    } else {
      "Train the model to see the summary."
    }
  })
}

# Run the app
shinyApp(ui, server)
