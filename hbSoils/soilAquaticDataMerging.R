##Librarys and loading necessary packages
library(tidyverse)
library(ggplot2)
library(lubridate)

#Read in aquatic data
aquatic_updated_raw <- read.csv("data_raw/UpdatedWater.csv")

#Grab specific columns we need
aquatic_updated <- aquatic_updated_raw %>% select(Date, TempC, SpConductivity,
                                                  NO3_corrected, FDOM_corrected_QSU, Q)

#Character to date format
aquatic_updated$Date <- as.POSIXct(aquatic_updated$Date, format = "%m/%d/%Y %H:%M")


#Averaged Hourly Data for updated aquatic (new Aquatic data)
updated_hourly_water <- aquatic_updated %>% group_by(year = year(Date), month = month(Date),
                                                     day = day(Date), hour = hour(Date)) %>%
  summarise(across(c(TempC, SpConductivity, NO3_corrected, FDOM_corrected_QSU, Q), mean)) %>%
  ungroup() %>% mutate(date = mdy_h(paste(month, day, year, hour))) %>% select(-c(month,day,year,hour)) %>%
  select(date, TempC, SpConductivity, NO3_corrected, FDOM_corrected_QSU, Q)



##CO2 Cleaning Data
data_raw <- read_csv("data_raw/Hubbard_Brook_CO2_Fluxes.csv")

#Select all necessary rows
data <- data_raw[0:28669, ]
## data frame with all soil measurements, mutate new date column and select necessary columns and then rename.
master_soil <- data %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>%
  select(timeSeries, VWC1_Chamber, VWC2_Chamber, VWC3_Chamber,
         SiteAirTemp, ChamberTemp, SoilTemp1_Chamber,
         SoilTemp2_Chamber, SoilTemp3_Chamber, nee.int) %>% 
  rename(Soil_Moisture_15cm = VWC1_Chamber,
         Soil_Moisture_30cm = VWC2_Chamber,
         Soil_Moisture_5cm = VWC3_Chamber,
         Soil_Temp_15cm = SoilTemp1_Chamber,
         Soil_Temp_30cm = SoilTemp2_Chamber,
         Soil_Temp_5cm = SoilTemp3_Chamber,
         Chamber_Temp = ChamberTemp,
         Air_Temp_150cm = SiteAirTemp,
         CO2_Flux = nee.int)








###Merge data


#Floor the soil data to nearest hour (was only 2 minutes from it)
time_drop_soil <- master_soil %>% mutate(date = floor_date(timeSeries, unit = "hour"))


#Full join all data from soil and aquatic datasets by same date
merged_clean_data <- full_join(time_drop_soil, updated_hourly_water, by = "date")

#Get rid of timeseries column
merged_clean_data <- merged_clean_data %>% select(-c(timeSeries))

#Rename all columns in the new merged dataset
merged_clean_data <- merged_clean_data %>% rename( Soil_Moisture_at_15cm = Soil_Moisture_15cm,
                                                   Soil_Moisture_at_30cm = Soil_Moisture_30cm,
                                                   Soil_Moisture_at_5cm = Soil_Moisture_5cm,
                                                   Soil_Temp_at_15cm = Soil_Temp_15cm,
                                                   Soil_Temp_at_30cm = Soil_Temp_30cm,
                                                   Soil_Temp_at_5cm = Soil_Temp_5cm,
                                                  Temp_of_Chamber = Chamber_Temp,
                                                  Air_Temp_at_150cm = Air_Temp_150cm,
                                                  Stream_Temp_Celcius = TempC,
                                                  Stream_Specific_Conductance = SpConductivity,
                                                  Stream_NO3_mgL = NO3_corrected,
                                                  Stream_FDOM_QSU = FDOM_corrected_QSU,
                                                  Stream_Discharge_L = Q,
                                                  )








