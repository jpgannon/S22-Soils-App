library(dplyr)
library(ggplot)
library(tidyverse)
library(car)
library(TeachingDemos)
library(devtools)

data_raw <- read.csv("data_raw/Hubbard_Brook_CO2_Fluxes.csv")

data <- data_raw[0:28669, ]

co2_flux_all <- data %>% 
  select(TIMESTAMP,CO2_Flux_1, CO2_Flux_2, CO2_Flux_3)
co2_flux_all <- drop_na(co2_flux_all, CO2_Flux_1, CO2_Flux_2, CO2_Flux_3)

co2_flux_1 <- data %>% 
  select(TIMESTAMP,CO2_Flux_1)
co2_flux_1 <- drop_na(co2_flux_1, CO2_Flux_1)

co2_flux_2 <- data %>% 
  select(TIMESTAMP,CO2_Flux_2)
co2_flux_2 <- drop_na(co2_flux_2, CO2_Flux_2)


co2_flux_3 <- data %>% 
  select(TIMESTAMP,CO2_Flux_3)
co2_flux_3 <- drop_na(co2_flux_3, CO2_Flux_3)