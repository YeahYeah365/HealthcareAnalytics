# Rural Health Transformation Program (RHTP) Analysis

This project analyzes the current landscape of rural healthcare infrastructure in the U.S. in light of the $50 billion Rural Health Transformation Program (RHTP) initiative. It explores the distribution, historical growth, and state-level variations of Rural Health Clinics (RHCs) and Federally Qualified Health Centers (FQHCs).

## Table of Contents
* [Problem Statement](#-problem-statement)
* [Data Sources](#-data-sources)
* [SQL Implementation](#-sql-implementation)
* [R Analysis & Visualization](#-r-analysis--visualization)
* [Key Insights](#-key-insights)

---

## ❓ Problem Statement
With $50 billion allocated over five fiscal years (2026–2030), the RHTP aims to fix systemic access issues in rural America. This analysis investigates how existing infrastructure—specifically 5,450+ RHCs and various FQHC "look-alikes"—is positioned to receive these funds.

---

## 📂 Data Sources
* **CMS Data:** Rural Health Clinic and Federally Qualified Health Center enrollment records (1950–2026).
* **Dragon Tree Communications:** Research on the RHTP funding breakdown.

---

## 🛠️ SQL Implementation
### Rural Facility Enrollment & Trends
| Project | Key Functions | Code Link |
| :--- | :--- | :--- |
| **Rural Health Analysis** | Aggregations, Date Filtering, Joins | [SQL Script](./rural_analysis.sql) |

---

## 📊 R Analysis & Visualization
### Historical Incorporation & Growth Outliers
| Project | Libraries Used | Code Link |
| :--- | :--- | :--- |
| **Growth Trend Analysis** | `tidyverse`, `ggplot2` | [R Script](./rural_health_analysis.R) |

---

## 📈 Key Visualizations

### 1. RHC Top 10 Development Trends
![RHC Top 10 Trends](rhc_chart_1.jpeg)

---

### 2. FQHC Top 10 Development Trends
![FQHC Top 10 Trends](rhc_chart_2.jpeg)

---

### 3. Historical Incorporation Trends (1950-2026)
![Historical Growth Bar Chart](fqhc_chart.jpeg)
---

## 💡 Key Insights
* **State Leaders:** Kentucky leads the nation in RHCs (409), while California dominates FQHC enrollments. 
* **Historical Spikes:** Identified Tennessee as a massive outlier in RHC expansion during the 1990s.
* **Stagnation:** Data shows that FQHC incorporation peaked in the 1970s–90s and has remained at low levels ever since.