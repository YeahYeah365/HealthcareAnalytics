# Hepatitis B Vaccine Guidance Analysis (SQL)

## 📋 Project Overview
The data in this repository corresponds with a blog post that can be found at https://dragontreecomms.com/new-hepatitis-b-vaccine-guidance.

In 2025, the U.S. Centers for Disease Control and Prevention (CDC) changed their guidance on universally recommending the hepatitis B vaccine for all newborns. The updated guidelines, approved based on recommendations by the CDC Advisory Committee on Immunization Practices, advise women testing negative for the virus at the time of giving birth to consult their healthcare providers to see if their babies should get their first doses within 24 hours of birth.

For infants not receiving the vaccine at birth, the CDC suggests an initial dose be given "no earlier than two months of age."
This represents a significant departure from decades' of precedent. We included World Health Organization (WHO) data to provide a global perspective on Hepatitis B vaccination rates. 

This project uses SQL to analyze reporting rates and vaccination trends across various U.S. states to gain a baseline from which we can track trends in hepatitis B vaccination rates over time.

## 🎯 Project Objectives
* **Trend Analysis:** Compare state-level, pre-guidance reporting rates.
* **Identify High-Performers:** Highlight the U.S. states with the highest reporting improvements.
* **Data Integrity:** Identify reporting gaps where state and country data may be incomplete or inconsistent.

## 🛠️ Tech Stack & Skills
* **SQL:** Aggregations, Window Functions, and Delta calculations (Percentage Change).
* **Database:** (e.g., PostgreSQL / BigQuery / DBeaver)
* **Domain:** Public Health Reporting & CDC Compliance.

## 📂 Analysis Roadmap
1. **Data Cleaning:** Removing null state entries and formatting reporting percentages.
2. **Growth Metrics:** Establish a baseline for calculating the year-over-year change in hepatitis B vacination of newborns in the U.S.
3. **Benchmarking:** Comparing individual state performance against national averages.

## 🔍 Key Findings (Sample Results)
* **Top Improvement:** Kansas, Nebraska, and Nevada saw the greatest increase in hepatitis B cases per 100K people.
* **Regional Trends:** The Northeast region showed the most consistently low number of hepatitis B cases between 2020 and 2023.

---

### 🔗 Technical Resources
* **Full SQL Logic:** [View the SQL Script](./queries.sql)
* **Data Source:** [Link to CDC/WHO Data Source]