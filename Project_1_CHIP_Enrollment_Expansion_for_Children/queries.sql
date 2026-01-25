# I performed the following SQL queries on a data set called "State Medicaid and CHIP Applications, Eligibility Determinations, and Enrollment Data" that can be found at https://data.medicaid.gov/dataset/6165f45b-ca93-5bb5-9d06-db29c692a360  
# I incorporated my data analysis into a blog post about Medicaid CHIP enrollment trends that can be found at hhttps://dragontreecomms.com/childrens-health-insurance-program-faces-headwinds 
# Obtained a snapshot count of the number of children enrolled in Medicaid and the number of individuals enrolled in CHIP as of the last day of each month.
# This data and explanation are courtesy of Data.Medicaid.gov
# I looked only at the following states and created a chart in the blog post to display the numbers: Colorado, Kansas, Arizona, Maine, and North Dakota 

SELECT 
    pdsfj.`State Abbreviation` AS State,
    SUM(pdsfj.MCCHIPChildEnr) AS TotalEnrollments_2022_2025
FROM CMSData.pi_dataset_september25_for_June25 pdsfj
WHERE 
    pdsfj.`State Abbreviation` IN ('AZ', 'ME', 'ND', 'KS', 'CO')
    AND (
        pdsfj.`ReportDateReformat` LIKE '%/22'
        OR pdsfj.`ReportDateReformat` LIKE '%/23'
        OR pdsfj.`ReportDateReformat` LIKE '%/24'
        OR pdsfj.`ReportDateReformat` LIKE '%/25'
    )
GROUP BY 
    pdsfj.`State Abbreviation`
ORDER BY 
    TotalEnrollments_2022_2025 DESC;

# To create the graphs in R Studio, I captured the data for each of the states listed above using SQL queries

SELECT * FROM CMSData.pi_dataset_september25_for_June25 pdsfj 
WHERE `State Abbreviation` = 'AZ'

SELECT * FROM CMSData.pi_dataset_september25_for_June25 pdsfj 
WHERE `State Abbreviation` = 'ME'

SELECT * FROM CMSData.pi_dataset_september25_for_June25 pdsfj 
WHERE `State Abbreviation` = 'ND'

SELECT * FROM CMSData.pi_dataset_september25_for_June25 pdsfj 
WHERE `State Abbreviation` = 'KS'

SELECT * FROM CMSData.pi_dataset_september25_for_June25 pdsfj 
WHERE `State Abbreviation` = 'CO'

