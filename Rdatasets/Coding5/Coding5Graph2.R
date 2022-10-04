#set directory
rm(list=ls())
setwd("C:\\Users\\alanl\\OneDrive\\Documents\\Rdatasets\\")
getwd()

#libraries
library(ggplot2)
library(readr)

#data for GDP Per capita in various countries from 1990 to 2020
LifeExpectancy <- read_csv("Coding5/LifeExpectancy.csv")

#line graph
ggplot(LifeExpectancy, aes(x = LE, 
                           y = reorder(Country, LE))) +
  geom_point(size = 3) +  # Use a larger dot
  theme_bw() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(colour = "grey60", linetype = "dashed")
  ) +
  ylab("Country") +
  xlab("Life Expectancy") +
  labs(title = "Life Expectancy for Various Countries in 2020")
