#### Preamble ####
# Purpose: Tests the structure and validity of the simulated National Football Team Stats
# Author: Viet Nguyen
# Date: 28 November 2024
# Contact: viethoang.nguyen@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)

simulated_data <- read_csv("/Users/nguyenviet/Desktop/STA304/national-football-team-stats/data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 89 rows
if (nrow(simulated_data) == 89) {
  message("Test Passed: The dataset has 89 rows.")
} else {
  stop("Test Failed: The dataset does not have 89 rows.")
}

# Test: Check that required columns exist
test_that("Dataset contains all required columns", {
  required_columns <- c("date", "home_team", "away_team", "home_score", "away_score", "tournament")
  expect_true(all(required_columns %in% colnames(simulated_data)))
})

# Test: Validate tournament names
test_that("Tournament names are valid", {
  valid_tournaments <- c("FIFA World Cup", "UEFA Euro", "UEFA Nations League", "Friendly")
  expect_true(all(simulated_data$tournament %in% valid_tournaments))
})

# Check countries are in simulated data
valid_countries <- c("Argentina", "France", "Spain", "England", "Brazil", "Belgium", 
                     "Portugal", "Netherlands", "Italy", "Germany", "Croatia", "Uruguay", 
                     "Japan", "South Korea")

# Test home team contains valid countries
if (all(simulated_data$home_team %in% valid_countries)) {
  message("Test Passed: The 'home_team' contains valid_countries")
} else {
  stop("Test Failed: The 'home_team' column contains invalid countries names.")
}

# Test away team contains valid countries
if (all(simulated_data$away_team %in% valid_countries)) {
  message("Test Passed: The 'away_team' contains valid_countries")
} else {
  stop("Test Failed: The 'away_team' column contains invalid countries names.")
}


# Test: Validate column types
test_that("Column types are correct", {
  expect_s3_class(simulated_data$date, "Date")
  expect_type(simulated_data$home_team, "character")
  expect_type(simulated_data$away_team, "character")
  expect_type(simulated_data$home_score, "double")
  expect_type(simulated_data$away_score, "double")
  expect_type(simulated_data$tournament, "character")
})

# Test: Ensure no home_team equals away_team
test_that("Home team is not the same as away team", {
  expect_false(any(simulated_data$home_team == simulated_data$away_team))
})

# Test: Ensure scores are within a reasonable range
test_that("Scores are between 0 and 5", {
  expect_true(all(simulated_data$home_score >= 0 & simulated_data$home_score <= 5))
  expect_true(all(simulated_data$away_score >= 0 & simulated_data$away_score <= 5))
})