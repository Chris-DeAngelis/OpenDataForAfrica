#library(readr)
library(Knoema)
library(tidyverse)


#data <- Knoema('rcghoib', list('frequency' = 'A', 'Variable' = 'KN.B2'), host='dataportal.opendataforafrica.org', type = "DataFrame")

# Pull in Global Agriculture Data
agriculture_raw <- Knoema('cmgyxr', list('frequency' = 'A', 'Element' = '152'), host='dataportal.opendataforafrica.org', type = "DataFrame")
agriculture <- rownames_to_column(agriculture_raw)
agriculture <- agriculture %>% 
                gather(Country, Value, -rowname)

# Split apart country and item data
ag_clean <- agriculture$Country %>%
          str_split(" ")
agriculture$country <- lapply(ag_clean, `[[`, 1)
agriculture$item <- lapply(ag_clean, `[[`, 3)
agriculture <- agriculture[,-2]
colnames(agriculture) <- c("date", "value", "country", "item")

# Pull in Economics Data for Africa
economics_raw <- Knoema('tovgvsb', list('frequency' = 'A'), host='dataportal.opendataforafrica.org', type = "DataFrame")
economics <- rownames_to_column(economics_raw)
economics <- economics %>%
              gather(Country, Value, -rowname)
econ_clean <- economics$Country %>%
                str_split(" ")
economics$country <- lapply(econ_clean, `[[`, 1)
economics$measure <- lapply(econ_clean, `[[`, 3)
economics <- economics[,-2]
colnames(agriculture) <- c("date", "value", "country", "measure")

# World development indicators
#wdi <- Knoema('ehrvlag', list('timerange' = '2005-2014', 'frequency' = 'A'), host='dataportal.opendataforafrica.org', type = "DataFrame")

# BP Energy Outlook
energy <- Knoema('gfpqgae', list('timerange' = '1990-2040', 'frequency' = 'A'), host='dataportal.opendataforafrica.org', type = "DataFrame")

# Economic Freedom
economic_freedom <- Knoema('qunzcue', list('timerange' = '2017-2019', 'frequency' = 'A', 'Country' = 'VU', 'Indicator' = 'KN.FH'), host='dataportal.opendataforafrica.org', type = "DataFrame")


