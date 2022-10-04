#set directory
rm(list=ls())
setwd("C:\\Users\\alanl\\OneDrive\\Documents\\Rdatasets\\")
getwd()

#libraries
library(ggplot2)
library(readr)

#data for life expectancy in 2022, South American Countries
COVIDDataCSV <- read_csv("Coding4/COVIDDataCSV.csv")

#Cleveland dot plot
ggplot(COVIDDataCSV, aes(x = Confirmed_Cases,
                         y = reorder(Country, Confirmed_Cases))) +
  geom_point(size = 3) +  # Use a larger dot
  theme_bw() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(colour = "grey60", linetype = "dashed")
  ) +
  ylab("Country") +
  xlab("Confirmed Cases") +
  labs(title = "Confirmed COVID Cases by Country July 2022")