library(dplyr)
library(ggplot)
library(tidyverse)
library(car)
library(TeachingDemos)
library(devtools)

data_raw <- read.csv("data_raw/Hubbard_Brook_CO2_Fluxes.csv")

data <- data_raw[0:28669, ]

co2_flux_all <- data %>% 
  select(TIMESTAMP,CO2_Flux_1, CO2_Flux_2, CO2_Flux_3, nee.int) %>%
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>% 
  select(timeSeries, CO2_Flux_1, CO2_Flux_2, CO2_Flux_3, nee.int)

ggplot(co2_flux_all, aes(x = timeSeries)) +
  geom_line(aes(y = CO2_Flux_1), color = "black") +
  geom_line(aes(y = CO2_Flux_2), color = "blue") +
  geom_line(aes(y = CO2_Flux_3), color = "red") +
  geom_line(aes(y = nee.int), color = "green") +
  xlab("Date") +
  ggtitle("All Measured CO2 Flux over time") + 
  ylab("CO2 Flux (micromoles CO2 / meter squared / second)") +
  theme_classic()
  
co2_flux_1 <- data %>% 
  select(TIMESTAMP,CO2_Flux_1) %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>% 
  select(timeSeries, CO2_Flux_1)

ggplot(co2_flux_1, aes(x = timeSeries)) +
  geom_line(aes(y = CO2_Flux_1), color = "black") +
  xlab("Date") +
  ggtitle("All Calculated CO2 Flux over time") + 
  ylab("CO2 Flux (micromoles CO2 / meter squared / second)") +
  theme_classic()

co2_flux_2 <- data %>% 
  select(TIMESTAMP,CO2_Flux_2) %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>% 
  select(timeSeries, CO2_Flux_2)

ggplot(co2_flux_2, aes(x = timeSeries)) +
  geom_line(aes(y = CO2_Flux_2), color = "black") +
  xlab("Date") +
  ggtitle("CO2 Flux over time (Passes First QA)") + 
  ylab("CO2 Flux (micromoles CO2 / meter squared / second)") +
  theme_classic()

co2_flux_3 <- data %>% 
  select(TIMESTAMP,CO2_Flux_3) %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>% 
  select(timeSeries, CO2_Flux_3)

ggplot(co2_flux_3, aes(x = timeSeries)) +
  geom_line(aes(y = CO2_Flux_3), color = "black") +
  xlab("Date") +
  ggtitle("CO2 Flux over time (Passes Second QA)") + 
  ylab("CO2 Flux (micromoles CO2 / meter squared / second)") +
  theme_classic()

co2_flux_int <- data %>% 
  select(TIMESTAMP,nee.int) %>% 
  mutate(timeSeries = ymd_hms(TIMESTAMP)) %>% 
  select(timeSeries, nee.int)

ggplot(co2_flux_int, aes(x = timeSeries)) +
  geom_line(aes(y = nee.int), color = "black") +
  xlab("Date") +
  ggtitle("Interpolated CO2 Flux over time") + 
  ylab("CO2 Flux (micromoles CO2 / meter squared / second)") +
  theme_classic()



