#### Preamble ####
# Purpose: Models for clean data
# Author: Viet Nguyen
# Date: 26 November 2024
# Contact: viethoang.nguyen@mail.utoronto.ca
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
raw_data <- read_csv("/Users/nguyenviet/Desktop/STA304/national-football-team-stats/data/01-raw_data/results.csv")
data <- read_csv("/Users/nguyenviet/Desktop/STA304/national-football-team-stats/data/02-analysis_data/clean_data.csv")

### Model data ####
tournaments <- c("Friendly", "FIFA World Cup", "UEFA Euro", "UEFA Nations League")
home_team <- c("Argentina", "France", "Spain", "England", "Brazil", "Belgium", "Portugal", "Netherlands", 
                        "Italy", "Germany", "Croatia", "Uruguay", "Japan", "South Korea")
away_team <- c("Argentina", "France", "Spain", "England", "Brazil", "Belgium", "Portugal", "Netherlands", 
                        "Italy", "Germany", "Croatia", "Uruguay", "Japan", "South Korea")

selected_home_team = ifelse(data$home_team %in% home_team, 1, 0)
selected_away_team = ifelse(data$away_team %in% away_team, 1, 0)

hometeam_model <- lm(home_score ~ selected_home_team + selected_away_team + tournament + date, data = data) 
awayteam_model <- lm(away_score ~ selected_home_team + selected_away_team + tournament + date, data = data)

summary(hometeam_model)
summary(awayteam_model)

#### Save model ####
saveRDS(hometeam_model,file = "/Users/nguyenviet/Desktop/STA304/national-football-team-stats/models/hometeam_model.rds")
saveRDS(awayteam_model,file = "/Users/nguyenviet/Desktop/STA304/national-football-team-stats/models/awayteam_model.rds")


