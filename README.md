# How does home-field advantage impact goal-scoring in Spanish and Italian League?

## Overview
This repository supports a project examining how home-field advantage influences goal-scoring patterns in the Spanish and Italian soccer leagues. The analysis uses data from publicly available sources and employs statistical methods to assess differences in home and away goal-scoring trends.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from https://github.com/jalapic/engsoccerdata.git
-   `data/analysis_data` Includes cleaned and processed datasets used for statistical modeling and visualization.
-   `model` Houses fitted statistical models for both leagues, focusing on the effects of home-field advantage.
-   `other` Contains related literature, LLM chat logs documenting tool-assisted writing, and exploratory sketches.
-   `paper` Includes the Quarto project files (.qmd), the bibliography file (.bib), and the final PDF version of the paper.
-   `scripts` Provides R scripts for data cleaning, analysis, and visualization.


## Statement on LLM usage

The creation of this project incorporated Large Language Model (LLM) tools for efficiency and clarity. Specific contributions include:

- Code Assistance: Auto-complete and optimization suggestions were provided by Codriver.
- Text Generation: Portions of the abstract, introduction, and methodology were written collaboratively with ChatGPT, with a detailed     history available in inputs/llms/usage.txt.