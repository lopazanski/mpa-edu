# Pull education data from google drive
# Cori Lopazanski
# October 2024

# Setup ------------------------------------------------------------------------
library(tidyverse)
library(googlesheets4)
library(janitor)
library(googledrive)


# drive.dir <- "/Users/lopazanski/Library/CloudStorage/GoogleDrive-lopazanski@ucsb.edu/Shared drives/4-MPA Education/2-Data"


# Read data from google --------------------------------------------------------

orig_list <- read_sheet("https://docs.google.com/spreadsheets/d/1pA9tHg_jjx9XXXxRRws8KiTv0P5nsXWR-1Oz5JyLL1o/edit?gid=1188768943#gid=1188768943",
                        sheet = "USE THIS plan-info", trim_ws = T, range = "A:Q",
                        na = c("NA", "", "N/A"), col_types = "ncnccccccncncncnc") %>% 
  mutate(obs_id = rownames(.)) %>% 
  clean_names()

saveRDS(orig_list, "data/raw-ish/education_export_26Feb2025.Rds")
