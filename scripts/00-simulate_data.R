#### Preamble ####
# Purpose: Simulates data summary of each year's distracted driving violation
# Author: Harrison Huang
# Date: 23 January 2024
# Contact: harri.huang@mail.utoronto.ca
# License: MIT
# Pre-requisites: n/a
# Any other information needed? n/a

#### Workspace setup ####
library(tidyverse)

#### Build simulated data ####
set.seed(888)
install.packages("gitcreds")
library(gitcreds)

# Ref from https://github.com/ThomasWilliamFox/toronto_child_care/blob/master/scripts/00-simulate_data.R
# Ref from https://github.com/InessaDeAngelis/Toronto_Elections/blob/main/scripts/00-simulate_data.R

# Simulate ticket given data
# year from 2014-2022
# ticket counts 1 to 50
# age group - youth or adult

simulated_ticket_data <-
  tibble(
    # randomyl select a year to assign to the ticket_count
    offence_year = sample(
      x = c(2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022),
      size = 1000,
      replace = TRUE
    ), 
    
    # randomly assigning each data to either adult or youth
    age_group =  sample(
      x = c("Adult", "Youth"),
      size = 1000,
      replace = TRUE),
    
    # ticket count are randomly generated between 1 to 60 for each data input
    ticket_count = sample(
      x = c(1:60),
      size = 1000,
      replace = TRUE)
  )

# cleaned the simulated data for only youth data by per year 
simulated_youth_data <-
  simulated_ticket_data|>
  filter(age_group =="Youth")|>
  arrange(offence_year) |>
  summarise(total_violations = sum(ticket_count),
            .by = offence_year) 

# cleaned the simulated data for only adult data by per year 
simulated_adult_data <-
  simulated_ticket_data|>
  filter(age_group =="Adult")|>
  arrange(offence_year) |>
  summarise(total_violations = sum(ticket_count),
            .by = offence_year) 

# cleaned the simulated data for both adult and youth data by per year 
simulated_overall_data <-
  simulated_ticket_data|>
  arrange(offence_year) |>
  summarise(total_violations = sum(ticket_count),
            .by = offence_year) 



# bar graph of simulated youth data
simulated_youth_data |> 
  ggplot(mapping = aes(x = offence_year, y = total_violations))+ 
  geom_bar(stat= 'identity') +
  scale_x_continuous(breaks =c(2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023))+ 
  labs(title = "Youth Distracted Driving violations Per year", x = "Year", y = "total ticket")


# bar graph of simulated adult data
simulated_adult_data |> 
  ggplot(mapping = aes(x = offence_year, y = total_violations))+ 
  geom_bar(stat= 'identity') +
  scale_x_continuous(breaks =c(2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023))+ 
  labs(title = "Adult Distracted Driving violations Per year", x = "Year", y = "total ticket")

# bar graph of overall data
simulated_overall_data |> 
  ggplot(mapping = aes(x = offence_year, y = total_violations))+ 
  geom_bar(stat= 'identity') +
  scale_x_continuous(breaks =c(2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023))+ 
  labs(title = "Both Groups Distracted Driving violations Per year", x = "Year", y = "total ticket")







