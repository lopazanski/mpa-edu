# Figure 4 Purpose
# Cori Lopazanski


orig_list <- readRDS("data/processed/orig_list.Rds")


topic <- orig_list %>% 
  distinct(plan_id, edu_section_binary, edu_topic) %>% 
  filter(edu_section_binary == 1)

topic2 <- topic %>% 
  group_by(edu_topic) %>%
  summarize(n_plans = length(unique(plan_id)),
            pct_plans = round(n_plans/length(unique(orig_list$plan_id[orig_list$edu_section_binary == 1]))*100, 1)) %>% 
  mutate(edu_topic = fct_reorder(edu_topic, n_plans, .desc = TRUE))
  
ggplot(data = topic2, aes(x = edu_topic, y = pct_plans)) +
  geom_bar(stat = "identity", position = position_dodge(), fill = "#4c9a5f") +
  labs(
    x =  "Overarching purpose of engagement",
    y = "Percent of management plans") +
  theme_minimal() +
  scale_color_manual(labels = "Percent of plans") +
  theme(axis.text.x = element_text(angle = 45, size = 8, hjust = 1)) +
  geom_text(aes(label = paste0(pct_plans, "%")), vjust = -1) +
  scale_y_continuous(limits = c(0, 100))


ggsave(file.path("figs", "Fig4_purpose.png"), width = 7, height = 5, units = c("in"))
