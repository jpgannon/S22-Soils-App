library(tidyverse)
library(ggplot2)
library(lubridate)


#Load in dataset
nitrateData <- read_csv("hbSoils/data_raw/HBF Nitrate.csv")


#Select necessary columns
cleanData <- nitrateData %>% select(Date.Time.EST, NO3_corrected_mgL)   


#Mutate timeseries data to make it datetime instead of character
cleanData <- cleanData %>% mutate(timeSeries = mdy_hm(Date.Time.EST)) %>%
  select(timeSeries, NO3_corrected_mgL)


#test plot for data
ggplot(cleanData, aes(x = timeSeries, y = NO3_corrected_mgL)) + geom_line()




