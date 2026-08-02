# Project 5: CHIP Enrollment Trends Analysis (2023–2026)

## Overview & Objectives
This repository contains data transformation and visualization workflows tracking continuous Child Health Insurance Program (CHIP) active monthly enrollment trends across five focus states: **Arizona, Colorado, Kansas, Maine, and North Dakota**.

The project evaluates post-pandemic active enrollment trajectories using validated state reporting files to analyze regional variation and multi-year percentage changes.

---

## Combined State Enrollment Trends
![Total CHIP Enrollment Trends across Focus States](images/combined_chip_enrollment_trends.png)

---

## Key Questions Addressed
1. How have total active CHIP enrollment levels shifted across selected states from **January 2023 through March 2026**?
2. What are the baseline average monthly enrollment figures for 2022–2026 across individual target states?
3. Which focus states experienced the highest rate of percentage change between 2025 and Q1 2026?

---

## Methodology & Data Integrity
* **Primary Metric:** `TotCHIPEnr` (Total Active CHIP Enrollment).
* **Validation Filtering:** Filtered strictly on validated administrative records (`Final_Report == "Y"` in R / `Final_Report = 'Y'` in SQL) to eliminate preliminary duplicates.
* **Time Horizon:** Continuous monthly series covering **January 2023 through March 2026** (with historical yearly benchmarks spanning 2022–2026).
* **Data Cleaning & Formatting:**
  * Dates parsed dynamically using `lubridate` to handle mixed string formats (`mdy` / `ymd`).
  * Time-series visualization X-axes styled with 45-degree angled text labels (`angle = 45, hjust = 1, vjust = 1`) for clean visual spacing.

---

## Repository Structure

```text
Project_5_Repo/
│
├── sql/
│   └── chip_enrollment_averages.sql    # CTE query calculating yearly average monthly enrollments & % change
│
├── scripts/
│   └── generate_chip_line_graphs.R     # R script generating combined & individual state trend visual plots
│
├── images/
│   └── combined_chip_enrollment_trends.png # Exported continuous time-series visualization
│
├── .gitignore                          # Excludes raw data files, R caches, and temporary assets
└── README.md                           # Project documentation & execution details