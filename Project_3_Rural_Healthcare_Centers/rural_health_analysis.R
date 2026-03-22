# Project: Rural Health Transformation Program (RHTP) Analysis
# Data Source: CMS Rural Health Clinic (RHC) & FQHC Enrollments
# Author: Chris Hobson

# Annual FQHC Incorporations 1950 - 2026 -- use this on the blog and add to GitHub

# 1. SETUP
library(tidyverse)
library(lubridate)

# 2. IMPORT DATA
rhc_raw <- read_csv("/Users/chrishobson/Desktop/DataAnalysis/DataSets/CMS/CMSRuralHealthClinicEnrollments/2026/Quarter1/RHC_Enrollments_2026.01.21.csv")
fqhc_raw <- read_csv("/Users/chrishobson/Desktop/DataAnalysis/DataSets/CMS/CMSFederallyQualifiedHealthClinicEnrollments/2026/Quarter1/FederallyQualifiedHealthCenterEnrollments/2026-Q1/FQHC_Enrollments_Q1_2026.01.21.csv")

# 3. CLEAN RHC DATA (2-digit Year: DD/MM/YY)
rhc_clean <- rhc_raw %>%
  mutate(Incop_Date = dmy(`INCORPORATION DATE`),
         Incop_Year = year(Incop_Date)) %>%
  # Correction for 2-digit year (e.g., '42' becoming 2042 instead of 1942)
  mutate(Incop_Year = if_else(Incop_Year > 2026, Incop_Year - 100, Incop_Year)) %>%
  filter(Incop_Year >= 1950 & Incop_Year <= 2026) %>%
  count(Incop_Year, name = "Count")

# 4. CLEAN FQHC DATA (4-digit Year: DD/MM/YYYY)
fqhc_clean <- fqhc_raw %>%
  mutate(Incop_Date = dmy(`INCORPORATION DATE`),
         Incop_Year = year(Incop_Date)) %>%
  filter(Incop_Year >= 1950 & Incop_Year <= 2026) %>%
  count(Incop_Year, name = "Count")

# 5. VISUALIZE RHC
ggplot(rhc_clean, aes(x = Incop_Year, y = Count)) +
  geom_col(fill = "steelblue") +
  scale_x_continuous(limits = c(1950, 2026), breaks = seq(1950, 2026, 10)) +
  labs(title = "Annual RHC Incorporations (1950-2026)", x = "Year", y = "Count") +
  theme_bw()

# 6. VISUALIZE FQHC
ggplot(fqhc_clean, aes(x = Incop_Year, y = Count)) +
  geom_col(fill = "darkgreen") +
  scale_x_continuous(limits = c(1950, 2026), breaks = seq(1950, 2026, 10)) +
  labs(title = "Annual FQHC Incorporations (1950-2026)", x = "Year", y = "Count") +
  theme_bw()

# Visualizer's choice of graphs for "Regional RHC Incorporation Trends" -- use this on the blog and add to GitHub

# Making sure Illinois isn't missing because of a filtering error since it's in the top 10 chart of most RHCs per state

rhc_cleaned %>% filter(STATE == "IL") %>% nrow()

# 1. IDENTIFY TOP 10 (Same as before)
top_10_list <- rhc_cleaned %>%
  group_by(STATE) %>%
  summarise(Total = n()) %>%
  slice_max(Total, n = 10) %>%
  pull(STATE)

# 2. FILTER & AGGREGATE
plot_data <- rhc_cleaned %>%
  filter(STATE %in% top_10_list) %>%
  group_by(Incop_Year, STATE) %>%
  summarise(Annual_Count = n(), .groups = "drop")

# 3. THE PLOT (Faceted to handle the TN outlier)
rhc_faceted_plot <- ggplot(plot_data, aes(x = Incop_Year, y = Annual_Count, fill = STATE)) +
  geom_area(alpha = 0.8, show.legend = FALSE) + # Area charts look great in facets
  facet_wrap(~STATE, scales = "free_y", ncol = 5) + # Each state gets its own Y-axis!
  scale_x_continuous(breaks = c(1950, 1988, 2026)) +
  scale_fill_brewer(palette = "Paired") + 
  labs(
    title = "Regional RHC Incorporation Trends",
    subtitle = "Top 10 Individual states (1950-2026)",
    x = "Year",
    y = "New Clinics per Year"
  ) +
  theme_minimal() +
  theme(
    strip.background = element_rect(fill = "gray90"),
    strip.text = element_text(face = "bold"),
    axis.text.x = element_text(angle = 45, size = 8)
  )

# 4. DISPLAY
print(rhc_faceted_plot)



# Visualizer's choice of graphs for "Top 10 states: FQHC Incorporation Trends" -- use this on the blog


# 1. SETUP
library(tidyverse)
library(lubridate)

# 2. IMPORT (Using the exact no-space path)
fqhc_raw <- read_csv("/Users/chrishobson/Desktop/DataAnalysis/DataSets/CMS/CMSFederallyQualifiedHealthClinicEnrollments/2026/Quarter1/FederallyQualifiedHealthCenterEnrollments/2026-Q1/FQHC_Enrollments_Q1_2026.01.21.csv")

# 3. CLEAN & PREP DATA
# FQHC uses 4-digit years (DD/MM/YYYY), so dmy() handles it directly
fqhc_cleaned <- fqhc_raw %>%
  mutate(
    Incop_Date = dmy(`INCORPORATION DATE`),
    Incop_Year = year(Incop_Date)
  ) %>%
  # Filtering for the historical range (FQHC program began in 1965)
  filter(Incop_Year >= 1950 & Incop_Year <= 2026)

# 4. IDENTIFY TOP 10 STATES (By total volume)
top_10_list <- fqhc_cleaned %>%
  group_by(STATE) %>%
  summarise(Total = n()) %>%
  slice_max(Total, n = 10) %>%
  pull(STATE)

# 5. FILTER & AGGREGATE
plot_data <- fqhc_cleaned %>%
  filter(STATE %in% top_10_list) %>%
  group_by(Incop_Year, STATE) %>%
  summarise(Annual_Count = n(), .groups = "drop")

# 6. THE PLOT (Faceted with Free Y-Axis)
fqhc_faceted_plot <- ggplot(plot_data, aes(x = Incop_Year, y = Annual_Count, fill = STATE)) +
  geom_area(alpha = 0.8, show.legend = FALSE) + 
  facet_wrap(~STATE, scales = "free_y", ncol = 5) + 
  scale_x_continuous(breaks = c(1965, 1995, 2026)) + 
  scale_fill_brewer(palette = "Paired") + 
  labs(
    title = "Top 10 States: FQHC Incorporation Trends",
# subtitle = "Faceted view with independent Y-axes to highlight regional growth shapes",
    x = "Year of Incorporation",
    y = "New Centers per Year"
  ) +
  theme_minimal() +
  theme(
    strip.background = element_rect(fill = "gray95"),
    strip.text = element_text(face = "bold", size = 10),
    axis.text.x = element_text(angle = 45, size = 8),
    panel.spacing = unit(1, "lines")
  )

# 7. DISPLAY & SAVE
print(fqhc_faceted_plot)
ggsave("fqhc_top_10_facets.png", width = 14, height = 7, dpi = 300)
