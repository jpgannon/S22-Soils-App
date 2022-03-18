##Librarys
library(tidyverse)
library(ggplot2)
library(lubridate)

##Aquatic Data
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

##Create one dataframe for all by date##

###MERGE ALL CLEAN SPECIFIC DATASETS
clean_df_list <- list(clean_temperature_data, clean_spectral_data, clean_nitrate_data,
                      clean_fluorescent_data, clean_discharge_data)


#full join all datasets by date column
allCleanData <- clean_df_list %>% reduce(full_join, by = "date")








##CO2 Cleaning Data
data_raw <- read_csv("hbSoils/data_raw/Hubbard_Brook_CO2_Fluxes.csv")

data <- data_raw[0:28669, ]
## data frame with all soil measurements
master_soil <- data %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>%
  select(timeSeries, VWC1_Chamber, VWC2_Chamber, VWC3_Chamber,
         SiteAirTemp, ChamberTemp, SoilTemp1_Chamber,
         SoilTemp2_Chamber, SoilTemp3_Chamber,
         CO2_Flux_1, CO2_Flux_2, CO2_Flux_3, nee.int) %>% 
  rename(Soil_Moisture_15cm = VWC1_Chamber,
         Soil_Moisture_30cm = VWC2_Chamber,
         Soil_Moisture_5cm = VWC3_Chamber,
         Soil_Temp_15cm = SoilTemp1_Chamber,
         Soil_Temp_30cm = SoilTemp2_Chamber,
         Soil_Temp_5cm = SoilTemp3_Chamber,
         Chamber_Temp = ChamberTemp,
         Air_Temp_150cm = SiteAirTemp,
         CO2_Flux = CO2_Flux_1)




###Merge data


time_drop_soil <- master_soil %>% mutate(date = floor_date(timeSeries, unit = "hour"))


df_list_dropped_time <- list(time_drop_soil, allCleanData)


merged_clean_data <- df_list_dropped_time %>% reduce(full_join, by = "date")

merged_clean_data <- merged_clean_data %>% select(-c(timeSeries))

merged_clean_data <- merged_clean_data %>% rename( Soil_Moisture_at_15cm = Soil_Moisture_15cm,
                                                   Soil_Moisture_at_30cm = Soil_Moisture_30cm,
                                                   Soil_Moisture_at_5cm = Soil_Moisture_5cm,
                                                   Soil_Temp_at_15cm = Soil_Temp_15cm,
                                                   Soil_Temp_at_30cm = Soil_Temp_30cm,
                                                   Soil_Temp_at_5cm = Soil_Temp_5cm,
                                                  Temp_of_Chamber = Chamber_Temp,
                                                  Air_Temp_at_150cm = Air_Temp_150cm,
                                                  CO2_Flux_Interpolated = nee.int,
                                                  Temp_Celcius = TempC,
                                                  Spectral_Conductivity = SpConductivity,
                                                  )


