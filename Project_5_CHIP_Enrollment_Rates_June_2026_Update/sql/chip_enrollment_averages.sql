WITH MonthlyAverages AS (
    SELECT 
        `State Abbreviation`,
        ROUND(AVG(CASE WHEN STR_TO_DATE(ReportDateReformat, '%m/%d/%Y') BETWEEN '2022-01-01' AND '2022-12-31' THEN `TotCHIPEnr` END), 0) AS avg_2022,
        ROUND(AVG(CASE WHEN STR_TO_DATE(ReportDateReformat, '%m/%d/%Y') BETWEEN '2023-01-01' AND '2023-12-31' THEN `TotCHIPEnr` END), 0) AS avg_2023,
        ROUND(AVG(CASE WHEN STR_TO_DATE(ReportDateReformat, '%m/%d/%Y') BETWEEN '2024-01-01' AND '2024-12-31' THEN `TotCHIPEnr` END), 0) AS avg_2024,
        ROUND(AVG(CASE WHEN STR_TO_DATE(ReportDateReformat, '%m/%d/%Y') BETWEEN '2025-01-01' AND '2025-12-31' THEN `TotCHIPEnr` END), 0) AS avg_2025,
        ROUND(AVG(CASE WHEN STR_TO_DATE(ReportDateReformat, '%m/%d/%Y') BETWEEN '2026-01-01' AND '2026-03-31' THEN `TotCHIPEnr` END), 0) AS avg_2026
    FROM 
        CMS.`CHIP-June-2026-update-March-2026-numbers` AS cjumn
    WHERE 
        Final_Report = 'Y'
        AND STR_TO_DATE(ReportDateReformat, '%m/%d/%Y') BETWEEN '2022-01-01' AND '2026-03-31'
    GROUP BY 
        `State Abbreviation`
)
SELECT 
    `State Abbreviation`,
    avg_2022 AS "Avg Monthly Enrollment 2022",
    avg_2023 AS "Avg Monthly Enrollment 2023",
    avg_2024 AS "Avg Monthly Enrollment 2024",
    avg_2025 AS "Avg Monthly Enrollment 2025",
    avg_2026 AS "Avg Monthly Enrollment 2026 (Q1)",
    ROUND(((avg_2026 - avg_2025) / NULLIF(avg_2025, 0)) * 100.0, 1) AS "Pct Change 2025 to 2026"
FROM 
    MonthlyAverages
ORDER BY 
    `Pct Change 2025 to 2026` ASC;