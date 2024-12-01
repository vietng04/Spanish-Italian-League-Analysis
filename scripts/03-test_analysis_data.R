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
library(here)

# Load data
analysis_data <- read_csv("../data/02-analysis_data/analysis_data_spain.csv")

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Test the number of rows
if (nrow(analysis_data) == 1140) {
  message("Test Passed: The dataset has 1140 rows.")
} else {
  stop("Test Failed: The dataset does not have 1140 rows.")
}

test_that("Data contains at least one record", {
  expect_gt(nrow(analysis_data), 0)
})

# Test: Validate column names
test_that("Dataset contains all required columns", {
  required_columns <- c("date", "home", "visitor", "hgoal", "vgoal", "FT", "Season")
  expect_true(all(required_columns %in% colnames(analysis_data)))
})

# Test: Check for missing values
test_that("No missing values in essential columns", {
  essential_columns <- c("date", "home", "visitor", "hgoal", "vgoal", "FT", "Season")
  expect_true(all(colSums(is.na(analysis_data[essential_columns])) == 0))
})

# Test: Validate date range
test_that("Dates are within the specified range", {
  expect_true(all(analysis_data$date >= as.Date("2019-08-16") & analysis_data$date <= as.Date("2022-05-22")))
})

# Test: Ensure home_team is not the same as away_team
test_that("Home team is not the same as away team", {
  expect_false(any(analysis_data$home == analysis_data$visitor))
})

# Test: Ensure scores are within a reasonable range
test_that("Scores are between 0 and 10", {
  expect_true(all(analysis_data$hgoal >= 0 & analysis_data$hgoal <= 10))
  expect_true(all(analysis_data$hgoal >= 0 & analysis_data$vgoal <= 10))
})

# Test: Validate Season
test_that("Seasons are valid", {
  valid_years <- c(2019, 2020, 2021)
  valid_dates <- analysis_data$Season %in% valid_years
  expect_true(all(valid_dates))
})
