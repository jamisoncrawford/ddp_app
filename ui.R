# DEVELOPING DATA PRODUCTS: COURSE PROJECT, SHINY UI

#' Date: 2019-08-13
#' R Version: 3.6.0
#' RStudio Version: 1.2.1335
#' Operating System: Windows 10



# DETECT & LOAD PACKAGES

if(!require(readr)){install.packages("readr")}
if(!require(dplyr)){install.packages("dplyr")}
if(!require(tidyr)){install.packages("tidyr")}
if(!require(shiny)){install.packages("shiny")}
if(!require(stringr)){install.packages("stringr")}

library(readr)
library(dplyr)
library(tidyr)
library(shiny)
library(scales)
library(stringr)



# READ IN DATA

url <- paste0("https://raw.githubusercontent.com/jamisoncraw",
              "ford/ddp_app/master/Data/onet_bls_untidy.csv")

dat <- read_csv(url); rm(url)



# SHINY UI

shinyUI(fluidPage(
  titlePanel(tags$b("Predicting Salaries with Holland Codes")),
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "slider_art", 
                  label = "Do you consider yourself creative?", 
                  min = 1, 
                  max = 7, 
                  value = 4),
      sliderInput(inputId = "slider_con", 
                  label = "Do you like rules and structure?", 
                  min = 1, 
                  max = 7, 
                  value = 4),
      sliderInput(inputId = "slider_ent", 
                  label = "Do you like to persuade and lead?", 
                  min = 1, 
                  max = 7, 
                  value = 4),
      sliderInput(inputId = "slider_inv", 
                  label = "Are you a curious, deep thinker?", 
                  min = 1, 
                  max = 7, 
                  value = 4),
      sliderInput(inputId = "slider_rea", 
                  label = "Do you prefer hands-on activities?", 
                  min = 1, 
                  max = 7, 
                  value = 4),
      sliderInput(inputId = "slider_soc", 
                  label = "Are you sociable and helpful?", 
                  min = 1, 
                  max = 7, 
                  value = 4),
      checkboxInput(inputId = "show_pred", 
                    label = "Show/Hide Predicted Salary",
                    value = TRUE),
      checkboxInput(inputId = "show_model", 
                    label = "Show/Hide Linear Model",
                    value = TRUE)
    ),
    mainPanel(
      plotOutput("plot", width = "100%", height = "100%"),
      h5(tags$b("Predicted Annual Salary:")),
      textOutput("pred")
    )
  )
))
