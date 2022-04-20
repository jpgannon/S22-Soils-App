library(tidyverse)
library(lubridate)

aquatic_updated_raw <- read.csv("hbSoils/data_raw/UpdatedWater.csv")

#Grab specific columns we need
aquatic_updated <- aquatic_updated_raw %>% select(Date, TempC, SpConductivity,
                                                  NO3_corrected, FDOM_corrected_QSU, Q)

#Character to date
aquatic_updated$Date <- as.POSIXct(aquatic_updated$Date, format = "%m/%d/%Y %H:%M")

#subtract two minutes to get clean averages
#aquatic_updated$Date <- aquatic_updated$Date - 120 


#Averaged Hourly Data for updated aquatic (new Aquatic data)
updated_hourly_water <- aquatic_updated %>% group_by(year = year(Date), month = month(Date),
                                               day = day(Date), hour = hour(Date)) %>%
  summarise(across(c(TempC, SpConductivity, NO3_corrected, FDOM_corrected_QSU, Q), mean)) %>%
  ungroup() %>% mutate(date = mdy_h(paste(month, day, year, hour))) %>% select(-c(month,day,year,hour)) %>%
  select(date, TempC, SpConductivity, NO3_corrected, FDOM_corrected_QSU, Q)



