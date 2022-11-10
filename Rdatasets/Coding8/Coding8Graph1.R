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
Data <- read_csv("Coding8/meat.csv")

#data manipulation
df <- data.frame(Data)
#remove columns
df <- subset(df, select = -c(MEASURE))
#filter beef only
df <- filter(df, SUBJECT == "BEEF")
#filter out countries with negligible consumption values
df <- filter(df, Value > 1000)

#filter out groups of countries
df <- filter(df, LOCATION != "WLD")
df <- filter(df, LOCATION != "OECD")
df <- filter(df, LOCATION != "EU28")
df <- filter(df, LOCATION != "SSA")
df <- filter(df, LOCATION != "BRICS")

#dot plot
ggplot(df, aes(x = TIME, y = Value, colour = LOCATION, group = SUBJECT)) +
  geom_point(size = 2, shape = 16) +
  labs(title = "Beef Consumption Over Time in Various Countries", 
       subtitle = "For Countries With Consumption Values Over 1000",
       x = "Year",
       colour = "Country") +
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

#ggsave("BeefConsumption.png", dpi = 300)
