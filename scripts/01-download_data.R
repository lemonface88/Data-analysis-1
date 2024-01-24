#### Preamble ####
# Purpose: Downloads and saves the data from Opendata Toronto
# Author: Harrison Huang
# Date: 2 Janurary 2024 
# Contact: harri.huang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
#install.packages("opendatatoronto")
#install.packages("tidyverse")
#install.packages("dplyr")
library(opendatatoronto)
library(tidyverse)
library(dplyr)

#### Download data ####

#method from frank#
the_raw_data <-
  list_package_resources("https://open.toronto.ca/dataset/theft-from-motor-vehicle/")|>
  filter(name == "theft-from-motor-vehicle - 2952.csv")  |>
  get_resource()
the_raw_data

#Open data toronto method#

package <- show_package("police-annual-statistical-report-tickets-issued")

# get all resources for this package
resources <- list_package_resources("police-annual-statistical-report-tickets-issued")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
raw_ticket_data <- filter(datastore_resources, row_number()==1) %>% get_resource()

##Saving the raw data##

# save the ticket file into input data file
write.csv(raw_ticket_data, file = "inputs/data/raw_ticket_data.csv")
