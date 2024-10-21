# Step 2 Explore Target Audience
# Cori Lopazanski
# October 2024

# Setup ------------------------------------------------------------------------
library(tidyverse)

# Read Data
orig_list <- readRDS("data/raw-ish/education_export_21Oct2024.Rds")


# Build ------------------------------------------------------------------------

target <- orig_list %>% 
  distinct(obs_id, plan_id, edu_target_audience) %>% 
  separate(edu_target_audience, into = paste0("part_", 1:8), sep = ";", fill = "right", extra = "merge") %>%
  group_by(edu_target_audience) %>% 
  summarize(n_strategies = length(unique(obs_id)),
            n_plans = length(unique(plan_id))) %>% 
  mutate(percent_of_strategies = n_strategies/length(unique(orig_list$obs_id))*100,
         percent_of_plans = n_plans/length(unique(orig_list$plan_id))*100)

# Save ------------------------------------------------------------------------

# Save this


# here 

something else
  
  