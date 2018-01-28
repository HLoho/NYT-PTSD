## Script to make a csv of all PTSD terms and number of total hits, ordered by number of hits
## AM Chekroud & H Loho

# Housekeeping
libs <- c("tidyverse", "RColorBrewer","stringr", "foreach", "forcats", "dplyr")
invisible(lapply(libs, require, character.only = TRUE))

setwd("/Users/hieronimusloho/Box Sync/Research Stuff/NewYorkTimes")

all <- readRDS("Processed_Data/all_terms_hits.RDS")
all.yearly <- readRDS("Processed_Data/all_terms_hits.yearly.RDS")
ptsd_terms_to_select <- read_csv("Scripts/terms/veterans_paper_terms.csv", col_names = "term")


ptsd_terms_total_hits <- all %>%
  filter(term %in% ptsd_terms_to_select$term) %>%
  group_by(term) %>%
  summarize(total_hits = sum(hits)) %>%
  plyr::arrange(desc(total_hits))

write_csv(ptsd_terms_total_hits, path = "CSVs/other/Supplement_table.csv")
ptsd_terms_highest_percentage <- all.yearly %>%
  filter(term %in% ptsd_terms_to_select$term) %>%
  group_by(term) %>%
  summarize(highest_percentage_in_any_one_year = max(yearly_percentage)) %>%
  plyr::arrange(desc(highest_percentage_in_any_one_year))
