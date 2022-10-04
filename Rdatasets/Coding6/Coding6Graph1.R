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

#data for Population of 5 countries for past 50 years
Population <- read_csv("Coding6/Population.csv")

#data manipulation
PopulationDF <- data.frame(Population)
#remove columns
PopulationDF <- subset(PopulationDF,
                       select = -c(Series.Name:Series.Code, Country.Code))
#remove null rows
PopulationDF <- PopulationDF[-c(6:10), ]
#transpose
PopulationDF <- t(PopulationDF)
#set second row as headers
colnames(PopulationDF) <- PopulationDF[1, ]   # Convert first row to header
PopulationDF <- PopulationDF[-c(1), ]      # Delete first row
#change row names to be a column (Year)
PopulationDF <- cbind(rownames(PopulationDF), PopulationDF)
rownames(PopulationDF) <- NULL
colnames(PopulationDF) <- c("Year",
                            "Chad","Greece", "Israel", "Sweden", "Hungary")
#add consecutive numbers, extract year
PopulationDF <- data.frame(PopulationDF)
PopulationDF$Year <- gsub("[^0-9]","", PopulationDF$Year) # Extract numbers
PopulationDF$Year = substr(PopulationDF$Year,1,4) # Extract first 4 characters

#convert data from wide to long
PopulationDF <- gather(PopulationDF, Country, Population, 
                       Chad, Greece, Israel, Sweden, Hungary)
#convert population column to numeric
PopulationDF$Population <- as.numeric(as.character(PopulationDF$Population))
#divide population by 1 million
PopulationDF$Population <- PopulationDF$Population / 1000000

#line graph
ggplot(PopulationDF, aes(x = Year, y = Population, colour = Country, 
                         group = Country, linetype = Country)) +
  geom_line(size = 1) +
  #geom_point(size = 2, shape = 21)  + # Also use a point with a color fill
  labs(title = "Population for Countries in the past 50 years", 
       subtitle = "From 1972 to 2021", 
       caption = "Data Source: Worldbank Development Indicators
       https://databank.worldbank.org/reports.aspx?source=2&series=SP.POP.
       TOTL&country=#") +
  scale_x_discrete(breaks = seq(1970, 2025, by = 5)) +
  ylab("Population (Millions)") +
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

#ggsave("Population_v_Year.png", dpi = 300)
