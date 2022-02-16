#necessary imports
library(ggplot2)
library(lubridate)
library(tidyverse)
library(scales)


temperatureRaw <- read_csv("hbSoils/data_raw/HBF Temperature.csv")

#Get columns
cleanTemp <- temperatureRaw %>% select(Date.Time.EST, TempC)


#Mutate to Post
cleanTemp <- cleanTemp %>% mutate(timeSeries = mdy_hm(Date.Time.EST)) %>%
  select(timeSeries, TempC)


#Test Plot
#Testing environment for ggplot









ggplot(cleanTemp, aes(as.Date(timeSeries), TempC)) + geom_line() + theme_classic() +
  scale_x_date(limits = as.Date(c("2012-10-11", "2012-11-1")))
