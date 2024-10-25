# explore education section
# Question: how many mpas have education sectors?
library(tidyverse)
# Read data:
orig_list <- readRDS("data/raw-ish/education_export_21Oct2024.Rds")

# Build -------------------------------------

# how many total distinct plans
distinct_plans <- orig_list |> 
  distinct(plan_id) |> 
  count()
  
edu_sect <- orig_list |> 
  filter(edu_section_binary == 1 | edu_section_binary == 0) |> 
  distinct(plan_id, edu_section_binary, name) |> 
  
n_yes <- edu_sect |> 
  filter(edu_section_binary == 1) |> 
  count()

# EDU WHAT
edu_what <- orig_list |> 
  distinct(obs_id, plan_id, edu_what) |> 
  group_by(edu_what) |> 
  summarize(n_strategies = length(unique(obs_id)),
            n_plans = length(unique(plan_id))) |> 
  mutate(percent_of_strategies = n_strategies/length(unique(orig_list$obs_id))*100,
                percent_of_plans = n_plans/length(unique(orig_list$plan_id))*100) |> 
  rename(strategy_type = edu_what)
