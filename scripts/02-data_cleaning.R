#### Preamble ####
# Purpose: clean up the raw data from Opendatatoronto
# Author: Harrison Huang
# Date: 2 January 2024 
# Contact: harri.huang@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(janitor)

#### Clean data ####

raw_ticket_data <- read_csv("inputs/data/raw_ticket_data.csv")

head(raw_ticket_data)

#clean the names of the column and keep the columns such as year, category, age,
# and ticket count, also filtered offence type to speeding only

cleaned_ticket_data <-
  clean_names(raw_ticket_data) |>
  select(offence_year, offence_category, age_group, ticket_count)|>
  filter(offence_category == "Distracted Driving")
  
# this is a cleaned data of all the ticket types
cleaned_all_ticket_data <-
  clean_names(raw_ticket_data) |>
  select(offence_year, offence_category, age_group, ticket_count)
  


# this filters out the youth from the data
cleaned_adult_data <-
  cleaned_ticket_data |>
  filter(age_group == "Adult")

# this filters out the adult from the data
cleaned_youth_data <-
  cleaned_ticket_data |>
  filter(age_group == "Youth")

# this is the summary data of total violations by year

sum_total_data <-
  cleaned_ticket_data |>
  arrange(offence_year) |>
  summarise(total_violations = sum(ticket_count),
            .by = offence_year) 

            
cleaned_all_ticket_data <- 
  cleaned_ticket_data |>
  arrange(offence_year) |>
  summarise(total_violations = sum(ticket_count),
            .by = offence_year) 
  
## Save clean data to output data##

#save cleaned ticket data#
write_csv(cleaned_ticket_data, "outputs/data/cleaned_ticket_data.csv")

#save cleaned adult data#
write_csv(cleaned_adult_data, "outputs/data/cleaned_adult_data.csv")

#save cleaned youth data#
write_csv(cleaned_youth_data, "outputs/data/cleaned_youth_data.csv")

#save summary data of youth and adult#
write_csv(sum_total_data, "outputs/data/sum_total_data.csv")

# save all ticket data of youth and adult#
write_csv(cleaned_all_ticket_data, "outputs/data/cleaned_all_ticket_data.csv")

