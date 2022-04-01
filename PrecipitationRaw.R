
library(readr)
library(dplyr)
library(plyr)

precipitationRaw <- list.files(path = "~/S22-Soils-App/hbSoils/data_raw/knb-lter-hbr.277.4", 
                               pattern = "*.csv", full.names = T) %>%
  lapply(read.csv) %>%
  bind_rows