-- RHC Information

-- This is for the "State of the RHC’s practice location address" (*This is the one that should be used in the blog post for the number of RHCs in the state)

SELECT 
    `STATE`, 
    COUNT(*) AS RHC_State_Count
FROM CMSData.CMS_RHC_Enrollments cre 
GROUP BY `STATE`
ORDER BY RHC_State_Count DESC;

-- This is to find in which years the most number of RHCs were incorporated based on the year they were incorporated

SELECT 
    CASE 
        WHEN YEAR(STR_TO_DATE(`INCORPORATION DATE`, '%m/%d/%y')) > 2026 
        THEN YEAR(STR_TO_DATE(`INCORPORATION DATE`, '%m/%d/%y')) - 100
        ELSE YEAR(STR_TO_DATE(`INCORPORATION DATE`, '%m/%d/%y'))
    END AS Incop_Year,
    COUNT(*) AS RHC_Inc_Per_Year
FROM CMSData.CMS_RHC_Enrollments cre 
GROUP BY Incop_Year
ORDER BY Incop_Year DESC;

-- FQHC Information

-- Data Dictionary: https://data.cms.gov/sites/default/files/2025-10/6231c406-4523-4cc5-bed3-29cbe1c20d1e/FQHC_Enrollments_Data_Dictionary.pdf

-- This is for the "State of the FQHC’s practice location" (*This is the one that should be used in the blog post for the number of FQHCs in the state)

SELECT * FROM `FQHC_Enrollments_Q1_2026.01.21` feq 

SELECT 
    `STATE`, 
    COUNT(*) AS FQHC_State_Count
FROM `FQHC_Enrollments_Q1_2026.01.21` feq 
GROUP BY `STATE`
ORDER BY FQHC_State_Count DESC;

-- This is for the state in which the FQHC is enrolled

SELECT 
    `ENROLLMENT STATE`, 
    COUNT(*) AS FQHC_State_Count
FROM `FQHC_Enrollments_Q1_2026.01.21` feq 
GROUP BY `ENROLLMENT STATE`
ORDER BY FQHC_State_Count DESC;

-- This is to find in which years the most number of FQHCs were incorporated 

SELECT 
    CASE 
        WHEN YEAR(STR_TO_DATE(`INCORPORATION DATE`, '%m/%d/%Y')) > 2026 THEN NULL -- Future date error
        WHEN YEAR(STR_TO_DATE(`INCORPORATION DATE`, '%m/%d/%Y')) < 1960 THEN NULL -- Too old/historical error
        ELSE YEAR(STR_TO_DATE(`INCORPORATION DATE`, '%m/%d/%Y'))
    END AS Incop_Year,
    COUNT(*) AS FQHC_Inc_Per_Year
FROM `FQHC_Enrollments_Q1_2026.01.21` feq 
WHERE `INCORPORATION DATE` IS NOT NULL
GROUP BY Incop_Year
HAVING Incop_Year IS NOT NULL
ORDER BY Incop_Year ASC;

