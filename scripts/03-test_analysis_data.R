#### Test Analysis Data ####
# Purpose: Validates the structure, integrity, and quality of the cleaned analysis dataset.
# Author: Viet Nguyen
# Date: 25 November 2024
# Contact: viethoang.nguyen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse`, `testthat`, and `janitor` packages must be installed.

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(readr)
library(janitor)
library(here)

# Load data
analysis_data <- read_csv("data/02-analysis_data/analysis_data_spain.csv")
analysis_data1 <- read_csv("data/02-analysis_data/analysis_data_italy.csv")

#### Test Data ####

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

if (exists("analysis_data1")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

# Test the number of rows for analysis_data
if (nrow(analysis_data) == 1140) {
  message("Test Passed: The dataset has 1140 rows.")
} else {
  stop("Test Failed: The dataset does not have 1140 rows.")
}

# Test if there are at least one record in analysis_data
if (nrow(analysis_data) > 0) {
  message("Test Passed: Data contains at least one record.")
} else {
  stop("Test Failed: Data does not contain any records.")
}

# Test if analysis_data contains all required columns
required_columns <- c("date", "home", "visitor", "hgoal", "vgoal", "FT", "Season")
if (all(required_columns %in% colnames(analysis_data))) {
  message("Test Passed: Dataset contains all required columns.")
} else {
  stop("Test Failed: Dataset is missing required columns.")
}

# Test if there are no missing values in essential columns
essential_columns <- c("date", "home", "visitor", "hgoal", "vgoal", "FT", "Season")
if (all(colSums(is.na(analysis_data[essential_columns])) == 0)) {
  message("Test Passed: No missing values in essential columns.")
} else {
  stop("Test Failed: Missing values found in essential columns.")
}

# Test if dates are within the specified range
if (all(analysis_data$date >= as.Date("2019-08-16") & analysis_data$date <= as.Date("2022-05-22"))) {
  message("Test Passed: Dates are within the specified range.")
} else {
  stop("Test Failed: Dates are outside the specified range.")
}

# Test if home team is not the same as away team
if (any(analysis_data$home == analysis_data$visitor)) {
  stop("Test Failed: Home team is the same as away team.")
} else {
  message("Test Passed: Home team is not the same as away team.")
}

# Test if scores are between 0 and 10
if (all(analysis_data$hgoal >= 0 & analysis_data$hgoal <= 10) & all(analysis_data$vgoal >= 0 & analysis_data$vgoal <= 10)) {
  message("Test Passed: Scores are within the range of 0 to 10.")
} else {
  stop("Test Failed: Scores are outside the range of 0 to 10.")
}

# Test if Seasons are valid
valid_years <- c(2019, 2020, 2021)
if (all(analysis_data$Season %in% valid_years)) {
  message("Test Passed: Seasons are valid.")
} else {
  stop("Test Failed: Invalid Seasons found.")
}

#### Test Analysis Data 1 ####

# Test the number of rows for analysis_data1
if (nrow(analysis_data1) == 1140) {
  message("Test Passed: The Italy dataset has 1140 rows.")
} else {
  stop("Test Failed: The Italy dataset does not have 1140 rows.")
}

# Test if there are at least one record in analysis_data1
if (nrow(analysis_data1) > 0) {
  message("Test Passed: Italy data contains at least one record.")
} else {
  stop("Test Failed: Italy data does not contain any records.")
}

# Test if analysis_data1 contains all required columns
required_columns <- c("Date", "home", "visitor", "hgoal", "vgoal", "FT", "Season")
if (all(required_columns %in% colnames(analysis_data1))) {
  message("Test Passed: Italy dataset contains all required columns.")
} else {
  stop("Test Failed: Italy dataset is missing required columns.")
}

# Test if there are no missing values in essential columns for analysis_data1
essential_columns <- c("Date", "home", "visitor", "hgoal", "vgoal", "FT", "Season")
if (all(colSums(is.na(analysis_data1[essential_columns])) == 0)) {
  message("Test Passed: No missing values in essential columns for Italy dataset.")
} else {
  stop("Test Failed: Missing values found in essential columns for Italy dataset.")
}

# Test if dates are within the specified range for analysis_data1
if (all(analysis_data1$Date >= as.Date("2019-08-16") & analysis_data1$Date <= as.Date("2022-05-22"))) {
  message("Test Passed: Dates are within the specified range for Italy dataset.")
} else {
  stop("Test Failed: Dates are outside the specified range for Italy dataset.")
}

# Test if home team is not the same as away team for analysis_data1
if (any(analysis_data1$home == analysis_data1$visitor)) {
  stop("Test Failed: Home team is the same as away team for Italy dataset.")
} else {
  message("Test Passed: Home team is not the same as away team for Italy dataset.")
}

# Test if scores are between 0 and 10 for analysis_data1
if (all(analysis_data1$hgoal >= 0 & analysis_data1$hgoal <= 10) & all(analysis_data1$vgoal >= 0 & analysis_data1$vgoal <= 10)) {
  message("Test Passed: Scores are within the range of 0 to 10 for Italy dataset.")
} else {
  stop("Test Failed: Scores are outside the range of 0 to 10 for Italy dataset.")
}

# Test if Seasons are valid for analysis_data1
valid_years <- c(2019, 2020, 2021)
if (all(analysis_data1$Season %in% valid_years)) {
  message("Test Passed: Seasons are valid for Italy dataset.")
} else {
  stop("Test Failed: Invalid Seasons found for Italy dataset.")
}
