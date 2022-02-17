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

##Create one dataframe for all by date

clean_df_list <- list(clean_temperature_data, clean_spectral_data, clean_nitrate_data,
                      clean_fluorescent_data, clean_discharge_data)


allCleanData <- clean_df_list %>% reduce(full_join, by = "date")




###TESTING ENVIRONMENT FOR GGPLOTS###

#Start/End Dates for graphs
startDate <- "2012-11-1"
endDate <- "2014-11-1"

#GGPlot for discharge (TimeSeries)

dischargeTimePlot <- ggplot(clean_discharge_data, aes(as.Date(date), Q_Ls)) +
  theme_classic() + geom_line() + scale_x_date(limits = as.Date(c(startDate, endDate))) +
  labs(title ="Water discharge over Time", x = "Time", y = "Discharge") + geom_smooth()

#GGplot for fluorescence (TimeSeries)

fluorescenseTimePlot <- ggplot(clean_fluorescent_data, aes(as.Date(date), FDOM_corrected_QSU)) +
  theme_classic() + geom_line() + scale_x_date(limits = as.Date(c(startDate, endDate))) +
  labs(title = "Fluorescence data over Time", x = "Time", y = "Fluorescense data") +
  geom_smooth()

#GGPlot for nitrate (TimeSeries)

nitrateTimePlot <- ggplot(clean_nitrate_data, aes(as.Date(date), NO3_corrected_mgL)) +
  theme_classic() + geom_line() + scale_x_date(limits = as.Date(c(startDate, endDate))) +
  labs(title = "Nitrate data over Time", x = "Time", y = "Nitrate") + geom_smooth()

#GGPlot for specific conductivity (TimeSeries)

conductivityTimePlot <- ggplot(clean_spectral_data, aes(as.Date(date), SpConductivity)) +
  theme_classic() + geom_line() + scale_x_date(limits = as.Date(c(startDate, endDate))) +
  labs(title = "Specific Conductivity over Time", x = "Time", y = "Specific Conductivity") +
  geom_smooth()

#GGPlot for temperature (TimeSeries)

temperatureTimePlot <- ggplot(clean_temperature_data, aes(as.Date(date), TempC)) +
  theme_bw() + geom_line() + scale_x_date(limits = as.Date(c(startDate, endDate))) + 
  labs(title = "Temperature over Time", x = "Time", y = "Temperature") + geom_smooth()


###END TIME PLOTS###


###Bi-Variate Plots












