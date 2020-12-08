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
ui <- navbarPage(theme = shinytheme("cosmo"),

 #Title Here 
 
    title = "Misogyny in Rap", 
    
    
#First Tab with title, subtitles and text...same as following    

    tabPanel("Homepage", 
             titlePanel("Misogynystic Sentiments in Rap Music"),
             h3("Background"),
             p("Rap, as defined by “The Journal Of Black Studies”, “emerged as an aesthetic cultural expression denoted as the poetry of ...youth who are often disregarded as a result of their race and class status”.  Rap has been used as a mechanism to articulate a variety of ideas and feelings from political discourse to violence, frustration, and misogyny.  Misogyny in particular has seemingly proven inextricable from popular rap, first arising with the “gangsta rap” of the 80’s and prevailing in “trap” today.  As an avid consumer of music invested in the impact of misogynistic rap on the characterization of women (especially Black women), I wanted to look into the prevalence of misogyny in rap over the decades since its emergence.  
"),
             a("Journal of Black Studies", href = "https://www.jstor.org/stable/40034353?seq=1"),
             
             h3("Sources"),
             a("I downloaded around 5,000 song lyrics from"),
             a("Alllyrics.com", href = "https://www.allthelyrics.com/index"), 
             a("selecting over 50 of"),
             a("COMPLEX magazine’s 'Best Rapper Alive, Every Year Since 1979' artists.", href = "https://www.complex.com/music/the-best-rapper-alive-every-year-since-1979"),
             
             h3("Bio"), 
             p("My name is Naomi-Grace Jennings and I am a sophomore concentrating in Government"),
             p("You can reach me at naomigracejennings@college.harvard.edu"),
             a("Here is a link to my Github, where you can find the code for this project", href = "https://github.com/naygrace/final_project")),

   
     tabPanel("Sentiment Analysis",
              fluidPage(
                  titlePanel("Average Misogynistic Sentiment Rating"),
                  
                  plotOutput("plot6"), 
                  
                  h4("'Misogynistic Sentiment Rating' calculated using the sentiment rating and misogynistic word count for each song. (With a rating of zero meaning low misogynistic sentiment) ")),
              
             
                 
             fluidPage(
                 titlePanel("Sentiment by Artist"),
                     
                  
                     selectInput("x", "Artist:",
                                        c("Grandmaster Melle Mel" = "grandmaster_melle_mel", "Kurtis Blow" =  "kurtis_blow", "Kool Moe Dee" = "kool_moe_dee", "Spoonie Gee" = "spoonie_gee", "Run DMC" =  "run_dmc", "LL Cool J" = "ll_cool_j", "Roxanne Shante" = "roxanne_shante", "Slick Rick" = "slick_rick", "Beastie Boys" = "beastie_boys", "KRS-One" =  "krsone", "Too $hort"=  "too_short", "Schoolly D" = "schoolly_d", "Ice Cube" = "ice_cube", "Chuck D" = "chuck_d", "Grand Puba" = "grand_puba", "Kool G Rap" = "kool_g_rap", "Big Daddy Kane" = "big_daddy_kane", "N.W.A." = "nwa", "Method Man" = "method_man", "Scarface" = "scarface", "Dres" = "dres", "Redman" = "redman", "Nas" = "nas", "Notorious BIG" = "notorious_big", "2Pac" = "2pac", "Raekwon" = "raekwon", "Prodigy" = "prodigy", "Busta Rhymes" = "busta_rhymes", "Twista" = "twista", "DMX" = "dmx", "Jay-Z" = "jayz", "Big Pun" = "big_pun", "Lauryn Hill" = "lauryn_hill", "Eminem" = "eminem", "Ghostface Killah" = "ghostface_killah", "Ludacris" = "ludacris", "Jadakiss" = "jadakiss", "Dr. Dre" = "dr_dre", "50 Cent" = "50_cent", "Common" = "common", "T.I." = "ti", "Lil Wayne" = "lil_wayne","Gucci Mane" = "gucci_mane", "Rick Ross" = "rick_ross", "Kanye West" = "kanye_west", "Drake" = "drake","Nicki Minaj" = "nicki_minaj")),  
                    
                     plotOutput("plot2")),
             h4("Overall sentiment rating of each song by the selected artist")),
    
    
             
    tabPanel("Misogynystic Terms",
             fluidPage(
                 titlePanel("Total Word Count"),
    
                 plotOutput("plot3"),
                 h4("Average frequency of misogynistic terms per song")), 
             
             fluidPage(
                 titlePanel("By Artist"),
                 
                 
                 selectInput("x2", "Artist:",
                                    c("Nicki Minaj" = "nicki_minaj", "Kurtis Blow" =  "kurtis_blow", "Kool Moe Dee" = "kool_moe_dee", "Spoonie Gee" = "spoonie_gee", "Run DMC" =  "run_dmc", "LL Cool J" = "ll_cool_j", "Roxanne Shante" = "roxanne_shante", "Slick Rick" = "slick_rick", "Beastie Boys" = "beastie_boys", "KRS-One" =  "krsone", "Too $hort"=  "too_short", "Schoolly D" = "schoolly_d", "Ice Cube" = "ice_cube", "Chuck D" = "chuck_d", "Grand Puba" = "grand_puba", "Kool G Rap" = "kool_g_rap", "Big Daddy Kane" = "big_daddy_kane", "N.W.A." = "nwa", "Method Man" = "method_man", "Scarface" = "scarface", "Dres" = "dres", "Redman" = "redman", "Nas" = "nas", "Notorious BIG" = "notorious_big", "2Pac" = "2pac", "Raekwon" = "raekwon", "Prodigy" = "prodigy", "Busta Rhymes" = "busta_rhymes", "Twista" = "twista", "DMX" = "dmx", "Jay-Z" = "jayz", "Big Pun" = "big_pun", "Lauryn Hill" = "lauryn_hill", "Eminem" = "eminem", "Ghostface Killah" = "ghostface_killah", "Ludacris" = "ludacris", "Jadakiss" = "jadakiss", "Dr. Dre" = "dr_dre", "50 Cent" = "50_cent", "Common" = "common", "T.I." = "ti", "Lil Wayne" = "lil_wayne","Gucci Mane" = "gucci_mane", "Rick Ross" = "rick_ross", "Kanye West" = "kanye_west", "Drake" = "drake")),  
                 
                 plotOutput("plot4")),
             h4("Here we have the total count of misogynistic words used in each song by the selected artist")),
    
    
    tabPanel("Regression Model", 
             fluidPage(
                 titlePanel("Year and Misogynistic Sentiment Rating"), 
                 plotOutput("plot5"), 
                 h3("This model represents the prevalence of misogynistic sentiments in rap as a function of the year the respective artist was popular. There is a very weak positive coorelation here, but a more thorough analysis of the data would be necessary to understand potential correlation between nuanced misogynistic sentiment and era. ") 
                 )))

#Defining all output plots..created here and in .rmd

server = function(input, output) {
    
    output$plot <- renderPlot({  
    
        total_avg_sentiments_model
    
    }, res = 96)
    
    output$plot2 <- renderPlot({
        
         total_sentiments %>%
            filter(artist == input$x) %>%
            group_by(title) %>%
            ggplot(aes(x = reorder(title, desc(song_sentiment)), y = song_sentiment)) +
            geom_col(color = "steelblue", fill = "darkblue") +
            
            labs(title = "Sentiment Ratings by Song", y = "Sentiment Rating", x = "Songs") +
            theme_clean() +
            theme(axis.text.x = element_blank()) 
   
    }, res = 96)
    
    
    output$plot3 <- renderPlot({
        avg_words_model
        
    }, res = 96)
    
    
    output$plot4 <- renderPlot({
        
        avg_words %>%
            filter(artist == input$x2) %>%
            group_by(title) %>%
        
       ggplot(aes(x = title, y = sumrow)) +
            geom_col(aes(stat = "identity", position = "stack"), color = "skyblue", fill = "darkblue") +
            labs(title = "Misogynistic Term Count by Artist", subtitle = "Per song", x = "Artist", y = "Word Count") +
            theme(axis.text.x = element_text(angle = 90)) +
            theme_clean() +
            
    #This looks a hot mess with all the titles so just take them all off
            
            theme(axis.text.x = element_blank(), 
                  axis.title.x = element_blank(), 
                  axis.ticks.x = element_blank()) 
        
    }, res = 96)
    
    
    output$plot5 <- renderPlot({
        
#Very poor just poor do better 
        
        regression_model
    }, res = 96)
    
    
    output$plot6 <- renderPlot({
        
        new_scores_model2
    }, res = 96)

} 
#     
#     output$plot <- renderPlot({
#         ggplot(scores, aes(.data[[input$x]], .data[[input$y]], fill = artist)) +
#             plot_geom() +
#             theme_dark()
#     }, res = 96)
# }


#c("grandmaster_caz", "grandmaster_melle_mel", "kurtis_blow", "kool_moe_dee", "spoonie_gee", "jimmy_spicer",  "run_dmc", "ll_cool_j", "roxanne_shante", "slick_rick", "beastie_boys",  "krsone", "too_short", "schoolly_d", "ice_cube", "chuck_d", "grand_puba", "kool_g_rap", "big_daddy_kane", "nwa", "method_man",  "scarface", "dres", "redman", "nas", "notorious_big", "2pac", "raekwon", "prodigy", "busta_rhymes", "twista", "dmx", "jayz", "big_pun", "lauryn_hill", "eminem", "ghostface_killah", "ludacris", "jadakiss", "dr_dre", "50_cent", "common", "ti",  "lil_wayne", "gucci_mane", "rick_ross",  "kanye_west","drake", "nicki_minaj")),


# Run the application 
shinyApp(ui = ui, server = server)