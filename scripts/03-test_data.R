#### Preamble ####
# Purpose: Tests cleaned data sets 
# Author: Harrison Huang
# Date: 25 January 2024
# Contact: harri.huang@mail.utoronto.ca
# License: MIT
# Pre-requisites: run 01-download_data.R and 02-data_cleaning.R
# Any other information needed? If nothing is printed, all tests have passed

library(usethis)
library(gitcreds)

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(janitor)

#### Load Cleaned Data Sets ####

# read cleaned youth data
test_youth_data = read_csv(
  file = "outputs/data/cleaned_youth_data.csv",
  show_col_types = FALSE
)

# read cleaned adult data
test_adult_data = read_csv(
  file = "outputs/data/cleaned_adult_data.csv",
  show_col_types = FALSE
)

# read cleaned combined youth and adult data
test_overall_data = read_csv(
  file = "outputs/data/sum_total_data.csv",
  show_col_types = FALSE
)

# Ref from https://github.com/ThomasWilliamFox/toronto_child_care/blob/master/scripts/00-simulate_data.R

### Test the data above ###

## testing youth data ##
if (min(test_youth_data$ticket_count) < 0) {
  print("Negative number in ticket count")
}

if (class(test_youth_data$age_group) != "character") {
  print("Age group has non-char value")
}

if (max(test_youth_data$offence_year) < 2024) {
  print("Incorrect offence year, future")
}

## testing adult data ##
if (min(test_adult_data$ticket_count) < 0) {
  print("Negative number in ticket count")
}

if (class(test_adult_data$age_group) != "character") {
  print("Age group has non-char value")
}

if (max(test_adult_data$offence_year) < 2024) {
  print("Incorrect offence year, future")
}

## testing overall data ##

if (min(test_overall_data$ticket_count) < 0) {
  print("Negative number in ticket count")
}

if (class(test_overall_data$age_group) != "character") {
  print("Age group has non-char value")
}

if (max(test_overall_data$offence_year) < 2024) {
  print("Incorrect offence year, future")
}