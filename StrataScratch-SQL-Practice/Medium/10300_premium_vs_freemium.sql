--Stratascratch Problem 10300 : Premium vs Freemium
--Difficulty : Medium
--Date Solved : 20-02-2026

/*
Problem Statement :
Find the total number of downloads for paying and non-paying users by date.
Include only the records where non-paying customers have more downloads than paying customers.
The final output should be sorted by earliest date first and contain 3 columns:
date, non-paying downloads, paying downloads.

Note: In Oracle, use "date" (double quotes) because it is a reserved keyword.

Tables :
ms_user_dimension
ms_acc_dimension
ms_download_facts

Goal :
To calculate total downloads for paying and non-paying users per date,
then filter only those dates where non-paying downloads exceed paying downloads.
*/

--Step-by-step approach :

--Step 1: Join all three tables.
--We join ms_user_dimension with ms_acc_dimension using acc_id,
--and ms_user_dimension with ms_download_facts using user_id.
--This connects users, their account type (paying/non-paying), and downloads.

--Step 2: Use CASE statement inside SUM().
--We separate total downloads into two columns:
--• paying downloads
--• non-paying downloads
--based on the paying_customer flag.

--Step 3: Group the data by date.
--This ensures totals are calculated per day.

--Step 4: Use a CTE (Common Table Expression).
--Store aggregated results first, then filter only those
--where non-paying downloads are greater than paying downloads.

--Final Query :

WITH download_totals AS (
    SELECT
        c.date AS download_date,
        SUM(CASE 
                WHEN b.paying_customer = 'yes' THEN c.downloads 
                ELSE 0 
            END) AS paying,
        SUM(CASE 
                WHEN b.paying_customer = 'no' THEN c.downloads 
                ELSE 0 
            END) AS non_paying
    FROM ms_user_dimension a
    INNER JOIN ms_acc_dimension b 
        ON a.acc_id = b.acc_id
    INNER JOIN ms_download_facts c 
        ON a.user_id = c.user_id
    GROUP BY c.date
)

SELECT
    download_date,
    non_paying,
    paying
FROM download_totals
WHERE non_paying > paying
ORDER BY download_date ASC;

--Why this works :
--The CASE + SUM logic cleanly separates paying and non-paying downloads in a single aggregation.
--Using a CTE improves readability and keeps filtering logic separate from aggregation.
--The WHERE condition ensures only dates where non-paying downloads exceed paying downloads are shown.
--ORDER BY ensures results are displayed chronologically as required.
