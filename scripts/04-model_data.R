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
data_spain <- read_parquet(here("data/02-analysis_data/analysis_data_spain.parquet"))
data_italy <- read_parquet(here("data/02-analysis_data/analysis_data_italy.parquet"))


### Model data ####
# Model data for Spain League
home_spain <- c("FC Barcelona", "Real Madrid", "Atletico Madrid", "Villarreal CF", "Athletic Bilbao", "CA Osasuna", 
                         "Sevilla FC", "Real Sociedad", "	Valencia CF", "Real Betis", "Cadiz CF", "Granada CF")
away_spain <- c("FC Barcelona", "Real Madrid", "Atletico Madrid", "Villarreal CF", "Athletic Bilbao", "CA Osasuna", 
               "Sevilla FC", "Real Sociedad", "	Valencia CF", "Real Betis", "Cadiz CF", "Granada CF")

home_team_spain = ifelse(data_spain$home %in% home_spain, 1, 0)
home_spain_wins = ifelse(data_spain$result == "H", 1, 0)
away_team_spain = ifelse(data_spain$visitor %in% away_spain, 1, 0)
away_spain_wins = ifelse(data_spain$result == "A", 1, 0)
data_spain$goal_difference_home_win <- ifelse(data_spain$result == "H", data_spain$hgoal - data_spain$vgoal, 0)
data_spain$goal_difference_visitor_win <- ifelse(data_spain$result == "H", data_spain$vgoal - data_spain$hgoal, 0)

home_spain_model <- lm(hgoal ~ home_team_spain + home_spain_wins + goal_difference_home_win + date + Season, data = data_spain)
away_spain_model <- lm(vgoal ~ away_team_spain + away_spain_wins + goal_difference_visitor_win + date + Season, data = data_spain)
summary(home_spain_model)
summary(away_spain_model)


# Model data for Italy League
home_italy <- c("SSC Napoli", "Atalanta", "Inter", "ACF Fiorentina", "Lazio Roma", "Juventus", "AC Milan",
                "Bologna FC", "Udinese Calcio", "Empoli FC", "AS Roma", "Genoa CFC")
away_italy <- c("SSC Napoli", "Atalanta", "Inter", "ACF Fiorentina", "Lazio Roma", "Juventus", "AC Milan",
                "Bologna FC", "Udinese Calcio", "Empoli FC", "AS Roma", "Genoa CFC")

home_team_italy = ifelse(data_italy$home %in% home_italy, 1, 0)
home_italy_wins = ifelse(data_spain$result == "H", 1, 0)
away_team_italy = ifelse(data_italy$visitor %in% away_italy, 1, 0)
away_italy_wins = ifelse(data_italy$result == "A", 1, 0)
data_italy$goal_difference_home_win <- ifelse(data_italy$result == "H", data_italy$hgoal - data_italy$vgoal, 0)
data_italy$goal_difference_visitor_win <- ifelse(data_italy$result == "H", data_italy$vgoal - data_italy$hgoal, 0)

home_italy_model <- lm(hgoal ~ home_team_italy + home_italy_wins + goal_difference_home_win + Date + Season, data = data_italy) 
away_italy_model <- lm(vgoal ~ away_team_italy + away_italy_wins + goal_difference_visitor_win + Date + Season, data = data_italy)
summary(home_italy_model)
summary(away_italy_model)

#### Save model ####
saveRDS(home_spain_model,file = "models/home_spain_model.rds")
saveRDS(away_spain_model,file = "models/away_spain_model.rds")
saveRDS(home_italy_model,file = "models/home_italy_model.rds")
saveRDS(away_italy_model,file = "models/away_italy_model.rds")


