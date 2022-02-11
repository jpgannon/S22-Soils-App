#Spectral conditions cleaning

#necessary packages
library(lubridate)
library(tidyverse)
library(ggplot2)


#load in csv file
spectralConditionsRaw <- read_csv("hbSoils/data_raw/HBF Spec Cond.csv")

#Select Necessary Columns
cleanSpectral <- spectralConditionsRaw %>% select(Date.Time.EST, SpConductivity)


#Mutate to posix Type
cleanSpectral <- cleanSpectral %>% mutate(timeSeries = mdy_hm(Date.Time.EST)) %>%
  select(timeSeries, SpConductivity)


#Test Plot
ggplot(cleanSpectral, aes(x=timeSeries, y = SpConductivity)) + geom_line() + theme_classic() +
  labs(title = "Spectral Conductivity over time", x = "Date", y = "Spectral conductivity")
