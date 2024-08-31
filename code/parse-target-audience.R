# Parse the target audience 
# Cori Lopazanski
# August 2024


# Setup ------------------------------------------------------------------------
library(tidyverse)
library(googlesheets4)
library(janitor)
library(googledrive)

drive.dir <- "/Users/lopazanski/Library/CloudStorage/GoogleDrive-lopazanski@ucsb.edu/Shared drives/4-MPA Education/2-Data"

orig_list <- read_sheet("https://docs.google.com/spreadsheets/d/1pA9tHg_jjx9XXXxRRws8KiTv0P5nsXWR-1Oz5JyLL1o/edit?gid=1188768943#gid=1188768943",
                        sheet = "USE THIS plan-info", trim_ws = T, range = "A:Q",
                        na = c("NA", ""), col_types = "ncnccccccncncncnc") %>% 
  mutate(obs_id = rownames(.)) %>% clean_names()

#write.csv(orig_list, "data/orig_list_export_31Aug2024.csv", row.names = FALSE)

# Build ------------------------------------------------------------------------

target <- orig_list %>% 
  distinct(obs_id, plan_id, edu_target_audience) %>% 
  separate(edu_target_audience, into = paste0("part_", 1:8), sep = ";", fill = "right", extra = "merge") %>%
  mutate(across(everything(), str_trim)) %>% 
  pivot_longer(part_1:part_8, values_to = "edu_target_audience", names_to = NULL, values_drop_na = T) %>% 
  group_by(edu_target_audience) %>% 
  summarize(n_strategies = length(unique(obs_id)),
            n_plans = length(unique(plan_id))) %>% 
  mutate(percent_of_strategies = n_strategies/length(unique(orig_list$obs_id))*100,
         percent_of_plans = n_plans/length(unique(orig_list$plan_id))*100)

# Share ------------------------------------------------------------------------

write.csv(target, "target_audience_table.csv", row.names = FALSE)
