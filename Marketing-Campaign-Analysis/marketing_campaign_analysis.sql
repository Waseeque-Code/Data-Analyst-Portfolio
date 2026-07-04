CREATE DATABASE IF NOT EXISTS marketing_campaign;
USE marketing_campaign;

CREATE TABLE campaigns (
	Campaign_ID       INT,
    Company           VARCHAR(255),
    Campaign_Type     VARCHAR(100),
    Target_Audience   VARCHAR(100),
    Duration          INT,
    Channel_Used      VARCHAR(100),
    Conversion_Rate   DECIMAL(10, 4),
    Acquisition_Cost  DECIMAL(10, 2),
    ROI               DECIMAL(10, 4),
    Location          VARCHAR(100),
    Language          VARCHAR(100),
    Clicks            INT,
    Impressions       INT,
    Engagement_Score  INT,
    Customer_Segment  VARCHAR(100),
    Date              DATE,
    Year              INT,
    Month             INT
);

SET GLOBAL LOCAL_INFILE = 1;
LOAD DATA LOCAL INFILE "C:/Data Analyst/Data Analyst Portfolio/Marketing Campaign Project 3/marketing_campaign_cleaned.csv"
INTO TABLE campaigns
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM campaigns;
SELECT * FROM campaigns
LIMIT 10;

-- Q1. What is the total number of campaigns, total clicks, and total impressions?
SELECT 
	COUNT(Campaign_ID) AS total_campaigns,
	SUM(Clicks) AS total_clicks,
    SUM(Impressions) AS total_impressions
FROM campaigns;
/*The query returned 200,000 total campaigns, 109,954,406 total clicks, and 1,101,460,304 
 total impressions.*/

-- Q2. Which campaign type has the highest number of campaigns?
SELECT 
	Campaign_Type,
    COUNT(Campaign_Type) AS Total_campaigns
FROM campaigns
GROUP BY Campaign_Type;

/*Influencer has the highest number of campaigns with 40,169, closely followed by Search with 40,157.
Social Media has the lowest with 39,817, while Email and Display have 39,870 and 39,987 respectively.
The distribution is fairly balanced across all five campaign types, with only a ~0.88% difference between the highest
 (Influencer) and lowest (Social Media). */

-- Q3. Which channel is used most frequently?
SELECT 
	Channel_Used,
    COUNT(*) AS Total_Channel
FROM campaigns
GROUP BY Channel_Used
ORDER BY Total_Channel DESC;

/*Email is the most frequently used channel with 33,599 campaigns, closely followed by Google Ads with 33,438.
YouTube and Instagram are tied at 33,392 each, while Website has 33,360.
Facebook is the least used channel with 32,819 campaigns.*/

-- Q4. Which location has the most campaigns?
SELECT
	Location,
    COUNT(Campaign_ID) AS Total_campaigns
FROM campaigns
GROUP BY Location
ORDER BY Total_campaigns DESC;

/*Miami has the highest number of campaigns with 40,269, followed closely by New York with 40,024.
Chicago and Los Angeles have 40,010 and 39,947 campaigns respectively.
Houston has the lowest with 39,750 campaigns.*/

-- Q5. What are the top 10 companies by average ROI?
SELECT 
	Company,
    AVG(ROI) AS Avg_ROI
FROM campaigns
GROUP BY Company
ORDER BY Avg_ROI DESC;

/*TechCorp has the highest average ROI at 5.01, closely followed by Alpha Innovations at 5.006.
DataTech Solutions and Innovate Industries have very similar averages at 5.006 and 5.002 respectively.
NexGen Systems has the lowest average ROI at 4.99.*/

-- Q6. Which campaign type has the highest average conversion rate?
SELECT
	Campaign_Type,
    AVG(Conversion_Rate) AS Avg_conversion_rate
FROM campaigns
GROUP BY Campaign_Type
ORDER BY Avg_conversion_rate DESC;

/*Influencer has the highest average conversion rate at 0.0803 (8.03%), closely followed by Social Media at 0.0801 (8.01%).
Email has the lowest average conversion rate at 0.0798 (7.98%).
All campaign types have very similar conversion rates, with only a ~0.06% difference between the highest and lowest.*/

-- Q7. Which channel gives the best average ROI?
SELECT
	Channel_Used,
    AVG(ROI) AS Avg_ROI
FROM campaigns
GROUP BY Channel_Used
ORDER BY Avg_ROI DESC;

/*Facebook gives the best average ROI at 5.02, followed very closely by Website at 5.01.
Google Ads, Email, and YouTube are in the middle range with ROIs between 4.99 - 5.00.
Instagram has the lowest average ROI at 4.99.*/

-- Q8. What is the month-wise campaign and clicks trend?
SELECT
	Month,
    COUNT(Campaign_ID) AS Total_campaign,
    SUM(Clicks) AS Total_Clicks
FROM campaigns
GROUP BY Month
ORDER BY Month;

/*Months with 16,988 campaigns (Jan, Mar, May, Jul, Aug, Oct) have higher clicks (~9.34–9.38 million), while months with 16,440 campaigns (Apr, Jun, Sep, Nov) have slightly lower clicks (~8.99–9.07 million).
October has the highest clicks at 9,384,834, followed closely by March at 9,367,374.
February has the lowest clicks at 8,433,037, which is also one of the months with fewer campaigns (15,344).
Click volume generally follows campaign volume, with months having more campaigns generating more clicks.
There is a slight upward trend in clicks from February to October, with a small dip in December.*/

-- Q9. Which customer segment is most frequently targeted?
SELECT 
	Customer_Segment,
    COUNT(Campaign_ID) AS Total_campaign
FROM campaigns
GROUP BY Customer_Segment
ORDER BY Total_campaign DESC;

/*Foodies is the most frequently targeted segment with 40,208 campaigns.
Tech Enthusiasts follows closely with 40,151 campaigns.
Outdoor Adventurers has 40,011 campaigns.
Health & Wellness has 39,888 campaigns.
Fashionistas is the least targeted with 39,742 campaigns.*/

-- Q10. Categorize campaigns as High, Medium, Low based on acquisition cost
SELECT
	CASE 
		WHEN Acquisition_Cost < 5000 THEN 'Low'
        WHEN Acquisition_Cost BETWEEN 5000 AND 10000 THEN 'Medium'
        ELSE 'High'
        END AS Cost_Category,
        COUNT(Campaign_ID) AS Total_campaigns
FROM campaigns
GROUP BY Cost_Category
ORDER BY Total_campaigns DESC;

/*High acquisition cost campaigns are the most common with 133,296 campaigns (~66.6% of total).
Medium acquisition cost campaigns have 66,704 campaigns (~33.4% of total).
Low acquisition cost campaigns have 0 campaigns, meaning no campaign had an acquisition cost below 5,000.*/

-- Q11. Which channel performs best in each campaign type? 
WITH Channel_Performance AS (
    SELECT 
        Channel_Used,
        Campaign_Type,
        AVG(ROI) AS Avg_ROI
    FROM campaigns
    GROUP BY Channel_Used, Campaign_Type
),
Rank_Channels AS (
    SELECT 
        Channel_Used,
        Campaign_Type,
        Avg_ROI,
        RANK() OVER(PARTITION BY Campaign_Type ORDER BY Avg_ROI DESC) AS rn
    FROM Channel_Performance
)
SELECT 
    Campaign_Type,
    Channel_Used AS Best_Channel,
    Avg_ROI
FROM Rank_Channels
WHERE rn = 1
ORDER BY Avg_ROI DESC;

/*Facebook is the best-performing channel for 4 out of 5 campaign types (Search, Influencer, Social Media, and Email), 
making it the most consistently high-performing channel overall.
Email is the best channel for Display campaigns with an average ROI of 5.03.
Search + Facebook has the highest overall average ROI at 5.033, closely followed by Display + Email at 5.031.*/

-- Q12. What is each location's percentage contribution to total clicks? 
SELECT 
	Location,
    SUM(Clicks) AS Total_clicks,
    ROUND(SUM(Clicks) * 100.0 / SUM(SUM(Clicks)) OVER(), 2) AS Percentage_Contribution
FROM campaigns
GROUP BY Location
ORDER BY Percentage_Contribution DESC;

/*New York contributes the highest share of total clicks at 20.06%, followed very closely by Miami also at 20.06%.
Chicago contributes 19.99%, Los Angeles contributes 19.98%, and Houston contributes the lowest at 19.91%.*/

-- Q13. Which campaign type gets the best ROI per customer segment?
SELECT 
	Customer_Segment,
    Campaign_Type,
    Avg_ROI
FROM ( 
	SELECT 
		Customer_Segment,
        Campaign_Type,
        AVG(ROI) AS Avg_ROI
	FROM campaigns
    GROUP BY Customer_Segment, Campaign_Type
) t1
WHERE (Customer_Segment, Avg_ROI) IN (
	SELECT
		Customer_Segment,
        MAX(Avg_ROI) AS Max_ROI
	FROM (
		SELECT 
			Customer_Segment,
            Campaign_Type,
            AVG(ROI) AS Avg_ROI
		FROM campaigns
        GROUP BY Customer_Segment, Campaign_Type
	) t2
    GROUP BY Customer_Segment
)
ORDER BY Customer_Segment;

/*Tech Enthusiasts respond best to Influencer campaigns with the highest average ROI of 5.03.
Health & Wellness responds best to Search campaigns with a very similar ROI of 5.03.
Foodies and Outdoor Adventurers both perform best with Display campaigns.
Fashionistas respond best to Email campaigns.*/

-- Q14. What is the month-wise average conversion rate trend?
WITH Monthly_Trend AS (
    SELECT
        Month,
        AVG(Conversion_Rate) * 100.0 AS Avg_Conversion_Rate
    FROM campaigns
    GROUP BY Month
)
SELECT * FROM Monthly_Trend
ORDER BY Month;
/*April has the highest conversion rate at 8.05%, while August has the lowest at 7.97%.
The trend is very stable throughout the year, with all months staying within a tight range of 7.97% to 8.05%.*/

-- Q15. Which company has the highest average engagement score per channel?
WITH Channel_Engagement AS (
	SELECT 
		Company,
        Channel_Used,
        AVG(Engagement_Score) AS Avg_Engagement
	FROM campaigns
    GROUP BY Company, Channel_Used
),
Ranked_Companies AS (
SELECT
	Company,
    Channel_Used,
    Avg_Engagement,
    RANK() OVER(PARTITION BY Channel_Used ORDER BY Avg_Engagement DESC) AS rn
FROM Channel_Engagement
)
SELECT 
	Company,
    Channel_Used,
    Avg_Engagement
FROM Ranked_Companies
WHERE rn = 1;

/*TechCorp has the highest engagement on Website with an average score of 5.55.
NexGen Systems performs best on Facebook and ties with DataTech Solutions on Instagram.
Innovate Industries leads on Google Ads and YouTube.
Alpha Innovations leads on Email.*/






















