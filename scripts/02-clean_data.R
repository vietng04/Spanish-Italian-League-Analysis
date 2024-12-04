#### Preamble ####
# Purpose: Cleans the raw Italy and Spain League data
# Author: Viet Nguyen
# Date: 25 November 2024
# Contact: viethoang.nguyen@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None

#### Workspace setup ####
# Load necessary libraries
library(tidyverse)
library(readr)
library(dplyr)
library(knitr)
library(arrow)

# Read the dataset
raw_data <- read_csv("data/01-raw_data/spain.csv")
raw_data1 <- read_csv("data/01-raw_data/italy.csv")

# Convert the date column to Date format (ensure it's in the correct format for filtering)
raw_data$date <- as.Date(raw_data$Date, format = "%Y-%m-%d")
raw_data$result <- ifelse(raw_data$hgoal > raw_data$vgoal, "H",
                            ifelse(raw_data$hgoal < raw_data$vgoal, "A", "D"))

raw_data1$Date <- as.Date(raw_data1$Date, format = "%Y-%m-%d")
raw_data1$result <- ifelse(raw_data1$hgoal > raw_data1$vgoal, "H",
                            ifelse(raw_data1$hgoal < raw_data1$vgoal, "A", "D"))

# Filter data for the Season between 2020 and 2022
analysis_data <- raw_data %>%
  filter(Season >= 2019 & Season <= 2022) %>%
  select(date, home, visitor, hgoal, vgoal, FT, Season, result)

analysis_data1 <- raw_data1 %>%
  filter(Season >= 2019 & Season <= 2022) %>%
  select(Date, home, visitor, hgoal, vgoal, FT, Season, result)


# Save the cleaned and filtered data to a new CSV file
write_csv(analysis_data, "data/02-analysis_data/analysis_data_spain.csv")
write_parquet(analysis_data, "data/02-analysis_data/analysis_data_spain.parquet")
write_csv(analysis_data1, "data/02-analysis_data/analysis_data_italy.csv")
write_parquet(analysis_data1, "data/02-analysis_data/analysis_data_italy.parquet")
