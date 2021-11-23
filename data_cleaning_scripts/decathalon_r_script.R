# Cleaning --------------------------------------------------------------------

# Reading in scripts ------------
library(readr)
library(tidyverse)
library(dplyr)
library(janitor)

# Reading in data ---------------
decathalon_data <- read_rds("decathlon.rds")

read_rds(here::here("decathlon.rds"))
# add the here thing!

# Moving row names into the dataframe -------------
decathalon_data$names <- c("Serble", "Clay", "Karpov", "Bernard", "Yurkov",
                           "Warners", "Zsivoczky", "McMullen", "Martineau", 
                           "Hernu", "Barras", "Nool", "Bouguignon", "Serble",
                           "Clay", "Karpov", "Macey", "Warners", "Zsivoczky",
                           "Hernu", "Nool", "Bernard", "Schwarzl", "Pogorelov",
                           "Schoenbeck", "Barras", "Smith", "Averyanov", 
                           "Ojaniemi", "Smirnov", "Qi", "Drews", "Parkhomenko",
                           "Terek", "Gomez", "Turi", "Lorenzo", "Karlivans",
                           "Korkizoglou", "Uldal", "Casarsa")

# Deleting the rownames from the dataframe
rownames(decathalon_data) <- NULL

# Cleaning the column names
decathalon_data <- clean_names(decathalon_data)

# Moving the names column
decathalon_data <- decathalon_data %>%
  relocate(names, .before = "100m")

# Cleaning the remaining column names to conform to tidy standard
decathalon_data <- decathalon_data %>%
  rename("100m" = "x100m",
         "400m" = "x400m",
         "110m_hurdle" = "x110m_hurdle",
         "javelin" = "javeline",
         "1500m" = "x1500m")

# Pivoting the decathalon table
decathalon_data <- decathalon_data %>%
  pivot_longer(cols = names, names_to = "name",
               values_to = "winner_of_competition") %>%
  pivot_wider(names_from = competition,
              values_from = winner_of_competition)

write_csv(decathalon_data, file = "GitHub/dirty_data/task_1/dirty_data_codeclan_project_louise_task1/clean_data/decathalon_clean.csv")