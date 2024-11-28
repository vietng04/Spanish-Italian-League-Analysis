#### Preamble ####
# Purpose: Simulates a dataset of National Football Team results data
  #state and party that won each division.
# Author: Viet Nguyen
# Date: 25 November 2024
# Contact: viethoang.nguyen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(dplyr)
set.seed(123)

#### Simulate data ####
# National Team Name
n <- 100
teams <- c("Argentina", "France", "Spain", "England", "Brazil", "Belgium", "Portugal", "Netherlands", 
           "Italy", "Germany", "Croatia", "Uruguay", "Japan", "South Korea")
tournaments <- c("FIFA World Cup", "UEFA Euro", "UEFA Nations League", "Friendly")

# Political parties
simulated_data <- tibble(
  date = sample(seq(as.Date("2022-01-01"), as.Date("2024-11-19"), by = "day"), n, replace = TRUE),
  home_team = sample(teams, n, replace = TRUE),
  away_team = sample(teams, n, replace = TRUE),
  home_score = sample(0:5, n, replace = TRUE),
  away_score = sample(0:5, n, replace = TRUE),
  tournament = sample(tournaments, n, replace = TRUE)
)

# Avoid home_team == away_team
simulated_data <- simulated_data %>%
  filter(home_team != away_team)

#### Save data ####
write_csv(simulated_data, "/Users/nguyenviet/Desktop/STA304/national-football-team-stats/data/00-simulated_data/simulated_data.csv")
