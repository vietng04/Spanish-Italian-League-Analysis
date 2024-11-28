#### Test Analysis Data ####
# Purpose: Validates the structure, integrity, and quality of the cleaned analysis dataset.
# Author: Viet Nguyen
# Date: 25 November 2024
# Contact: viethoang.nguyen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse`, `testthat`, and `janitor` packages must be installed.

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(dplyr)
library(readr)
library(janitor)

# Load data
analysis_data <- read_csv("/Users/nguyenviet/Desktop/STA304/national-football-team-stats/data/02-analysis_data/analysis_data.csv")

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Test the number of rows
if (nrow(analysis_data) == 1278) {
  message("Test Passed: The dataset has 1278 rows.")
} else {
  stop("Test Failed: The dataset does not have 1278 rows.")
}

test_that("Data contains at least one record", {
  expect_gt(nrow(analysis_data), 0)
})

# Test: Validate column names
test_that("Dataset contains all required columns", {
  required_columns <- c("date", "home_team", "away_team", "home_score", "away_score", "tournament", "country")
  expect_true(all(required_columns %in% colnames(analysis_data)))
})

# Test: Check for missing values
test_that("No missing values in essential columns", {
  essential_columns <- c("date", "home_team", "away_team", "home_score", "away_score", "tournament")
  expect_true(all(colSums(is.na(analysis_data[essential_columns])) == 0))
})

# Test: Validate date range
test_that("Dates are within the specified range", {
  expect_true(all(analysis_data$date >= as.Date("2022-01-01") & analysis_data$date <= as.Date("2024-11-19")))
})

# Test: Ensure home_team is not the same as away_team
test_that("Home team is not the same as away team", {
  expect_false(any(analysis_data$home_team == analysis_data$away_team))
})

# Test: Ensure scores are within a reasonable range
test_that("Scores are between 0 and 10", {
  expect_true(all(analysis_data$home_score >= 0 & analysis_data$home_score <= 10))
  expect_true(all(analysis_data$away_score >= 0 & analysis_data$away_score <= 10))
})

# Test: Validate tournament names
test_that("Tournament names are valid", {
  valid_tournaments <- c("FIFA World Cup", "UEFA Nations League", "UEFA Euro", "Friendly")
  expect_true(all(analysis_data$tournament %in% valid_tournaments))
})
