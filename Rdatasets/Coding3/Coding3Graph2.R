
#set directory
rm(list=ls())
setwd("C:\\Users\\alanl\\OneDrive\\Documents\\Rdatasets\\")
getwd()

#libraries
library(ggplot2)
library(readr)

#data for GDP per capita in 2022, Middle Eastern Countries
GDPperCapita <- read_csv("Coding3/GDPperCapita.csv")

#bar graph
ggplot(GDPperCapita, aes(x = Country, y = GDP_per_Capita)) +
  geom_col()
