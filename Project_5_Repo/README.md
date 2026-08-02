# CHIP Enrollment Trends Analysis (Through March 2026 Data)

## Project Overview
This repository contains data analysis scripts tracking continuous Child Health Insurance Program (CHIP) active monthly enrollment trends across five focus states: **Arizona, Colorado, Kansas, Maine, and North Dakota**.

## Methodology & Parameter Notes
* **Primary Metric:** `TotCHIPEnr` (Total Active CHIP Enrollment).
* **Data Validation Filter:** Filtered strictly on `Final_Report == "Y"` in R (`Final_Report = 'Y'` in SQL) to isolate validated monthly rows and eliminate preliminary administrative duplicates.
* **Date Range:** January 2023 – March 2026.
* **Visualization Adjustments:** X-axis labels rotated at 45 degrees (`angle = 45, hjust = 1, vjust = 1`) for readability across continuous time-series month ticks.

## Repository Structure
* `sql/` - SQL queries calculating average monthly active enrollment metrics.
* `scripts/` - R visualization scripts generating individual and combined state line graphs.