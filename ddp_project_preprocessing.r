# DEVELOPING DATA PRODUCTS: COURSE PROJECT

    #' Date: 2019-08-13
    #' R Version: 3.6.0
    #' RStudio Version: 1.2.1335
    #' Operating System: Windows 10



# CLEAR ENVIRONMENT & SET WORKING DIRECTORY

rm(list = ls())                                       # Clear environment

wd <- paste0("~/Coursera/Data Science Specializat",
             "ion (Johns Hopkins)/Course 9 - Deve",
             "loping Data Products/Week 4 Project")   # Specify directory

setwd(wd)                                             # Set directory

rm(wd)                                                # Rm object



# INSTALL & LOAD PACKAGES

if(!require(readr)){install.packages("readr")}
if(!require(dplyr)){install.packages("dplyr")}
if(!require(ggplot2)){install.packages("ggplot2")}    # Detect packages

library(readr)
library(dplyr)
library(ggplot2)                                      # Load packages



# READ IN & CLEAN: DOL O*NET INTERESTS & BLS WAGE DATA

int <- paste0("https://raw.githubuser", 
              "content.com/jamisoncra",
              "wford/ddp_app/master/D",
              "ata/onet_interests.csv")               # Specify onet url

int <- read_csv(int) %>%                              # Read in data
  rename(soc = `O*NET-SOC Code`,
         job = Title,
         elm = `Element Name`,
         val = `Data Value`) %>%                      # Rename vars
  select(soc, job, elm, val) %>%                      # Rm vars
  filter(elm != "First Interest High-Point",
         elm != "Second Interest High-Point",
         elm != "Third Interest High-Point",          # Fltr non-elements
         grepl(".*{8}00", soc)) %>%                   # Fltr non-detailed socs
  mutate(soc = substr(soc, 1, 7))                     # Rm trailing ".00"

wag <- paste0("https://raw.githubuse",
              "rcontent.com/jamisonc",
              "rawford/ddp_app/maste",
              "r/Data/bls_wages.csv")                 # Specify bls url

wag <- read_csv(wag) %>%                              # Read in data
  rename(soc = OCC_CODE,
         job = OCC_TITLE,
         mhr = H_MEDIAN,
         myr = A_MEDIAN) %>%                          # Rename vars
  select(soc, job, mhr, myr)                          # Rm vars



seq <- as.character(11:53)                            # Init job cat seq
wag$cat <- NA                                         # Init var "cat"

for (i in seq_along(wag$soc)){
  for (j in seq_along(seq)){
    if (grepl(x = wag$soc[i], pattern = paste0(seq[j], "-[0-9]{4}$"))){
      wag$cat[i] <- as.character(wag[wag$soc == paste0(seq[j], "-0000"), "job"])
    }
  }
}                                                     # Assign categories


all <- left_join(int, wag) %>%                        # Merge onet, bls
  filter(mhr != "*",
         mhr != "#",
         !is.na(mhr),
         myr != "*",
         myr != "#",
         !is.na(myr)) %>%                             # Rm missing vals
  mutate(mhr = as.numeric(mhr),
         myr = gsub(",", "", myr),                    # Remove commas
         myr = as.numeric(myr),                       # Wages to "numeric"
         cat = gsub(" Occupations$", "", cat)) %>%
  select(cat, soc:myr)                                # Rearrange vars

rm(int, wag, i, j, seq)                               # Rm objects



# DEMO VISUALIZATION: ANNUAL SALARY V. CAREER INTERESTS

ggplot(all, aes(x = val, y = myr)) +
  geom_jitter(alpha = 0.25) +
  geom_smooth(method = "lm") +
  labs(title = "Median annual salary v. areas of interest",
       subtitle = "United States occupations, 2018",
       x = "Interest Level",
       y = "Median Annual Salary (K)",
       caption = "Sources: Bureau of Labor Statistics,\nOccupational Information Network") +
  scale_y_continuous(breaks = c(0, 50000, 100000, 150000, 200000),
                     label = c("$0", "$50", "$100", "$150", "$200")) +
  facet_wrap(~ elm) +
  theme_minimal()



# WRITE TO .CSV

write_csv(all, "onet_bls_mrg.csv")                      # Write to .CSV