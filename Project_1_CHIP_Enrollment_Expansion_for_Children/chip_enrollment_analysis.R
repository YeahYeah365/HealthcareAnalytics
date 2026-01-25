# 1. SETUP
library(tidyverse)
library(lubridate)

# 2. IMPORT (Using your path)
chip_enrollment <- read_csv("/Users/chrishobson/Desktop/DataAnalysis/DataSets/State_Medicaid_and_CHIP_Applications/2025/Updated_on_9-26-25/Second_Draft/pi-dataset-september25-for-June25.csv", 
                            locale = locale(encoding = "Windows-1252"))

# 3. CONVERT DATES (A good way to ensure the X-axis works)
data_ready_for_plot <- chip_enrollment %>%
  mutate(ReportDate = mdy(ReportDateReformat))

# 4. FILTER FOR THE TREND (Crucial: Use >= to keep ALL months from Jan 2023 onwards)
comparison_data <- data_ready_for_plot %>%
  filter(
    `State Name` %in% c("Maine", "Arizona", "North Dakota", "Kansas", "Colorado"),
    ReportDate >= as.Date("2023-01-01") 
  )

# 5. THE PLOT (Mapping 'color' and 'group' to State Name is what creates 5 lines)
comparison_plot <- ggplot(data = comparison_data, 
                          aes(x = ReportDate, y = TotCHIPEnr, color = `State Name`, group = `State Name`)) +
  geom_line(linewidth = 1.1) + 
  geom_point(size = 2) +    
  scale_x_date(date_breaks = "6 months", date_labels = "%b %Y") + 
  labs(
    title = "CHIP Enrollment Trends: Selected States (Starting Jan 2023)",
    x = "Reporting Month",
    y = "Total CHIP Enrollment",
    color = "State"
  ) +
  theme_bw() +
  theme(legend.position = "right")

# 6. DISPLAY
print(comparison_plot)

# Note the exact spaces and double-dashes
ggsave("Project 1 -- CHIP Enrollment Expansion for Children/chip_trends.png", width = 10, height = 6)