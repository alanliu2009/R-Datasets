
#set directory
rm(list=ls())
setwd("C:\\Users\\alanl\\OneDrive\\Documents\\Rdatasets\\Coding2")
getwd()

#libraries
library(ggplot2)
library(readr)

#data manipulation
UEdata = read.csv("UnemploymentCSV.csv")
port = UEdata[, 1:2]
port$country = "Portugal"
names(port)[2] = "Unemployment"
yem = UEdata[, c(1,3)]
yem$country = "Yemen"
names(yem)[2] = "Unemployment"
us = UEdata[, c(1,4)]
us$country = "United States"
names(us)[2] = "Unemployment"
UEdata1 = rbind.data.frame(port,yem,us)


#plot
ggplot(UEdata1, aes(x = Year, color = country)) +
  geom_line(size = 1.5, aes(y = Unemployment)) +
  ylab("Unemployment") +
  ggtitle("Unemployment in the last 20 years") +
  scale_colour_manual(values = c('Portugal' = 'turquoise',
                                 'United States' = 'tan1',
                                 'Yemen' = 'darkolivegreen'))