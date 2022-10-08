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
library(gganimate)
library(gifski)

############
#POPULATION#
############

#data for Population of all countries for past 20 years
Population <- read_csv("Animated_Dotplot/Population_updated.csv")

#data manipulation
PopulationDF <- data.frame(Population)
#remove columns
PopulationDF <- subset(PopulationDF,
                       select = -c(Series.Name:Series.Code, Country.Code))
#transpose
PopulationDF <- t(PopulationDF)
#set second row as headers
colnames(PopulationDF) <- PopulationDF[1, ]   # Convert first row to header
PopulationDF <- PopulationDF[-c(1), ]      # Delete first row
#change row names to be a column (Year)
PopulationDF <- cbind(rownames(PopulationDF), PopulationDF)
rownames(PopulationDF) <- NULL
colnames(PopulationDF)[1] <- "Year" # Set first column name to year
#add consecutive numbers, extract year
PopulationDF <- data.frame(PopulationDF)
PopulationDF$Year <- gsub("[^0-9]","", PopulationDF$Year) # Extract numbers
PopulationDF$Year = substr(PopulationDF$Year,1,4) # Extract first 4 characters

#convert data from wide to long
PopulationDF <- gather(PopulationDF, Country, Population, 2:218) # All countries
#convert population column to numeric
PopulationDF$Population <- as.numeric(as.character(PopulationDF$Population))
#divide population by 100,000
PopulationDF$Population <- PopulationDF$Population / 100000


#################
#LIFE EXPECTANCY#
#################

#data for LifeExpectancy of all countries for past 20 years
LifeExpectancy <- read_csv("Animated_Dotplot/LifeExpectancy_updated.csv")

#data manipulation
LifeExpectancyDF <- data.frame(LifeExpectancy)
#remove columns
LifeExpectancyDF <- subset(LifeExpectancyDF,
                           select = -c(Series.Name:Series.Code, Country.Code))
#transpose
LifeExpectancyDF <- t(LifeExpectancyDF)
#set second row as headers
colnames(LifeExpectancyDF) <- LifeExpectancyDF[1, ]# Convert first row to header
LifeExpectancyDF <- LifeExpectancyDF[-c(1), ]      # Delete first row
#change row names to be a column (Year)
LifeExpectancyDF <- cbind(rownames(LifeExpectancyDF), LifeExpectancyDF)
rownames(LifeExpectancyDF) <- NULL
colnames(LifeExpectancyDF)[1] <- "Year" # Set first column name to year
#add consecutive numbers, extract year
LifeExpectancyDF <- data.frame(LifeExpectancyDF)
# Extract numbers
LifeExpectancyDF$Year <- gsub("[^0-9]","", LifeExpectancyDF$Year)
# Extract first 4 characters
LifeExpectancyDF$Year = substr(LifeExpectancyDF$Year,1,4) 

#convert data from wide to long
# All countries
LifeExpectancyDF <- gather(LifeExpectancyDF, Country, LifeExpectancy, 2:218) 
#convert LifeExpectancy column to numeric
LifeExpectancyDF$LifeExpectancy <- 
  as.numeric(as.character(LifeExpectancyDF$LifeExpectancy))


#####
#GDP#
#####

#data for GDP of all countries for past 20 years
GDP <- read_csv("Animated_Dotplot/GDP_updated.csv")

#data manipulation
GDPDF <- data.frame(GDP)
#remove columns
GDPDF <- subset(GDPDF,
                select = -c(Series.Name:Series.Code, Country.Code))
#transpose
GDPDF <- t(GDPDF)
#set second row as headers
colnames(GDPDF) <- GDPDF[1, ]   # Convert first row to header
GDPDF <- GDPDF[-c(1), ]      # Delete first row
#change row names to be a column (Year)
GDPDF <- cbind(rownames(GDPDF), GDPDF)
rownames(GDPDF) <- NULL
colnames(GDPDF)[1] <- "Year" # Set first column name to year
#add consecutive numbers, extract year
GDPDF <- data.frame(GDPDF)
GDPDF$Year <- gsub("[^0-9]","", GDPDF$Year) # Extract numbers
GDPDF$Year = substr(GDPDF$Year,1,4) # Extract first 4 characters

#remove null columns
GDPDF <- subset(GDPDF, select = -c(219:657))

#convert data from wide to long
GDPDF <- gather(GDPDF, Country, GDP, 2:218) # All countries
#convert GDP column to numeric
GDPDF$GDP <- as.numeric(as.character(GDPDF$GDP))
#divide GDP by 10,000
GDPDF$GDP <- GDPDF$GDP / 10000

#############
###OVERALL###
#############

DF_total <- list(GDPDF, LifeExpectancyDF, PopulationDF)
DF_total <- Reduce(function(x, y) merge(x, y, all=TRUE), DF_total)

#convert Year column to numeric
DF_total$Year <- as.numeric(as.character(DF_total$Year))



#animated dot plot

myPlot <- ggplot(
  DF_total, 
  aes(x = GDP, y=LifeExpectancy, size = Population, colour = Country)) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life expectancy") +
  transition_time(Year) +
  shadow_mark(alpha = 0.3, size = 0.5) +
  labs(title = "Year: {as.integer(frame_time)}") +
  theme(axis.title=element_text(size=20),
        plot.title = element_text(size = 25),
        plot.background = element_rect(fill = "aliceblue"), 
        panel.grid.major = element_line(colour = "gray90"),
        panel.grid.minor = element_line(colour = "gray90"),
        panel.background = element_rect(fill = "white", colour = "black")
        )

animate(myPlot, duration = 10, fps = 30, width = 500, height = 500, 
        renderer = gifski_renderer())
anim_save("AnimatedDotplot.gif", dpi = 300)