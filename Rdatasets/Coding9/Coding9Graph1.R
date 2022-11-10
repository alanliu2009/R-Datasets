#set directory

rm(list=ls())
setwd("C:\\Users\\alanl\\OneDrive\\Documents\\Rdatasets\\")
getwd()

#libraries
library(ggplot2)
library(readr)
library(tidyr)
library(tidyverse)
library(dplyr)

#data import
Data <- read_csv("Coding9/travel.csv")

#data frame
df <- data.frame(Data)
#filter out countries with negligible consumption values
df <- filter(df, International.tourism..number.of.arrivals > 50000000)

#filter out groups of countries
df <- na.omit(df)
df <- filter(df, Code != "OWID_WRL")

#dot plot
ggplot(df, aes(x = Year, y = International.tourism..number.of.arrivals,
               colour = Code)) +
  geom_point(size = 2, shape = 16) +
  labs(title = "Travel to Countries in the past 20 Years", 
       subtitle = "For Countries With Over 50 Million Yearly Arrivals",
       x = "Year",
       colour = "Country",
       y = "Arrivals") +
  theme_grey() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5), 
        plot.background = element_rect(fill = "aliceblue"), 
        panel.grid.major = element_line(colour = "gray90"),
        panel.grid.minor = element_line(colour = "gray90"),
        panel.background = element_rect(fill = "white", colour = "black"),
        legend.background = element_rect(fill = "azure3"),
        legend.title = element_text(hjust = 0.5, face = "bold")
  )

#ggsave("TravelRates.png", dpi = 300)
