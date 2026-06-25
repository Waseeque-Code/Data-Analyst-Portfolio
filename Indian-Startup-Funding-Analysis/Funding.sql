CREATE DATABASE IF NOT EXISTS startup_funding;
USE startup_funding;

CREATE TABLE funding (
    Date             DATE,
    StartupName      VARCHAR(255),
    IndustryVertical VARCHAR(255),
    SubVertical      VARCHAR(255),
    CityLocation     VARCHAR(255),
    InvestorsName    TEXT,
    InvestmentType   VARCHAR(100),
    AmountInUSD      DECIMAL(20, 2),
    Year             INT,
    Month            INT
);
SET GLOBAL LOCAL_INFILE = 1;
LOAD DATA LOCAL INFILE 'C:/Data Analyst/Data Analyst Portfolio/Indian startup funding analysis project 1/startup_funding_cleanedd.csv'
INTO TABLE funding
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM funding;
SELECT * FROM funding LIMIT 5;

-- Q1. How many startups were funded in total and what was the total funding amount?
SELECT 
	COUNT(DISTINCT StartupName) AS Total_startups,
    SUM(AmountInUSD) AS Total_funding_amount
FROM funding;

/*The query returned 1 row showing that 1,921 unique startups received $18.35 billion
 in total funding.*/ 

-- Q2. Which city had the most startup deals?
SELECT 
	CityLocation,
    COUNT(DISTINCT StartupName) AS Total_startups
FROM funding
GROUP BY CityLocation
ORDER BY Total_startups DESC;

/*Bengaluru has the most startup deals with 502 startups, followed by Mumbai with 377, 
New Delhi with 335, and Gurgaon with 193. This shows Bengaluru is the startup capital of India.*/

-- Q3. Which industry received the most number of deals?
SELECT 
	IndustryVertical,
    COUNT(DISTINCT StartupName) AS Total_deals
FROM funding
GROUP BY IndustryVertical
ORDER BY Total_deals DESC;

/*Consumer Internet has the most startup deals with 811 startups, followed by Other with 466, and Technology with 388. This shows that consumer-focused internet
 startups dominate the Indian startup ecosystem.*/

-- Q4. What is the most common investment type?
SELECT 
	InvestmentType,
    COUNT(*) 
FROM funding
GROUP BY InvestmentType 
ORDER BY COUNT(*) DESC;

/*Over 90% of deals are either Seed Funding or Private Equity. Other investment types like Crowd Funding, Debt Funding are very rare.*/

-- Q5. Who are the top 10 most funded startups?
SELECT
	StartupName,
    SUM(AmountInUSD) AS Total_funding
FROM funding
GROUP BY StartupName
ORDER BY Total_funding DESC
LIMIT 10;

/*Flipkart is the most funded startup with $2.26 Billion, followed by Paytm with $2.14 Billion and Ola with $1.9 Billion. 
The top 3 alone account for over $6 Billion in funding.*/

-- Q6. What was the year-wise funding trend — which year was the best for Indian startups?
SELECT 
    Year,
    SUM(AmountInUSD) AS Total_funding,
    COUNT(DISTINCT StartupName) AS Total_startups
FROM funding
GROUP BY Year
ORDER BY Year;

/*2017 was the best year for startups with Flipkart receiving $1.5 Billion**, followed by 2015 with Ola receiving **$1.15 Billion, 
and 2016 with Snapdeal receiving $200 Million. This shows 2015 and 2017 were the peak years for Indian startup funding, with a dip in 2016.*/

-- Q7. What is the total and average funding per city?
SELECT
	CityLocation,
    SUM(AmountInUSD) AS Total_funding,
    ROUND(AVG(AmountInUSD), 2) AS Avg_funding
FROM funding
GROUP BY CityLocation;

/*Bangalore leads with $8.43 Billion** in total funding and an average of **$13.2 Million per startup. New Delhi and Mumbai follow with 
$2.82 Billion** and **$2.35 Billion respectively. The top 3 cities alone account for about 70% of all funding, showing that Indian startup 
activity is highly concentrated in major metros.*/

-- Q8. Which industry received the highest total funding amount?
SELECT
	IndustryVertical,
    SUM(AmountInUSD) AS Total_funding
FROM funding
GROUP BY IndustryVertical
ORDER BY Total_funding DESC
LIMIT 1;

/*Consumer Internet received the highest total funding with $5.99 Billion. This makes sense because Consumer Internet includes food delivery, eCommerce, mobility, and other consumer-facing startups — 
which are the backbone of India's startup ecosystem.*/

-- Q9. Which month sees the most startup deals?
SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month_Number,
    MONTHNAME(Date) AS Month_Name,
    COUNT(*) AS Total_deals
FROM funding
GROUP BY YEAR(Date), MONTH(Date), MONTHNAME(Date)
ORDER BY Year, Month_Number;
    
/*January 2016 was the most active month with 104 deals, followed by February 2016 with 100 deals. In 2015, July and August were the busiest months
 with 98 deals each. Overall, 2016 had the highest monthly activity, while 2017 showed a significant drop, especially in August with only 5 deals.*/

-- Q10. Categorize startups as Small, Medium, and Large based on funding amount
SELECT
    StartupName,
    AmountInUSD,
    CASE
        WHEN AmountInUSD <= 1000000 THEN 'Small'
        WHEN AmountInUSD <= 10000000 THEN 'Medium'
        ELSE 'Large'
    END AS Startup_Category
FROM funding;

-- Q11. Which industry was the top funded in each year? 
WITH Y AS (
	SELECT
		Year,
        IndustryVertical,
        SUM(AmountInUSD) AS total_funding,
        ROW_NUMBER() OVER(PARTITION BY Year ORDER BY SUM(AmountInUSD) DESC) AS rn
	FROM funding
    GROUP BY Year, IndustryVertical
)
SELECT 
	Year,
    IndustryVertical
FROM Y
WHERE rn = 1
ORDER BY Year;

/*The top-funded industry changed each year. In 2015, 'Other' industries led (mostly missing data). In 2016, Consumer Internet took the top spot. In 2017, 
eCommerce became the highest-funded industry. This shows how investor focus shifted from general industries to consumer internet and finally to eCommerce.*/

-- Q12. What is each city's percentage contribution to total funding?
WITH CityTotals AS (
	SELECT
		CityLocation,
        SUM(AmountInUSD) AS City_Funding
	FROM funding
    GROUP BY CityLocation
),
OverallTotal AS (
	SELECT
		SUM(AmountInUSD) AS Total_Funding
	FROM funding
)
SELECT 
	CityLocation,
    City_Funding,
    ROUND((City_Funding / (SELECT Total_Funding FROM OverallTotal)) * 100, 2) AS Percentage_Contribution
FROM CityTotals
ORDER BY Percentage_Contribution DESC;

/*Bangalore contributes 45.92% of total funding, making it the undisputed startup capital of India. New Delhi follows with 15.36% and Mumbai with
 12.84%. The top 3 cities together account for over 74% of all funding, showing that the Indian startup ecosystem is heavily concentrated in
 major metro cities.*/

-- Q13. Which startup received the highest funding in each industry?
SELECT 
    StartupName,
    IndustryVertical,
    SUM(AmountInUSD) AS Total_funding
FROM funding
GROUP BY StartupName, IndustryVertical
HAVING (IndustryVertical, SUM(AmountInUSD)) IN (
    SELECT 
        IndustryVertical,
        MAX(Total_funding)
    FROM (
        SELECT 
            IndustryVertical,
            SUM(AmountInUSD) AS Total_funding
        FROM funding
        GROUP BY StartupName, IndustryVertical
    ) AS IndustryMax
    GROUP BY IndustryVertical
)
ORDER BY Total_funding DESC;

/*Using a subquery, I found the top startup in each industry. Flipkart leads eCommerce with $2.26 Billion**, **Paytm** leads Fintech with **$2.14 Billion,
 and Ola leads Consumer Internet with *$1.9 Billion**. These three startups alone account for over $6 Billion in funding."*/

-- Q14. Which investors have invested in the most number of different industries?
SELECT 
	InvestorsName,
    COUNT(DISTINCT IndustryVertical) AS Unique_Industries
FROM funding
WHERE InvestorsName NOT LIKE '%Undisclosed%'
AND InvestorsName != 'Not Disclosed'
GROUP BY InvestorsName
ORDER BY Unique_Industries DESC
LIMIT 10;

/*I found that Indian Angel Network and Ratan Tata have invested in the most number of different industries — 6 industries each. They are followed by Sequoia Capital and Tiger Global with 5 industries each.
 This shows that top investors have a diversified portfolio across multiple sectors.*/

-- Q15. Year-wise average deal size comparison between Seed Funding vs Private Equity?
SELECT 
	Year,
    InvestmentType,
    ROUND(AVG(AmountInUSD), 2) AS Avg_deal_size
FROM funding
WHERE InvestmentType IN ('Seed Funding', 'Private Equity')
GROUP BY Year, InvestmentType
ORDER BY Year, InvestmentType;

/*I compared average deal sizes between Seed Funding and Private Equity across years. Private Equity deals are significantly larger than Seed Funding deals every year. In 2017, the average
 Private Equity deal was $25.6 Million**, while Seed Funding averaged only **$0.23 Million — that's 113 times larger. This shows how startup funding grows as companies mature.*/















