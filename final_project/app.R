library(shiny)
library(ggplot2)
library(tidyverse)
library(dplyr, warn.conflicts = FALSE)
library(ggforce)

data1 <- read_csv("tract_outcomes_simple.csv")

data1 %>%
    group_by(state) 
   
              

# Define UI for application that draws a histogram
ui <- navbarPage(
    "Final Project Title",
    tabPanel("Homepage", 
             titlePanel("Welcome"),
             h3("Project Background and Motivations"),
             p("Hello, this is where I talk about my project."),
             h3("About my project"),
             a("Here's a link to Google", href = "https://www.Google.com"),
             h4("This is a smaller heading"), 
             p("My name is Naomi-Grace and I study Government. 
             You can reach me at naomigracejennings@college.harvard.edu.")), 
    tabPanel("Model",
             fluidPage(
                 selectInput("x", "X variable", choices = names(data1)),
                 selectInput("y", "Y variable", choices = names(data1)),
                 selectInput("geom", "geom", c("point", "column", "jitter")),
                 plotOutput("plot")
             )),
    tabPanel("Discussion",
             titlePanel("Discussion Title"),
             p("Tour of the modeling choices you made and 
              an explanation of why you made them")),
    tabPanel("About", 
             titlePanel("About"),
             h3("Project Background and Motivations"),
             p("Hello, this is where I talk about my project."),
             h3("Dataset 1"), 
             p(a("Data1", href = "https://opportunityinsights.org/data/"), "This first dataset shows the imprisonment rates of counties in all fifty states by gender and race.  I plan on also using education data from the same site to find coorelation between access to education and imprisonment rates in different states by race. "),
             h3("About Me"),
             p("My name is Naomi-Grace and I study Government. 
             You can reach me at naomigracejennings@college.harvard.edu.")))


# Define server logic required to draw a histogram
server <- function(input, output, session) {
    plot_geom <- reactive({
        switch(input$geom,
               point = geom_point(alpha = .5),
               column = geom_col(position = "dodge"),
               jitter = geom_jitter(alpha = .5)
        )
    })
    
    output$plot <- renderPlot({
        ggplot(data1, aes(.data[[input$x]], .data[[input$y]], color = state)) +
            plot_geom()
    }, res = 96)
}


# Run the application 
shinyApp(ui = ui, server = server)