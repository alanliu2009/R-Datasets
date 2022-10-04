
#set directory
rm(list=ls())
setwd("C:\\Users\\alanl\\OneDrive\\Documents\\Rdatasets\\")
getwd()

#libraries
library(ggplot2)
library(readr)

#data for life expectancy in 2022, South American Countries
LifeExpectancy_csv <- read_csv("Coding3/LifeExpectancy.csv")

#bar graph
ggplot(LifeExpectancy_csv, aes(x = Country, y = LifeExpectancy)) +
  geom_col()
