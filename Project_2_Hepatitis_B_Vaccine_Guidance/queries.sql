-- This approach takes null values and zeroes into account and it doesn't create the column headings like "Rate_2020" 

SELECT
    T20.State,
    
    -- Defining a CTE/Subquery calculation for clean re-use
    -- CAST(T20.`Cases/100,000 Population` AS DECIMAL(10, 2)) AS Rate_2020,
    -- CAST(T21.`Cases/100,000 Population` AS DECIMAL(10, 2)) AS Rate_2021,
    -- CAST(T22.`Cases/100,000 Population` AS DECIMAL(10, 2)) AS Rate_2022,
    -- CAST(T23.`Cases/100,000 Population` AS DECIMAL(10, 2)) AS Rate_2023,

    -- Use a subquery or CTE to apply the CAST/CASE logic first, then proceed with calculations.
    -- For simplicity and maximum compatibility, we will apply the CAST/CASE logic directly in the SELECT list.

    -- Note: Since 'N' is text, we must explicitly check for it.
    -- We'll define a macro-like expression for safe numeric retrieval:
    CASE WHEN T20.`Cases/100,000 Population` = 'N' THEN NULL 
         ELSE CAST(T20.`Cases/100,000 Population` AS DECIMAL(10, 2)) END AS `Cases_2020_Per_100K`,
    CASE WHEN T21.`Cases/100,000 Population` = 'N' THEN NULL 
         ELSE CAST(T21.`Cases/100,000 Population` AS DECIMAL(10, 2)) END AS `Cases_2021_Per_100K`,
    CASE WHEN T22.`Cases/100,000 Population` = 'N' THEN NULL 
         ELSE CAST(T22.`Cases/100,000 Population` AS DECIMAL(10, 2)) END AS `Cases_2022_Per_100K`,
    CASE WHEN T23.`Cases/100,000 Population` = 'N' THEN NULL 
         ELSE CAST(T23.`Cases/100,000 Population` AS DECIMAL(10, 2)) END AS `Cases_2023_Per_100K`,

    -- Calculated columns use the CASE/CAST logic inline to ensure safety.
    -- Note: This is getting long, so using a CTE (Common Table Expression) is highly recommended 
    -- to clean this up, but we will stick to the single query structure for now.

    -- We need to repeat the full CASE/CAST expression for every calculation:
    
    -- Total Cases (Sum):
    (
        (CASE WHEN T20.`Cases/100,000 Population` = 'N' THEN NULL ELSE CAST(T20.`Cases/100,000 Population` AS DECIMAL(10, 2)) END) + 
        (CASE WHEN T21.`Cases/100,000 Population` = 'N' THEN NULL ELSE CAST(T21.`Cases/100,000 Population` AS DECIMAL(10, 2)) END) + 
        (CASE WHEN T22.`Cases/100,000 Population` = 'N' THEN NULL ELSE CAST(T22.`Cases/100,000 Population` AS DECIMAL(10, 2)) END) + 
        (CASE WHEN T23.`Cases/100,000 Population` = 'N' THEN NULL ELSE CAST(T23.`Cases/100,000 Population` AS DECIMAL(10, 2)) END)
    ) AS `Total_Cases_Per_State`,

    -- Percentage Change (2020 to 2023) - using NULLIF for division by zero safety
    (
        (
            (CASE WHEN T23.`Cases/100,000 Population` = 'N' THEN NULL ELSE CAST(T23.`Cases/100,000 Population` AS DECIMAL(10, 2)) END) - 
            (CASE WHEN T20.`Cases/100,000 Population` = 'N' THEN NULL ELSE CAST(T20.`Cases/100,000 Population` AS DECIMAL(10, 2)) END)
        ) 
        / 
        NULLIF( (CASE WHEN T20.`Cases/100,000 Population` = 'N' THEN NULL ELSE CAST(T20.`Cases/100,000 Population` AS DECIMAL(10, 2)) END) , 0)
    ) * 100 AS `Pct_Change_2020_to_2023`
    
FROM
    CDCData.`2020_cases_of_acute_hepatitis_B` AS T20
INNER JOIN
    CDCData.`2021_cases_of_acute_hepatitis_B` AS T21
    ON T20.State = T21.State
INNER JOIN
    CDCData.`2022_cases_of_acute_hepatitis_B` AS T22
    ON T21.State = T22.State
INNER JOIN
    CDCData.`2023_cases_of_acute_hepatitis_B` AS T23
    ON T22.State = T23.State
    
ORDER BY
    `Pct_Change_2020_to_2023` DESC;

-- This query looks at OECD countries using World Health Organization (WHO) data
-- The data shows that the U.S. is in the middle of the pack in terms of administering hepatitis B vaccines to newborns across a range of years. 
-- This data isn't as accurate as it could be because certain countries (Denmark, Hungary, and Iceland) don't make their data available to the WHO. 
-- In any case, it gives us a rough idea of how the U.S. compares to like countries. The data below is for the year 2024.

SELECT w.Location, w.PercentOneYearOlds
FROM WHOData.WHOWeb2000 w
WHERE Period = 2024 
AND Location IN ('Argentina', 
'Australia',
'Austria',
'Belgium',
'Canada',
'Chile',
'Columbia',
'Costa Rica',
'Czechia',
'Denmark',
'Estonia',
'Finlind',
'France',
'Germany',
'Greece',
'Hungary',
'Iceland',
'Ireland',
'Israel',
'Italy',
'Japan',
'Republic of Korea'
'Latvia',
'Lithuania'
'Luxembourg',
'Mexico',
'Netherlands (Kingdom of the',
'New Zealand',
'Norway',
'Poland',
'Portugal',
'Slovak Republic',
'Slovenia',
'Spain',
'Sweden',
'Switzerland'
'Turkiye'
'United Kingdom of Great Britain and Northern Ireland', 
'United States of America'
)
ORDER BY w.PercentOneYearOlds DESC