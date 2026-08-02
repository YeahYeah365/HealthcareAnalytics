# Project 5: CHIP Enrollment Trends Analysis (2023–2026)

## Overview & Objectives
This repository contains data transformation and visualization workflows tracking continuous Child Health Insurance Program (CHIP) active monthly enrollment trends across five focus states: **Arizona, Colorado, Kansas, Maine, and North Dakota**.

The project evaluates post-pandemic active enrollment trajectories using validated state reporting files to analyze regional variation and multi-year percentage changes.

---

## Combined State Enrollment Trends
*The visualization below tracks total active CHIP enrollment continuously from January 2023 through March 2026, using strictly validated administrative records (`Final_Report == "Y"`).*

![Total CHIP Enrollment Trends across Focus States](images/combined_chip_enrollment_trends.png)

---

## Key Findings & Parameters
* **Primary Metric:** `TotCHIPEnr` (Total Active CHIP Enrollment).
* **Time Horizon:** January 2023 through March 2026 (Continuous monthly time series).
* **Cleaning & Presentation:** Dates are parsed dynamically, and visualizations utilize 45-degree angled x-axis labels for optimized readability across years.

---

## Technical Stack
* **SQL (MySQL Dialect):** Common Table Expressions (CTEs), conditional aggregation (`CASE WHEN`), string-to-date conversion.
* **R / Tidyverse:** `ggplot2` (custom state color palettes, continuous axes), `dplyr`, `lubridate` (date parsing), `readr`.