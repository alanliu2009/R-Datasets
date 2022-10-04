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

#data for GDP per Capita of 5 countries for past 50 years
GDPPerCapita <- read_csv("Coding6/GDPPerCapita.csv")

#data manipulation
GDPPerCapitaDF <- data.frame(GDPPerCapita)
#remove columns
GDPPerCapitaDF <- subset(GDPPerCapitaDF,
                       select = -c(Series.Name:Series.Code, Country.Code))
#remove null rows
GDPPerCapitaDF <- GDPPerCapitaDF[-c(6:10), ]
#transpose
GDPPerCapitaDF <- t(GDPPerCapitaDF)
#set second row as headers
colnames(GDPPerCapitaDF) <- GDPPerCapitaDF[1, ]   # Convert first row to header
GDPPerCapitaDF <- GDPPerCapitaDF[-c(1), ]      # Delete first row
#change row names to be a column (Year)
GDPPerCapitaDF <- cbind(rownames(GDPPerCapitaDF), GDPPerCapitaDF)
rownames(GDPPerCapitaDF) <- NULL
colnames(GDPPerCapitaDF) <- c("Year",
                            "Chad","Greece", "Israel", "Sweden", "Hungary")
#add consecutive numbers, extract year
GDPPerCapitaDF <- data.frame(GDPPerCapitaDF)
GDPPerCapitaDF$Year <- gsub("[^0-9]","", GDPPerCapitaDF$Year) # Extract numbers
GDPPerCapitaDF$Year = substr(GDPPerCapitaDF$Year,1,4) # Extract first 4 characters

#convert data from wide to long
GDPPerCapitaDF <- gather(GDPPerCapitaDF, Country, GDPPerCapita, 
                       Chad, Greece, Israel, Sweden, Hungary)
#convert GDP Per Capita column to numeric
GDPPerCapitaDF$GDPPerCapita <- as.numeric(as.character(GDPPerCapitaDF$GDPPerCapita))
#divide GDP Per Capita by 1 million
GDPPerCapitaDF$GDPPerCapita <- GDPPerCapitaDF$GDPPerCapita / 1000

#line graph
ggplot(GDPPerCapitaDF, aes(x = Year, y = GDPPerCapita, colour = Country, 
                         group = Country, linetype = Country)) +
  geom_line(size = 1) +
  #geom_point(size = 2, shape = 21)  + # Also use a point with a color fill
  labs(title = "GDP Per Capita for Countries in the past 50 years", 
       subtitle = "From 1972 to 2021", 
       caption = "Data Source: Worldbank Development Indicators
       https://databank.worldbank.org/reports.aspx?source=2&series=NY.GDP.
       PCAP.CD&country=#") +
  scale_x_discrete(breaks = seq(1970, 2025, by = 5)) +
  ylab("GDP Per Capita (Thousands)") +
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

#ggsave("GDPPerCapita_v_Year.png", dpi = 300)
