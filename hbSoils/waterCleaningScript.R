#Main data Cleaning File
#Able to look at all data without having to load other scripts

#Load necessary Packages
library(lubridate)
library(ggplot2)
library(tidyverse)


###LOADING IN ALL RAW DATA###

#Temperature
temperatureRawData <- read_csv("hbSoils/data_raw/HBF Temperature.csv")

#Spectral Conductivity 
spectralConductivityRaw <- read_csv("hbSoils/data_raw/HBF Spec Cond.csv")

#Nitrate 
nitrateDataRaw <- read_csv("hbSoils/data_raw/HBF Nitrate.csv")

#Fluorescent dissolved Organic Matter
fluorescentDataRaw <- read_csv("hbSoils/data_raw/HBF fDOM.csv")

#Water Discharge
dischargeDataRaw <- read_csv("hbSoils/data_raw/HBF Discharge Storm ID.csv")

#Data Loaded.


###CLEANING EACH SPECIFIC DATASET###

#Cleaning each to select necessary columns, mutating given dates from character
#To posix to make graphing possible.


#Cleaning for temperature Data
clean_temperature_data <- temperatureRawData %>% mutate(date = mdy_hm(Date.Time.EST)) %>%
  select(date, TempC)

#Cleaning for Spectral Conductivity Data
clean_spectral_data <- spectralConductivityRaw %>% mutate(date = mdy_hm(Date.Time.EST)) %>%
  select(date, SpConductivity)

#Cleaning for Nitrate Data
clean_nitrate_data <- nitrateDataRaw %>% mutate(date = mdy_hm(Date.Time.EST)) %>%
  select(date, NO3_corrected_mgL)

#Cleaning for Fluorescent data 

clean_fluorescent_data <- fluorescentDataRaw %>% mutate(date = mdy_hm(Date.Time.EST)) %>%
  select(date, FDOM_corrected_QSU)

#Cleaning for Water Discharge

clean_discharge_data <- dischargeDataRaw %>% mutate(date = mdy_hm(Date.Time.EST)) %>%
  select(date, Q_Ls)





###TESTING ENVIRONMENT FOR GGPLOTS###






