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
library(rstanarm)
library(rsconnect)
library(gt)
library(gtsummary)
library(broom.mixed)

complete_data <- read_csv("complete_data.csv")
#finaldata <- read_csv("raw_data/finaldata.csv")



# Define UI for application that draws a histogram
ui <- navbarPage(theme = shinytheme("cosmo"),

 #Title Here 
 
    title = "Misogyny in Rap", 
    
    
#First Tab with title, subtitles and text...same as following    

    tabPanel("Homepage", 
             titlePanel("Misogynistic Sentiments in Rap Music"),
             h3("Background"),
             p("Rap, as defined by The Journal Of Black Studies, “emerged as an aesthetic cultural expression denoted as the poetry of ...youth who are often disregarded as a result of their race and class status”.  Rap has been used as a mechanism to articulate a variety of ideas and feelings from political discourse to violence, frustration, and misogyny.  Misogyny in particular has seemingly proven inextricable from popular rap, first arising with the “gangsta rap” of the 80’s and prevailing in “trap” today.  As an avid consumer of music invested in the impact of misogynistic rap on the characterization of women (especially Black women), I wanted to look into the prevalence of misogyny in rap over the decades since its emergence.  
"),
             a("Journal of Black Studies", href = "https://www.jstor.org/stable/40034353?seq=1"),
             
             h3("Sources"),
             a("I downloaded around 5,000 song lyrics from"),
             a("Alllyrics.com", href = "https://www.allthelyrics.com/index"), 
             a("selecting over 50 of"),
             a("COMPLEX magazine’s 'Best Rapper Alive, Every Year Since 1979' artists.", href = "https://www.complex.com/music/the-best-rapper-alive-every-year-since-1979"),
             
             h3("Bio"), 
             p("My name is Naomi-Grace Jennings and I am a sophomore concentrating in Government."),
             p("You can reach me at naomigracejennings@college.harvard.edu"),
             a("Here is a link to my Github, where you can find the code for this project", href = "https://github.com/naygrace/final_project")),

   
     tabPanel("Sentiment Analysis",
              fluidPage(
                  titlePanel("Average Misogynistic Sentiment Rating"),
                  #  sidebarLayout(
                  #      sidebarPanel(),
                  #      mainPanel(
                   #img(src = "regression_mod.png"),
                  plotOutput("plot6"), 
                  
                  h4("'Misogynistic Sentiment Rating' calculated using the sentiment rating and misogynistic word count for each song. (With a rating of zero meaning low misogynistic sentiment) ")),
              
             
                 
             fluidPage(
                 titlePanel("Sentiment by Artist"),
                     
                  
                     selectInput("x", "Artist:",
                                        c("Grandmaster Melle Mel" = "grandmaster_melle_mel", "Kurtis Blow" =  "kurtis_blow", "Kool Moe Dee" = "kool_moe_dee", "Run DMC" =  "run_dmc", "LL Cool J" = "ll_cool_j", "Roxanne Shante" = "roxanne_shante", "Slick Rick" = "slick_rick", "Beastie Boys" = "beastie_boys", "KRS-One" =  "krsone", "Too $hort"=  "too_short", "Schoolly D" = "schoolly_d", "Ice Cube" = "ice_cube", "Chuck D" = "chuck_d", "Grand Puba" = "grand_puba", "Kool G Rap" = "kool_g_rap", "Big Daddy Kane" = "big_daddy_kane", "N.W.A." = "nwa", "Method Man" = "method_man", "Scarface" = "scarface", "Dres" = "dres", "Redman" = "redman", "Nas" = "nas", "Notorious BIG" = "notorious_big", "2Pac" = "2pac", "Raekwon" = "raekwon", "Prodigy" = "prodigy", "Busta Rhymes" = "busta_rhymes", "Twista" = "twista", "DMX" = "dmx", "Jay-Z" = "jayz", "Big Pun" = "big_pun", "Lauryn Hill" = "lauryn_hill", "Eminem" = "eminem", "Ghostface Killah" = "ghostface_killah", "Ludacris" = "ludacris", "Jadakiss" = "jadakiss", "Dr. Dre" = "dr_dre", "50 Cent" = "50_cent", "Common" = "common", "T.I." = "ti", "Lil Wayne" = "lil_wayne","Gucci Mane" = "gucci_mane", "Rick Ross" = "rick_ross", "Kanye West" = "kanye_west", "Drake" = "drake","Nicki Minaj" = "nicki_minaj")),  
                    
                     plotOutput("plot2")),
             h4("Overall sentiment rating of each song by the selected artist")),
    
    
             
    tabPanel("Misogynistic Terms",
             fluidPage(
                 titlePanel("Total Word Count"),
    
                 plotOutput("plot3"),
                 h4("Average frequency of misogynistic terms per song")), 
             
             fluidPage(
                 titlePanel("By Artist"),
                 
                 
                 selectInput("x2", "Artist:",
                                    c("Nicki Minaj" = "nicki_minaj", "Kurtis Blow" =  "kurtis_blow", "Kool Moe Dee" = "kool_moe_dee", "Run DMC" =  "run_dmc", "LL Cool J" = "ll_cool_j", "Roxanne Shante" = "roxanne_shante", "Slick Rick" = "slick_rick", "Beastie Boys" = "beastie_boys", "KRS-One" =  "krsone", "Too $hort"=  "too_short", "Schoolly D" = "schoolly_d", "Ice Cube" = "ice_cube", "Chuck D" = "chuck_d", "Grand Puba" = "grand_puba", "Kool G Rap" = "kool_g_rap", "Big Daddy Kane" = "big_daddy_kane", "N.W.A." = "nwa", "Method Man" = "method_man", "Scarface" = "scarface", "Dres" = "dres", "Redman" = "redman", "Nas" = "nas", "Notorious BIG" = "notorious_big", "2Pac" = "2pac", "Raekwon" = "raekwon", "Prodigy" = "prodigy", "Busta Rhymes" = "busta_rhymes", "Twista" = "twista", "DMX" = "dmx", "Jay-Z" = "jayz", "Big Pun" = "big_pun", "Lauryn Hill" = "lauryn_hill", "Eminem" = "eminem", "Ghostface Killah" = "ghostface_killah", "Ludacris" = "ludacris", "Jadakiss" = "jadakiss", "Dr. Dre" = "dr_dre", "50 Cent" = "50_cent", "Common" = "common", "T.I." = "ti", "Lil Wayne" = "lil_wayne","Gucci Mane" = "gucci_mane", "Rick Ross" = "rick_ross", "Kanye West" = "kanye_west", "Drake" = "drake")),  
                 
                 plotOutput("plot4")),
             h4("Here we have the total count of misogynistic words used in each song by the selected artist")),
    
    
    tabPanel("Regression Model", 
             fluidPage(
                 titlePanel("Year and Misogynistic Sentiment Rating"), 
                #   sidebarLayout(
                #       sidebarPanel(),
                #       mainPanel(
                 #img(src = sentiment_rate_mod.png),
               
                   plotOutput("plot5"), 
                 h3("This model represents the prevalence of misogynistic sentiments in rap as a function of the year the respective artist was popular. There is a very weak positive coorelation here, but a more thorough analysis of the data would be necessary to understand potential correlation between nuanced misogynistic sentiment and era. ") 
                 )))

#Defining all output plots..created here and in .rmd

server <- function(input, output) {
    
    
    
    output$plot2 <- renderPlot({
        
        complete_data %>%
            rename(artist = "Artist", title = "titles") %>%
            
            select(words, artist, title) %>%
            group_by(artist, title) %>%
            get_sentences() %>%
            
            
            sentiment_by(complete_data$words, by = c("artist", "title"),  
                         averaging.function = sentimentr::average_mean) %>%
        
       
            rename(song_sentiment = ave_sentiment) %>%
        
         
            filter(artist == input$x) %>%
            group_by(title) %>%
            ggplot(aes(x = reorder(title, desc(song_sentiment)), y = song_sentiment)) +
            geom_col(color = "steelblue", fill = "darkblue") +
            
            labs(title = "Sentiment Ratings by Song", y = "Sentiment Rating", x = "Songs") +
            theme_clean() +
            theme(axis.text.x = element_blank()) 
   
    }, res = 96)
    
    
    output$plot3 <- renderPlot({
        #avg_words_model
        complete_data %>%
            rename(artist = "Artist", title = "titles") %>%
            
            #select(artist, words, title) %>%
            group_by(artist, title) %>%
            
            mutate(bitch = sum(str_count(words, "bitch")),
                   hoe = sum(str_count(words, "hoe")), 
                   slut = sum(str_count(words, "slut")),
                   whore = sum(str_count(words, "whore")), 
                   tease = sum(str_count(words, "tease")), 
                   trick = sum(str_count(words, "trick")),
                   gold_digger = sum(str_count(words, "gold digger"))) %>%
            
            #maybe group by title here again then summarise so all the zero rows don't show up...?? Looks messy 
            
            mutate(sumrow = bitch + hoe + slut + whore + tease + trick + gold_digger) %>%
            group_by(artist) %>%
            summarise(avg_count = mean(sumrow)) %>%
            
            
            ggplot(aes(x = factor(artist, level = c("grandmaster_caz", "grandmaster_melle_mel", "kurtis_blow", "kool_moe_dee", "spoonie_gee", "jimmy_spicer",  "run_dmc", "ll_cool_j", "roxanne_shante", "slick_rick", "beastie_boys", "lil_boosie",  "krsone", "too_short", "schoolly_d", "ice_cube", "chuck_d", "grand_puba", "kool_g_rap", "big_daddy_kane", "nwa", "method_man",  "scarface", "dres", "redman", "nas", "notorious_big", "2pac", "raekwon", "prodigy", "busta_rhymes", "twista", "dmx", "jayz", "2_live_crew", "big_pun", "lauryn_hill", "eminem", "ghostface_killah", "ludacris", "jadakiss", "korn", "dr_dre", "50_cent", "common", "killer_mike", "ti",  "lil_wayne", "gucci_mane", "rick_ross",  "kanye_west","drake", "nicki_minaj")), y = avg_count)) +
            geom_col(aes(stat = "identity", position = "stack"), color = "skyblue", fill = "darkblue") +
            labs(title = "Misogynistic Terms in Popular Rap", subtitle = "Average number of misogynistic terms used per song by the popular rappers from 1979-2016 ", x = "Artist", y = "Average Number of Terms per Song") +
            theme(axis.text.x = element_text(angle = 90)) +
            scale_x_discrete(labels = c("Grandmaster Caz", "Grandmaster Melle Mel", "Kurtis Blow", "Kool Moe Dee", "Spoonie Gee", "Jimmy Spicer",  "Run-DMC", "LL Cool J", "Roxanne Shante", "Slick Rick", "Beastie Boys", "Lil Boosie",  "KRS-One", "Too $hort", "Schoolly D", "Ice Cube", "Chuck D", "Grand Puba", "Kool G Rap", "Big Daddy Kane", "NWA", "Method Man",  "Scarface", "Dres", "Redman", "Nas", "Notorious B.I.G.", "2Pac", "Raekwon", "Prodigy", "Busta Rhymes", "Twista", "DMX", "Jay-Z", "2 Live Crew", "Big Pun", "Lauryn Hill", "Eminem", "Ghostface Killah", "Ludacris", "Jadakiss", "Korn", "D. Dre", "50 Cent", "Common", "Killer Mike", "T.I.",  "Lil Wayne", "Gucci Mane", "Rick Ross",  "Kanye West","Drake", "Nicki Minaj")) +
            theme_clean() +
            theme(axis.text.x = element_text(angle = 90)) 
        
    }, res = 96)
    
    
    output$plot4 <- renderPlot({
        
        complete_data %>%
            rename(artist = "Artist", title = "titles") %>%
            
            #select(artist, words, title) %>%
            group_by(artist, title) %>%
            
            mutate(bitch = sum(str_count(words, "bitch")),
                   hoe = sum(str_count(words, "hoe")), 
                   slut = sum(str_count(words, "slut")),
                   whore = sum(str_count(words, "whore")), 
                   tease = sum(str_count(words, "tease")), 
                   trick = sum(str_count(words, "trick")),
                   gold_digger = sum(str_count(words, "gold digger"))) %>%
            
            #maybe group by title here again then summarise so all the zero rows don't show up...?? Looks messy 
            
            mutate(sumrow = bitch + hoe + slut + whore + tease + trick + gold_digger) %>%
        
        

       #  avg_words %>%
            filter(artist == input$x2) %>%
             group_by(title) %>%
         
        ggplot(aes(x = title, y = sumrow)) +
             geom_col(color = "skyblue", fill = "darkblue") +
         labs(title = "Misogynistic Term Count by Artist", subtitle = "Per song", x = "Artist", y = "Word Count") +
             theme(axis.text.x = element_text(angle = 90)) +
             theme_clean() +
            
    #This looks a hot mess with all the titles so just take them all off
            
            theme(axis.text.x = element_blank(), 
                  axis.title.x = element_blank(), 
                  axis.ticks.x = element_blank()) 
        
    }, res = 96)
    
    
    output$plot5 <- renderPlot({
        
        
        # # excel2 <- read_csv("final_project/excel_data/excel2.csv")   
        # # excel2 %>%
        # #     select(!X4) %>%
        # #     rename(net = "Net Worth") %>%
        # #     rename(artist = "Artist")
        # # 
        # # big <- merge(excel2, new_scores)
        # 
         big <- read_csv("big.csv")
        # 
         fit_big <- stan_glm(data = big, 
                  
        #          #Looking at the year's effect on misogyny score
        #          
                  sentiment_score ~  Year, 
                  family = gaussian(), 
                  refresh = 0)
         
         
         tbl_regression(fit_big, intercept = TRUE) %>%
             as_gt()%>%
             tab_header(title = "Regression of Misogynistic Sentiment Ratings", 
                        subtitle = "The Effect of Year on Misogynistic Sentiment in Rap Music") 
        
        
       
        #regression_model
    }, res = 96)
    
    
    output$plot6 <- renderPlot({
        
        
         total_count <- complete_data %>%
             rename(artist = "Artist", title = "titles") %>%
             
             select(artist, words, title) %>%
             group_by(title) %>%
        #     
        #     
        #     
             mutate(bitch = sum(str_count(words, "bitch")),
                    hoe = sum(str_count(words, "hoe")), 
                    slut = sum(str_count(words, "slut")),
                    whore = sum(str_count(words, "whore")), 
                    tease = sum(str_count(words, "tease")), 
                    trick = sum(str_count(words, "trick")),
                    gold_digger = sum(str_count(words, "gold digger"))) %>% 
             
             group_by(artist) %>%
             mutate(sumrow = sum(c(bitch, hoe, slut, whore, tease, trick, gold_digger))) 
         
         
         total_sentiments <- complete_data %>%
        #     
             select(words, artist, title) %>%
             group_by(artist, title) %>%
             get_sentences() %>%
             
             
             sentiment_by(total_sentiments$words, by = c("artist", "title"),  
                          averaging.function = sentimentr::average_mean) 
         
         total_sentiments <- total_sentiments%>%
             rename(song_sentiment = ave_sentiment)

         new_scores <- merge(total_sentiments, total_count) %>%
             mutate(sentiment_rating = case_when((song_sentiment >= 0 & sumrow <= 0) ~ "positive", 
                                                 # (ave_sentiment == 0) ~ "neutral", 
                                                 (song_sentiment <= 0 & sumrow >= 0) ~ "negative", 
                                                 TRUE ~ "neutral")) %>%
             
             mutate(sentiment_score = case_when(sentiment_rating == "positive" ~ -1, 
                                                sentiment_rating == "neutral" ~ 0, 
                                                sentiment_rating == "negative" ~ 1)) %>%
             group_by(artist) %>% 
             mutate(score = sum(sentiment_score)) 
         
         
         
         
          new_scores %>%
              
              ggplot(aes(x = factor(artist, level = c("grandmaster_caz", "grandmaster_melle_mel", "kurtis_blow", "kool_moe_dee", "spoonie_gee", "jimmy_spicer",  "run_dmc", "ll_cool_j", "roxanne_shante", "slick_rick", "beastie_boys",  "krsone", "too_short", "schoolly_d", "ice_cube", "chuck_d", "grand_puba", "kool_g_rap", "big_daddy_kane", "nwa", "method_man",  "scarface", "dres", "redman", "nas", "notorious_big", "2pac", "raekwon", "prodigy", "busta_rhymes", "twista", "dmx", "jayz", "big_pun", "lauryn_hill", "eminem", "ghostface_killah", "ludacris", "jadakiss", "dr_dre", "50_cent", "common", "ti",  "lil_wayne", "gucci_mane", "rick_ross",  "kanye_west","drake", "nicki_minaj")), y = score)) +
              # geom_line(aes(group = 1)) +
              geom_col(color = "darkblue", fill = "steelblue") +
          
              
              scale_x_discrete(labels = c("Grandmaster Caz", "Grandmaster Melle Mel", "Kurtis Blow", "Kool Moe Dee", "Spoonie Gee", "Jimmy Spicer",  "Run-DMC", "LL Cool J", "Roxanne Shante", "Slick Rick", "Beastie Boys", "Lil Boosie",  "KRS-One", "Too $hort", "Schoolly D", "Ice Cube", "Chuck D", "Grand Puba", "Kool G Rap", "Big Daddy Kane", "NWA", "Method Man",  "Scarface", "Dres", "Redman", "Nas", "Notorious B.I.G.", "2Pac", "Raekwon", "Prodigy", "Busta Rhymes", "Twista", "DMX", "Jay-Z", "2 Live Crew", "Big Pun", "Lauryn Hill", "Eminem", "Ghostface Killah", "Ludacris", "Jadakiss", "Korn", "D. Dre", "50 Cent", "Common", "Killer Mike", "T.I.",  "Lil Wayne", "Gucci Mane", "Rick Ross",  "Kanye West","Drake", "Nicki Minaj")) +
              theme(axis.text.x = element_text(angle = 90)) %>%
              labs(title = "Misogynistic Sentiment Ratings", subtitle = "For Artists from 1979-2016", x = "Artist", y = "Rating") +
              
              theme_clean() +
              theme(axis.text.x = element_text(angle = 90)) 
        
    }, res = 96)

} 



# Run the application 
shinyApp(ui = ui, server = server)