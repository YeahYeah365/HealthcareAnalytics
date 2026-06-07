WITH Yearly_Enrollment AS (
    -- Pre-calculating the average monthly enrollment for 2025 only
    SELECT 
        `State Abbreviation`,
        AVG(`TotMCCHIPEnr`) AS `Avg_Monthly_Enrollees`
    FROM `CMS`.`State_Medicaid_and_CHIP_Applications_April_2026`
    WHERE `Report Date` BETWEEN 202501 AND 202512  -- Strict 2025 filter
      AND `Final_Report` = 'Y'                     -- Only audited data
    GROUP BY `State Abbreviation`
),
Yearly_Drug_Usage AS (
    -- Summing up all prescriptions filled in 2025
    SELECT 
        `State`,
        SUM(`Number_of_Prescriptions`) AS `Total_Scripts`,
        COUNT(DISTINCT `Quarter`) AS `Quarters_Available`
    FROM `CMS`.`Medicaid_SDUD_2025_Full`
    WHERE `Suppression_Used` = 'FALSE'
      AND `Year` = 2025                             -- Strict 2025 filter
    GROUP BY `State`
)
-- Combining the two "prepped bowls" into the final 2025 metric
SELECT 
    TRIM(d.`State`) AS `State`,
    ROUND(
        (d.`Total_Scripts` / (d.`Quarters_Available` * 3)) / e.`Avg_Monthly_Enrollees`, 
        3
    ) AS `Avg_Scripts_Per_Person_Per_Month`
FROM Yearly_Drug_Usage d
JOIN Yearly_Enrollment e ON TRIM(d.`State`) = TRIM(e.`State Abbreviation`)
ORDER BY `Avg_Scripts_Per_Person_Per_Month` DESC;

-- This is how to get rid of empty rows in the SDUD database

DELETE FROM `CMS`.`Medicaid_SDUD_2025_Full` 
WHERE `Year` IS NULL;

-- Checking if there is 2026 data in the SDUD table

SELECT `Year`, COUNT(*) 
FROM `CMS`.`Medicaid_SDUD_2025_Full` 
GROUP BY `Year`;

-- This script finds the rank of all states by their enrollment and 
-- their script rates, then calculates who is closest 
-- to the middle rank (Rank 25 or 26 out of 50)
-- This helps us fingure out which is the most average state for the blog

WITH Yearly_Enrollment AS (
    SELECT 
        `State Abbreviation` AS State,
        AVG(`TotMCCHIPEnr`) AS Avg_Monthly_Enrollees
    FROM `CMS`.`State_Medicaid_and_CHIP_Applications_April_2026`
    WHERE `Report Date` BETWEEN 202501 AND 202512
      AND `Final_Report` = 'Y'
    GROUP BY `State Abbreviation`
),
Yearly_Drug_Usage AS (
    SELECT 
        TRIM(`State`) AS State,
        SUM(`Number_of_Prescriptions`) AS Total_Scripts,
        COUNT(DISTINCT `Quarter`) AS Quarters_Available
    FROM `CMS`.`Medicaid_SDUD_2025_Full`
    WHERE `Suppression_Used` = 'FALSE'
      AND `Year` = 2025
    GROUP BY TRIM(`State`)
),
Metrics AS (
    SELECT 
        d.State,
        e.Avg_Monthly_Enrollees,
        ROUND((d.Total_Scripts / (d.Quarters_Available * 3)) / e.Avg_Monthly_Enrollees, 3) AS Avg_Scripts_Per_Person_Per_Month
    FROM Yearly_Drug_Usage d
    JOIN Yearly_Enrollment e ON d.State = e.State
),
Ranked_Metrics AS (
    -- This numbers the states 1 to 50 for both metrics
    SELECT 
        State,
        Avg_Monthly_Enrollees,
        Avg_Scripts_Per_Person_Per_Month,
        ROW_NUMBER() OVER (ORDER BY Avg_Monthly_Enrollees ASC) AS Enrollment_Rank,
        ROW_NUMBER() OVER (ORDER BY Avg_Scripts_Per_Person_Per_Month ASC) AS Script_Rate_Rank
    FROM Metrics
)
SELECT 
    State,
    Avg_Monthly_Enrollees,
    Enrollment_Rank,
    Avg_Scripts_Per_Person_Per_Month,
    Script_Rate_Rank,
    -- The state with the lowest "distance" from rank 25.5 is our most average state!
    (ABS(Enrollment_Rank - 25.5) + ABS(Script_Rate_Rank - 25.5)) AS Distance_From_Median
FROM Ranked_Metrics
ORDER BY Distance_From_Median ASC
LIMIT 5;