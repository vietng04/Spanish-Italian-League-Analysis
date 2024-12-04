#### Preamble ####
# Purpose: Simulates a dataset of Spain and Italy League data
  #state and party that won each division.
# Author: Viet Nguyen
# Date: 25 November 2024
# Contact: viethoang.nguyen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `home_field_analysis` rproj

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(here)
library(arrow)
set.seed(123)

#### Simulate data ####
n <- 100
teams <- c("FC Barcelona", "Real Madrid", "Atletico Madrid", "Villarreal CF", "Athletic Bilbao", "CA Osasuna", 
           "Sevilla FC", "Real Sociedad", "	Valencia CF", "Real Betis", "Cadiz CF", "Granada CF")

teams_italy <- c("SSC Napoli", "Atalanta", "Inter", "ACF Fiorentina", "Lazio Roma", "Juventus", "AC Milan",
                 "Bologna FC", "Udinese Calcio", "Empoli FC", "AS Roma", "Genoa CFC")

# Political parties
simulated_data_spain <- tibble(
  date = sample(seq(as.Date("2020-09-12"), as.Date("2022-05-22"), by = "day"), n, replace = TRUE),
  home = sample(teams, n, replace = TRUE),
  visitor = sample(teams, n, replace = TRUE),
  hgoal = sample(0:5, n, replace = TRUE),
  vgoal = sample(0:5, n, replace = TRUE),
  FT = sample(0:5, n, replace = TRUE))

simulated_data_italy <- tibble(
  date = sample(seq(as.Date("2020-09-12"), as.Date("2022-05-22"), by = "day"), n, replace = TRUE),
  home = sample(teams_italy, n, replace = TRUE),
  visitor = sample(teams_italy, n, replace = TRUE),
  hgoal = sample(0:5, n, replace = TRUE),
  vgoal = sample(0:5, n, replace = TRUE),
  FT = sample(0:5, n, replace = TRUE))

# Avoid home_team == away_team
simulated_data_spain <- simulated_data_spain %>%
  filter(home != visitor)

simulated_data_italy <- simulated_data_italy %>%
  filter(home != visitor)

#### Save data ####
write_csv(simulated_data_spain, "data/00-simulated_data/simulated_data_spain.csv")
write_parquet(simulated_data_spain, "data/00-simulated_data/simulated_data_spain.parquet")
write_csv(simulated_data_italy, "data/00-simulated_data/simulated_data_italy.csv")
write_parquet(simulated_data_italy, "data/00-simulated_data/simulated_data_italy.parquet")

