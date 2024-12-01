#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Spain league dataset
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

simulated_data <- read_csv("/Users/nguyenviet/Desktop/STA304/spain_league/data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####
# Check if the dataset has 93 rows
if (nrow(simulated_data) == 93) {
  message("Test Passed: The dataset has 93 rows.")
} else {
  stop("Test Failed: The dataset does not have 93 rows.")
}

# Test: Check that required columns exist
required_columns <- c("date", "home", "visitor", "hgoal", "vgoal", "FT")
if (all(required_columns %in% colnames(simulated_data))) {
  message("Test Passed: Dataset contains all required columns.")
} else {
  stop("Test Failed: Dataset does not contain all required columns.")
}

# Check clubs are in simulated data
valid_clubs <- c("FC Barcelona", "Real Madrid", "Atletico Madrid", "Villarreal CF", "Athletic Bilbao", "CA Osasuna", 
                 "Sevilla FC", "Real Sociedad", "Valencia CF", "Real Betis", "Cadiz CF", "Granada CF")

# Test home team contains valid clubs
if (all(simulated_data$home %in% valid_clubs)) {
  message("Test Passed: The 'home_team' contains valid clubs.")
} else {
  stop("Test Failed: The 'home_team' column contains invalid club names.")
}

# Test away team contains valid countries
if (all(simulated_data$visitor %in% valid_clubs)) {
  message("Test Passed: The 'away_team' contains valid clubs.")
} else {
  stop("Test Failed: The 'away_team' column contains invalid club names.")
}

# Test: Validate column types
if (inherits(simulated_data$date, "Date")) {
  message("Test Passed: 'date' column has correct class (Date).")
} else {
  stop("Test Failed: 'date' column has incorrect class.")
}

if (is.character(simulated_data$home)) {
  message("Test Passed: 'home' column has correct type (character).")
} else {
  stop("Test Failed: 'home' column has incorrect type.")
}

if (is.character(simulated_data$visitor)) {
  message("Test Passed: 'visitor' column has correct type (character).")
} else {
  stop("Test Failed: 'visitor' column has incorrect type.")
}

if (is.double(simulated_data$hgoal)) {
  message("Test Passed: 'hgoal' column has correct type (double).")
} else {
  stop("Test Failed: 'hgoal' column has incorrect type.")
}

if (is.double(simulated_data$vgoal)) {
  message("Test Passed: 'vgoal' column has correct type (double).")
} else {
  stop("Test Failed: 'vgoal' column has incorrect type.")
}

if (is.double(simulated_data$FT)) {
  message("Test Passed: 'FT' column has correct type (double).")
} else {
  stop("Test Failed: 'FT' column has incorrect type.")
}

# Test: Ensure no home_team equals away_team
if (any(simulated_data$home == simulated_data$visitor)) {
  stop("Test Failed: Home team and away team cannot be the same.")
} else {
  message("Test Passed: Home team is not the same as away team.")
}

# Test: Ensure scores are within a reasonable range
if (all(simulated_data$hgoal >= 0 & simulated_data$hgoal <= 5)) {
  message("Test Passed: Home scores are between 0 and 5.")
} else {
  stop("Test Failed: Home scores are out of range.")
}

if (all(simulated_data$vgoal >= 0 & simulated_data$vgoal <= 5)) {
  message("Test Passed: Visitor scores are between 0 and 5.")
} else {
  stop("Test Failed: Visitor scores are out of range.")
}
