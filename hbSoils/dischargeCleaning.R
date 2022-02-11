library(ggplot2)
library(lubridate)
library(tidyverse)


#import data
dischargeDataRaw <- read_csv("hbSoils/data_raw/HBF Discharge Storm ID.csv")

#clean and select columns we want
cleanDischargeData <- dischargeDataRaw %>% mutate(timeSeries = mdy_hm(Date.Time.EST)) %>%
  select(timeSeries, Q_Ls, StormID)




ggplot(cleanDischargeData, aes(timeSeries, Q_Ls), color = stormID) + geom_line() +
  theme_classic() + labs(x = "Date", y = "discharge per liters", title = "Discharge Per Liters over time")
