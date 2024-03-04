library(shiny)
library(caret)
model = readRDS("model.rds")


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Scotland's Aquaculture"),
        sidebarPanel(
          
          #Number + Cu + Age + N + Org + Zn,
          numericInput("Number","Estimated number of escaped fish:",min = 1,max = 400000,value = 2500),
          numericInput("Cu", "Level of copper compounds in water",  value = .55, min = -5, max = 5, step = 0.01),
          numericInput("Age", "Age of the fish:", min = 2, max = 48, value = 26),
          numericInput("N", "Level of nitrogen compounds in the water", value = 5, min = -120, max = 700, step =  0.1),
          numericInput("Org", "Level of organic compounds in water",  value = 500, min = 60, max = 1200, step = 1),
          numericInput("Phosphorous", "Level of phosphorous compounds in water",  value = 40, min = -1, max = 25, step = 0.0001),
          actionButton("GO", "Predict")
          ),

        # Show a plot of the generated distribution
        mainPanel(
          ## static content uses HTML format via "tags" function
          tags$h3("Prediction for Cause of escape is:"), ## tags$h3 is header size level 3
          textOutput("model"),
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$br(), # tags$br creates line break
          tags$h5("The legal foundation for the usage of original data:"), ## tags$h5 is header size level 5
          tags$h6("This project's initial data does not include any personal information. The usage of original data in this project is assumed to be compatible with the original intent, as indicated on the Scotland Aquaculture website, which allows non-commercial use of the website's resources. Unless otherwise specified in specific data services, map views, and meta data, all data on the website is open data."), ## tags$h6 is header size level 6
          tags$a(href = "http://aquaculture.scotland.gov.uk/site_pages/legal.aspx", "See Legal page for more"), # tags$a creates a hyperlink
          tags$br(), # tags$br creates line break
          tags$a(href = "http://aquaculture.scotland.gov.uk/data/fish_escapes.aspx", "Source"), # tags$a creates a hyperlink
          tags$br(), # tags$br creates line break
          tags$a(href = "https://shiny.rstudio.com/", "See R Shiny docs for more") # tags$a creates a hyperlink
          
        )
    )


# Define server logic required to draw a histogram
server <- function(input, output) {
  observeEvent(input$GO, {
    output$model <- renderText({
      a = input$Number
      b = input$Cu
      c = input$Age
      d = input$N
      g = input$Org
      s = input$P
      
      newData= data.frame(Number = a, Cu = b, Age = c, N = d, Org = g, P = s)
      
      prediction1 = predict(model, newData)
      prediction1
       if (prediction1 =="Human") { print("Human") } else { print("Natural") }
      
      
  })
  
    
  })
  
}  


# Run the application 
shinyApp(ui = ui, server = server)
