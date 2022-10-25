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

#data for billionaires around the world
BillionaireData <- read_csv("Coding7/billionairedata.csv")

#data manipulation
df <- data.frame(BillionaireData)
#remove columns
df <- subset(df, select = -c(Source, Rank, Residence, Citizenship, Education,
                             Status, Self_made))

#line graph
ggplot(df, aes(x = Year, y = BillionaireData, colour = Country, 
                         group = Country, linetype = Country)) +
  geom_line(size = 1) +
  #geom_point(size = 2, shape = 21)  + # Also use a point with a color fill
  labs(title = "BillionaireData for Countries in the past 50 years", 
       subtitle = "From 1972 to 2021", 
       caption = "Data Source: Worldbank Development Indicators
       https://databank.worldbank.org/reports.aspx?source=2&series=SP.POP.
       TOTL&country=#") +
  scale_x_discrete(breaks = seq(1970, 2025, by = 5)) +
  ylab("BillionaireData (Millions)") +
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

#ggsave("BillionaireData_v_Year.png", dpi = 300)
