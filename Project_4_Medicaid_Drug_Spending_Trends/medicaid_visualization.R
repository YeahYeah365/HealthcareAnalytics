# -------------------------------------------------------------------------
# 2025 Medicaid Prescription Utilization Visualization Script
# Spotlight: Nevada (National Median Benchmark)
# -------------------------------------------------------------------------

# Load required libraries (Install first via install.packages() if needed)
library(ggplot2)
library(dplyr)

# 1. Load your data using your complete Mac file path
data_2025 <- read.csv("/Users/chrishobson/Desktop/Dragon Tree/Blog/12. Medicaid Prescription Drug Spending/Data/R code/Exported Data from DBeaver/Average Prescriptions Per Person Per Month/2025/medicaid_2025.csv")

# Clean column names for easier coding
colnames(data_2025) <- c("State", "Avg_Scripts")

# 2. Calculate the National Average to serve as our chart's benchmark line
national_avg <- mean(data_2025$Avg_Scripts, na.rm = TRUE)

# 3. Create a custom grouping column to highlight Nevada (NV)
data_2025 <- data_2025 %>%
  mutate(Highlight = ifelse(State == "NV", "Nevada (Median)", "Other States"))

# 4. Build the Ranked Horizontal Bar Chart
medicaid_plot <- ggplot(data_2025, aes(x = reorder(State, Avg_Scripts), y = Avg_Scripts, fill = Highlight)) +
  # Draw the bars
  geom_col(width = 0.8) +
  
  # Add the vertical National Average benchmark line
  geom_hline(yintercept = national_avg, linetype = "dashed", color = "#D90429", size = 0.8) +
  
  # Add a text label directly onto the benchmark line
  annotate("text", x = 4, y = national_avg + 0.03, 
           label = paste("National Avg:", round(national_avg, 2)), 
           color = "#D90429", fontface = "bold", hjust = 0) +
  
  # Flip the chart horizontally to make all 50 states highly readable
  coord_flip() +
  
  # Define the color palette (Slate grey for context, Crimson red to isolate Nevada)
  scale_fill_manual(values = c("Nevada (Median)" = "#D90429", "Other States" = "#8D99AE")) +
  
  # Professional styling and labels
  labs(
    title = "2025 Medicaid Prescription Utilization Rates",
    subtitle = "Average Monthly Prescriptions Filled Per Beneficiary (Audited Baseline Data)",
    x = "State",
    y = "Average Scripts Per Person Per Month",
    caption = "Source: CMS State Drug Utilization Data & Performance Indicator Projects (2025)"
  ) +
  
  # Use a clean, minimalist typography theme perfect for publication
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 14, color = "#2B2D42"),
    plot.subtitle = element_text(size = 11, color = "#555555", margin = margin(b = 12)),
    axis.text.y = element_text(size = 8, face = "bold", color = "#2B2D42"),
    axis.title = element_text(face = "bold", color = "#2B2D42"),
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_blank(), # Removes unnecessary horizontal grids for a cleaner look
    legend.position = "none"               # Title and color-coding make a legend redundant
  )

# 5. Save the plot locally exactly where this script is sitting
ggsave(
  filename = "medicaid_utilization_2025.png", 
  plot = medicaid_plot, 
  width = 8, 
  height = 10, 
  dpi = 300
)
# 6. Explicitly print to the RStudio Plots pane to confirm the Ranked Horizontal Bar Chart looks correct
medicaid_plot