library(ggplot2)
library(tidyverse)
library(lubridate)

#Import data

flurDataRaw <- read_csv("hbSoils/data_raw/HBF fDOM.csv")

#Clean Data

cleanFlurData <- flurDataRaw %>% select(Date.Time.EST, FDOM_corrected_QSU)

#Mutate to DateTime
cleanFlurData <- cleanFlurData %>% mutate(timeSeries = mdy_hm(Date.Time.EST)) %>%
  select(timeSeries, FDOM_corrected_QSU)

#Test GGPlot
ggplot(cleanFlurData, aes(timeSeries, FDOM_corrected_QSU)) + geom_line() +
  theme_classic() + labs(title = "Fluorescent Dissolved Organic Matter Over time",
                         x = "Date", y = "Fluorescent dissolved organic matter per Quinine Sulfate Unit (QSU)")


