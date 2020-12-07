library(shiny)
library(ggplot2)
library(tidyverse)
library(dplyr, warn.conflicts = FALSE)
library(ggforce)
library(rvest)
library(stringr)
library(ggthemes)
library(sentimentr)
library(glue)
library(tidytext)
library(shinyWidgets)
library(shinythemes)




# Define UI for application that draws a histogram
ui <- navbarPage(theme = shinytheme("slate"),
    
    "Misogyny in Rap",
    tabPanel("Homepage", 
             titlePanel("Welcome to my Final Project!"),
             h3("Summary"),
             p("Misogyny in rap increase over the years, TW"),
             h3("Sources"),
             a("Here's a link to my data", href = "https://www.Google.com"),
             h4("Bio"), 
             p("Naomi-Grace Jennings
             Class of '23 Gov Concentrator 
             You can reach me at naomigracejennings@college.harvard.edu.")), 
    tabPanel("Sentiment Analysis Over the Years",
             fluidPage(
                 
                 selectInput("x", "Artist", "artist"), 
                  selectInput("y", "IDK", "sah"),
                  selectInput("geom", "geom", c("point", "column")),
                 plotOutput("plot")), 
                 
             fluidPage(
                     
                  
                     checkboxInput("x", "Artist", c("grandmaster_caz", "grandmaster_melle_mel", "kurtis_blow", "kool_moe_dee", "spoonie_gee", "jimmy_spicer",  "run_dmc", "ll_cool_j", "roxanne_shante", "slick_rick", "beastie_boys",  "krsone", "too_short", "schoolly_d", "ice_cube", "chuck_d", "grand_puba", "kool_g_rap", "big_daddy_kane", "nwa", "method_man",  "scarface", "dres", "redman", "nas", "notorious_big", "2pac", "raekwon", "prodigy", "busta_rhymes", "twista", "dmx", "jayz", "big_pun", "lauryn_hill", "eminem", "ghostface_killah", "ludacris", "jadakiss", "dr_dre", "50_cent", "common", "ti",  "lil_wayne", "gucci_mane", "rick_ross",  "kanye_west","drake", "nicki_minaj")),
                     selectInput("geom", "geom", c("point", "column")),
                     plotOutput("plot"))),
             
    tabPanel("Misogynystic Word Usage Over the Years",
             fluidPage(
                 
                 selectInput("x", "Artist", "artist"), 
                 checkboxInput("y", "IDK", FALSE),
                 selectInput("geom", "geom", c("point", "column")),
                 plotOutput("plot2")),
    tabPanel("About", 
             titlePanel("About"),
             h3("Project Background and Motivations"),
             p("Hello, this is where I talk about my project."),
             h3("Dataset 1"), 
             p(a("Data1", href = "https://opportunityinsights.org/data/"), "This first dataset shows the imprisonment rates of counties in all fifty states by gender and race.  I plan on also using education data from the same site to find coorelations between access to education and imprisonment rates in different states by race. "),
             h3("About Me"),
             p("My name is Naomi-Grace and I study Government. 
             You can reach me at naomigracejennings@college.harvard.edu.")), 
             h3("Next Steps"), 
             p("I am working on webscraping now to find the lyrics for my songs for my changed topic")))

server = function(input, output) {
    #plot_geom <- input$geom(col = geom_col(fill = artist)) 
    output$plot <- renderPlot({
        ggplot(data = new, mapping = aes(.data[[input$x]], .data[[input$y]])) +
            geom_col(aes(stat = "identity", position = "stack")) +
            labs(title = "Misogynistic Words Used by Rappers Over the Last 50 Years", subtitle = "Words used by the most popular rap artist of the year", x = "Artist", y = "Number of Words") +
            theme(axis.text.x = element_text(angle = 90))
    })

} #aes(stat = "identity", position = "stack"
# Define server logic required to draw a histogram

# server <- function(input, output, session) {
#     plot_geom <- reactive({
#         switch(input$geom, 
#                point = geom_point(alpha = .5),
#                column = geom_col(position = "dodge"),
#                jitter = geom_jitter(alpha = .5)
#         )
#     })
#     
#     output$plot <- renderPlot({
#         ggplot(scores, aes(.data[[input$x]], .data[[input$y]], fill = artist)) +
#             plot_geom() +
#             theme_dark()
#     }, res = 96)
# }





# Run the application 
shinyApp(ui = ui, server = server)