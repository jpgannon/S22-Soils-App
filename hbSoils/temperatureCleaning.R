#necessary imports
library(ggplot2)
library(lubridate)
library(tidyverse)


temperatureRaw <- read_csv("hbSoils/data_raw/HBF Temperature.csv")

#Get columns
cleanTemp <- temperatureRaw %>% select(Date.Time.EST, TempC)


#Mutate to Postix
cleanTemp <- cleanTemp %>% mutate(timeSeries = mdy_hm(Date.Time.EST)) %>%
  select(timeSeries, TempC)


#Test Plot

ggplot(cleanTemp, aes(timeSeries, TempC)) + geom_line() + theme_classic()
