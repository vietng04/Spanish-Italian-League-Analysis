#### Preamble ####
# Purpose: Cleans the raw National Football Team results data
# Author: Viet Nguyen
# Date: 25 November 2024
# Contact: viethoang.nguyen@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
library(dplyr)
library(readr)
library(tidyverse)
library(janitor)
library(tidyr)
library(arrow)

#### Clean data ####
raw_data <- read_csv("/Users/nguyenviet/Desktop/STA304/national-football-team-stats/data/01-raw_data/results.csv")

raw_data$date <- as.Date(raw_data$date, format = "%Y-%m-%d")

analysis_data <- raw_data %>%
  filter(date >= as.Date("2022-01-01") & date <= as.Date("2024-11-19"), tournament %in% c(
      "FIFA World Cup", 
      "UEFA Nations League",
      "UEFA Euro",
      "Friendly")) %>%
  select(date, home_team, away_team, home_score, away_score, tournament, country)

#### Save data ####
write_csv(analysis_data, "/Users/nguyenviet/Desktop/STA304/national-football-team-stats/data/02-analysis_data/analysis_data.csv")
