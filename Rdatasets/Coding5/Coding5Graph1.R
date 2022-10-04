#set directory
rm(list=ls())
setwd("C:\\Users\\alanl\\OneDrive\\Documents\\Rdatasets\\")
getwd()

#libraries
library(ggplot2)
library(readr)

#data for GDP Per capita in various countries from 1990 to 2020
GDPPerCapita <- read_csv("Coding5/GDPPerCapita.csv")

#line graph
ggplot(GDPPerCapita, aes(x = Year, y = GDP, fill = Country)) +
  geom_line() +
  geom_point(size = 4, shape = 21)  + # Also use a point with a color fill
  labs(title = "GDP Per Capita for Various Countries from 1990 to 2020")