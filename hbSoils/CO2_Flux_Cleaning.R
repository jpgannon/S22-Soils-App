library(dplyr)
library(ggplot2)
library(tidyverse)
library(car)
library(TeachingDemos)
library(devtools)

data_raw <- read.csv("data_raw/Hubbard_Brook_CO2_Fluxes.csv")

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

#All moisture Data
moisture_all <- data %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>%
  select(timeSeries, VWC1_Chamber, VWC2_Chamber, VWC3_Chamber)

ggplot(moisture_all, aes(x = timeSeries)) +
  geom_line(aes(y = VWC1_Chamber), color = "black") +
  geom_line(aes(y = VWC2_Chamber), color = "blue") +
 
  geom_line(aes(y = VWC3_Chamber), color = "red") +
  xlab("Date") +
  ggtitle("All Moisture over time") + 
  ylab("Soil Moisture (mm 3 H2O / mm 3 soil)") +
  theme_classic()



#All Temp Data
temp_all <- data %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>%
  select(timeSeries, SiteAirTemp, ChamberTemp, SoilTemp1_Chamber, SoilTemp2_Chamber, SoilTemp3_Chamber) 
  
ggplot(temp_all, aes(x = timeSeries)) +
  geom_line(aes(y = SiteAirTemp), color = "black") +
  geom_line(aes(y = ChamberTemp), color = "orange") +
  geom_line(aes(y = SoilTemp1_Chamber), color = "blue") +
  geom_line(aes(y = SoilTemp2_Chamber), color = "red") +
  geom_line(aes(y = SoilTemp3_Chamber), color = "brown") +
  xlab("Date") +
  ggtitle("All Measured Temp over time") + 
  ylab("Site Temp (C)") +
  theme_classic()

# All Calculated CO2 Flux;
co2_flux_all <- data %>% 
  select(TIMESTAMP,CO2_Flux_1, CO2_Flux_2, CO2_Flux_3, nee.int) %>%
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>% 
  select(timeSeries, CO2_Flux_1, CO2_Flux_2, CO2_Flux_3, nee.int)

# Graph all the availible data
ggplot(co2_flux_all, aes(x = timeSeries)) +
  geom_line(aes(y = CO2_Flux_1), color = "black") +
  geom_line(aes(y = CO2_Flux_2), color = "blue") +
  geom_line(aes(y = CO2_Flux_3), color = "red") +
  geom_line(aes(y = nee.int), color = "green") +
  xlab("Date") +
  ggtitle("All Measured CO2 Flux over time") + 
  ylab("CO2 Flux (micromoles CO2 / meter squared / second)") +
  theme_classic()
  
# "M" = missing, "LF" = flux < 0, "LR" = r2 of regression < 0.8; 
# "LF,LR" = flux < 0 & r2 of regression < 0.8; "A" = accepted
co2_flux_1 <- data %>% 
  select(TIMESTAMP,CO2_Flux_1) %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>% 
  select(timeSeries, CO2_Flux_1)

# Graph flux_1 data
ggplot(co2_flux_1, aes(x = timeSeries)) +
  geom_line(aes(y = CO2_Flux_1), color = "black") +
  xlab("Date") +
  ggtitle("All Calculated CO2 Flux over time") + 
  ylab("CO2 Flux (micromoles CO2 / meter squared / second)") +
  theme_classic()

# Second Flag of CO2 Flux; "M" = missing; "AR" = outside of the range of fluxes
# measured within four hours of this flux;
# "P" = provisional because the range of fluxes
# within four hour period could not be establisehd due to missing values; "A" = accepted
co2_flux_2 <- data %>% 
  select(TIMESTAMP,CO2_Flux_2) %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>% 
  select(timeSeries, CO2_Flux_2)

# Graph flux_2 data
ggplot(co2_flux_2, aes(x = timeSeries)) +
  geom_line(aes(y = CO2_Flux_2), color = "black") +
  xlab("Date") +
  ggtitle("CO2 Flux over time (Passes First QA)") + 
  ylab("CO2 Flux (micromoles CO2 / meter squared / second)") +
  theme_classic()

# Third Flag of CO2 Flux; same as Second 
# Flag of CO2 Flux but repeated for data processing purposes
co2_flux_3 <- data %>% 
  select(TIMESTAMP,CO2_Flux_3) %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>% 
  select(timeSeries, CO2_Flux_3)
# Graph flux_3 data
ggplot(co2_flux_3, aes(x = timeSeries)) +
  geom_line(aes(y = CO2_Flux_3), color = "black") +
  xlab("Date") +
  ggtitle("CO2 Flux over time (Passes Second QA)") + 
  ylab("CO2 Flux (micromoles CO2 / meter squared / second)") +
  theme_classic()
# CO2 Flux (micromoles CO2 / meter squared / second) of either original
# measured data or data interpolated between points sampled with 24 h of one another
co2_flux_int <- data %>% 
  select(TIMESTAMP,nee.int) %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>% 
  select(timeSeries, nee.int)

# Graph interpolated data
ggplot(co2_flux_int, aes(x = timeSeries)) +
  geom_line(aes(y = nee.int), color = "black") +
  xlab("Date") +
  ggtitle("Interpolated CO2 Flux over time") + 
  ylab("CO2 Flux (micromoles CO2 / meter squared / second)") +
  theme_classic()

ggplot(merged_clean_data, aes(x = Soil_Moisture_at_30cm, y = Soil_Temp_at_30cm)) + 
  geom_line()

ggplot(merged_clean_data, aes(x = Soil_Moisture_at_30cm, Soil_Temp_at_30cm)) +
  theme_classic() + geom_line() +
  theme(text = element_text(size = 16))

