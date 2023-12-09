# Load the shiny library
library(shiny)

# Create a Shiny UI
ui <- fluidPage(
  titlePanel("Weather Analysis App"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("city", "Select a City:", 
                  choices = c("Jaipur", "Delhi", "Bangalore","Hyderabad",
                              "Chandigarh","Shimla")),
      
      dateInput("date", "Select a Date:", value = Sys.Date()),
      
      selectInput("condition", "Select a Weather Condition:",
                  choices = c("Sunny", "Cloudy", "Rainy", "Snowy"))
    ),
    
    mainPanel(
      verbatimTextOutput("weatherSummary")
    )
  )
)

# Create a Shiny server
server <- function(input, output) {
  output$weatherSummary <- renderText({
    city <- input$city
    date <- input$date
    condition <- input$condition
    
    paste(" City: ", city, "\n",
          "Date: ", date, "\n",
          "Weather Condition: ", condition)
  })
}

# Run the Shiny app
shinyApp(ui, server)

