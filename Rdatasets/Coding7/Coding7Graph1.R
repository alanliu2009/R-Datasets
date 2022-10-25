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
ggplot(df, aes(x = NetWorth, y = Age, colour = Children)) +
  geom_point(size = 2, shape = 16)  + # Also use a point with a color fill
  labs(title = "Net Worth vs Age for all Billionaires", 
       subtitle = "Forbes List of Billionaires 2021", 
       caption = "Data Source: https://www.kaggle.com/
       datasets/alexanderbader/forbes-billionaires-2021-30",
       x = "Net Worth") +
  theme_grey() +
  scale_x_continuous(trans='log2') + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5), 
        plot.background = element_rect(fill = "aliceblue"), 
        panel.grid.major = element_line(colour = "gray90"),
        panel.grid.minor = element_line(colour = "gray90"),
        panel.background = element_rect(fill = "white", colour = "black"),
        legend.background = element_rect(fill = "azure3"),
        legend.title = element_text(hjust = 0.5, face = "bold")
  )

#ggsave("NetWorth_vs_Age.png", dpi = 300)
