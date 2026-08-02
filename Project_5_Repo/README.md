# Project 5: CHIP Enrollment Trends Analysis (2023–2026)

This project evaluates continuous Child Health Insurance Program (CHIP) active monthly enrollment trajectories across five focus states: **Arizona, Colorado, Kansas, Maine, and North Dakota**. By tracking validated administrative state reporting files from January 2023 through March 2026, this analysis establishes an audited baseline to measure regional variations and post-pandemic enrollment changes.

## Table of Contents
* [Problem Statement](#-problem-statement)
* [Data Sources](#-data-sources)
* [SQL Implementation](#-sql-implementation)
* [R Analysis & Visualization](#-r-analysis--visualization)
* [Key Visualizations](#-key-visualizations)
* [Key Insights](#-key-insights)

---

## ❓ Problem Statement
Post-pandemic Medicaid and CHIP redetermination policies created significant state-level fluctuations in program coverage. This analysis evaluates active monthly CHIP enrollment trajectories across five focus states to quantify multi-year percentage shifts and identify key enrollment baselines following public health emergency unwindings.

---

## 📂 Data Sources
* **CMS CHIP Enrollment Data:** [State Medicaid and CHIP Applications, Monthly Reports](https://data.medicaid.gov/dataset/6165f45b-ca93-5bb5-9d06-db29c692a360)
* **Time Horizon:** January 2023 through March 2026 (Continuous monthly series with 2022–2026 baseline averages)

---

## 🛠️ SQL Implementation
### Relational Table Joins & Aggregations
| Focus | Key Functions / Operations | Code Link |
| :--- | :--- | :--- |
| **Data Engineering** | Common Table Expressions (CTEs), `CASE WHEN` Conditional Aggregations, `STR_TO_DATE()`, `NULLIF()` Handling | [SQL Script](./sql/chip_enrollment_averages.sql) |

---

## 📊 R Analysis & Visualization
### Baseline Visualizations
| Analysis | Libraries Used | Code Link |
| :--- | :--- | :--- |
| **Time-Series Plotting** | `tidyverse`, `ggplot2`, `dplyr`, `lubridate` | [R Script](./scripts/generate_chip_line_graphs.R) |

---

## 📈 Key Visualizations

### 1. Total Active CHIP Enrollment Trends (2023–2026)
This continuous multi-line graph tracks active CHIP enrollment trends across Arizona, Colorado, Kansas, Maine, and North Dakota, utilizing strictly validated state reporting records (`Final_Report == "Y"`).
<br>
<img width="3300" height="1950" alt="combined_chip_enrollment_trends" src="https://github.com/user-attachments/assets/8c54f6c9-b01a-47d8-8d58-128f1bca42ef" />

---

## 💡 Key Insights
* **Metric Standardization:** Evaluates active coverage using `TotCHIPEnr` (Total Active CHIP Enrollment) across all selected focus jurisdictions.
* **Data Integrity:** Filtering exclusively for records where `Final_Report = 'Y'` (in SQL) and `Final_Report == "Y"` (in R) eliminates preliminary reporting duplicates and unverified figures.
* **Visual Optimization:** Time-series dates are parsed dynamically via `lubridate`, utilizing 45-degree angled x-axis labels to ensure clear visual separation across multi-year trends.
