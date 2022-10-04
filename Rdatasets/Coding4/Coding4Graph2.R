#set directory
rm(list=ls())
setwd("C:\\Users\\alanl\\OneDrive\\Documents\\Rdatasets\\")
getwd()

#libraries
library(ggplot2)
library(readr)

#data for life expectancy in 2022, South American Countries
HealthcareDataCSV <- read_csv("Coding4/HealthcareDataCSV.csv")

#Cleveland dot plot
ggplot(HealthcareDataCSV, aes(x = Region,
                         y = Health_Spending, fill = Country)) +
  geom_col() +
  scale_fill_brewer(palette = "Pastel1") +
  ylab("Health Spending") +
  xlab("Region") +
  labs(title = "2020 Health Care Spending by Region: Top 3 Countries")