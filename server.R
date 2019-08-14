# DEVELOPING DATA PRODUCTS: COURSE PROJECT, SHINY SERVER

#' Date: 2019-08-13
#' R Version: 3.6.0
#' RStudio Version: 1.2.1335
#' Operating System: Windows 10



# SET WORKING DIRECTORY

wd <- paste0("~/Coursera/Data Science",
             " Specialization (Johns ",
             "Hopkins)/Course 9 - Dev",
             "eloping Data Products/W",
             "eek 4 Project/Shiny App")

setwd(wd); rm(wd)



# DETECT & LOAD PACKAGES

if(!require(readr)){install.packages("readr")}
if(!require(dplyr)){install.packages("dplyr")}
if(!require(tidyr)){install.packages("tidyr")}
if(!require(shiny)){install.packages("shiny")}
if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(stringr)){install.packages("stringr")}

library(readr)
library(dplyr)
library(tidyr)
library(shiny)
library(ggplot2)
library(stringr)



# READ IN DATA

url <- paste0("https://raw.githubusercontent.com/jamisoncraw",
              "ford/ddp_app/master/Data/onet_bls_untidy.csv")

dat <- read_csv(url); rm(url)

url <- paste0("https://raw.githubusercontent.com/jamisoncraw",
              "ford/ddp_app/master/Data/onet_bls_merged.csv")

unt <- read_csv(url); rm(url)



# SHINY SERVER

shinyServer(function(input, output) {
  
  model <- lm(myr ~ artistic + conventional + enterprising + investigative + realistic + social, data = dat)
  
  model_pred <- reactive({
    art_input <- input$slider_art
    con_input <- input$slider_con
    ent_input <- input$slider_ent
    inv_input <- input$slider_inv
    rea_input <- input$slider_rea
    soc_input <- input$slider_soc
    predict(model, newdata = data.frame(artistic = art_input,
                                        conventional = con_input,
                                        enterprising = ent_input,
                                        investigative = inv_input,
                                        realistic = rea_input,
                                        social = soc_input))
  })
  
  output$plot <- renderPlot({
    
    set.seed(1)
    
    p <- ggplot(unt, aes(x = val, y = myr)) +
      geom_jitter(alpha = 0.15) +
      labs(title = "Median annual salary v. areas of interest",
           subtitle = "United States occupations, 2018",
           x = "Interest Level",
           y = "Median Annual Salary (K)",
           caption = "Sources: Bureau of Labor Statistics,\nOccupational Information Network") +
      scale_y_continuous(breaks = c(0, 50000, 100000, 150000, 200000),
                         label = c("$0", "$50", "$100", "$150", "$200")) +
      facet_wrap(~ elm, nrow = 3, ncol = 2) +
      theme_minimal() + 
      theme(title = element_text(size = 12),
            strip.text = element_text(size = 11), 
            axis.title.x = element_text(vjust = 0),
            axis.title.y = element_text(vjust = 3))
    
    if(input$show_model & input$show_pred){
      p + geom_path(aes(x = val, 
                        y = model_pred(),
                        color = "#FFA400"), 
                    lwd = 1) +
        geom_smooth(method = "lm", 
                    aes(color = "#1E90FF")) +
        theme(legend.position = "bottom") +
        scale_color_manual(name = NULL, 
                           values = c("#1E90FF", "#FFA400"), 
                           labels = c("Trend Line", "Predicted Salary"))
    } else if (input$show_model & !input$show_pred){
      p + geom_smooth(method = "lm", 
                      aes(color = "#1E90FF")) +
        theme(legend.position = "bottom") +
        scale_color_manual(name = NULL, 
                           values = "#1E90FF", 
                           labels = "Trend Line")
    } else if (!input$show_model & input$show_pred){
      p + geom_path(aes(x = val, 
                        y = model_pred(),
                        color = "#FFA400"), 
                    lwd = 1) +
        theme(legend.position = "bottom") +
        scale_color_manual(name = NULL, 
                           values = "#FFA400", 
                           labels = "Predicted Salary")
    } else {
      p
    }
    
  }, height = 600)
  
  output$pred <- renderText(dollar({
    model_pred()
  }))
  
})