# ==============================================================================
# PROJECT: CHIP Enrollment Trends Analysis (Through March 2026 Data)
# FOCUS: Total CHIP Enrollment Trends (Final Report Data Only)
# UPDATES: 
#   1. Export path updated to 'CHIP_Trends_March_2026_Data/3. Third Draft'
#   2. Filter set strictly to Final_Report == "Y"
#   3. 45-degree rotated X-axis text for clean spacing
# OUTPUTS: 5 Individual State Line Graphs + 1 Combined State Comparison Graph
# ==============================================================================

library(tidyverse)
library(lubridate)

theme_set(theme_bw() + theme(panel.grid.minor = element_blank()))

base_dir <- "/Users/chrishobson/Desktop/Dragon Tree/Blog/14. Update on CHIP enrollment -- June 2026 update for March 2026 numbers"
setwd(base_dir)

chip_data_raw <- read_csv("Data/1. First Draft/CHIP-June-2026-update-March-2026-numbers.csv", 
                          locale = locale(encoding = "Windows-1252"))

data_ready_for_plot <- chip_data_raw %>%
  mutate(
    ReportDate = parse_date_time(ReportDateReformat, orders = c("mdy", "ymd")) %>% as.Date()
  ) %>%
  filter(!is.na(ReportDate)) 

target_states <- c("Maine", "Arizona", "North Dakota", "Kansas", "Colorado")

comparison_data <- data_ready_for_plot %>%
  filter(
    Final_Report == "Y",
    `State Name` %in% target_states,
    ReportDate >= as.Date("2023-01-01")
  ) %>%
  mutate(TotCHIPEnr = as.numeric(TotCHIPEnr))

output_dir <- file.path(base_dir, "CHIP_Trends_March_2026_Data", "3. Third Draft")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

combined_palette <- c(
  "Arizona"      = "#D95F02",
  "Colorado"     = "#7570B3",
  "Kansas"       = "#1B9E77",
  "Maine"        = "#E7298A",
  "North Dakota" = "#E6AB02"
)

combined_plot <- ggplot(data = comparison_data, 
                        aes(x = ReportDate, y = TotCHIPEnr, color = `State Name`, group = `State Name`)) +
  geom_line(linewidth = 1.2) + 
  geom_point(size = 2.5) + 
  scale_x_date(date_breaks = "3 months", date_labels = "%b %Y") + 
  scale_y_continuous(labels = scales::comma) + 
  scale_color_manual(values = combined_palette) +
  labs(
    title = "Total CHIP Enrollment Trends: Selected States (2023–2026)",
    subtitle = "Tracking total active CHIP enrollments over time",
    x = "Reporting Month",
    y = "Total CHIP Enrollment",
    color = "State"
  ) +
  theme(
    legend.position = "right",
    legend.title = element_text(face = "bold"),
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 11, color = "#555555"),
    axis.title = element_text(face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, face = "bold")
  )

print(combined_plot)

ggsave(file.path(output_dir, "combined_chip_enrollment_trends.png"), 
       plot = combined_plot, width = 11, height = 6.5, dpi = 300)

individual_state_colors <- c(
  "Arizona"      = "#1F78B4",
  "Colorado"     = "#6A3D9A",
  "Kansas"       = "#008080",
  "Maine"        = "#33A02C",
  "North Dakota" = "#D95F02"
)

for (state in target_states) {
  state_filtered_data <- comparison_data %>% filter(`State Name` == state)
  state_color <- individual_state_colors[state]
  
  state_plot <- ggplot(state_filtered_data, aes(x = ReportDate, y = TotCHIPEnr)) +
    geom_line(color = state_color, linewidth = 1.2) +
    geom_point(color = state_color, size = 2.5) +
    scale_x_date(date_breaks = "3 months", date_labels = "%b %Y") +
    scale_y_continuous(labels = scales::comma) +
    labs(
      title = paste(state, "Total CHIP Enrollment Trend (Starting Jan 2023)"),
      x = "Reporting Month",
      y = "Total CHIP Enrollment"
    ) +
    theme(
      plot.title = element_text(face = "bold", size = 13),
      axis.title = element_text(face = "bold"),
      axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, face = "bold")
    )
  
  print(state_plot)
  clean_state_name <- str_replace_all(tolower(state), " ", "_")
  
  ggsave(filename = file.path(output_dir, paste0("chip_trend_", clean_state_name, ".png")),
         plot = state_plot, width = 8, height = 4.5, dpi = 300)
}