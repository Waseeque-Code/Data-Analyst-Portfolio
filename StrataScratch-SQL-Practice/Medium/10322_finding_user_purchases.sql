-- StrataScratch Problem 10322: Finding User Purchases
-- Difficulty: Medium
-- Date Solved: 26/01/2026

/* 
Problem Statement:
Identify returning active users who made their second purchase within 
1 to 7 days after their first purchase.
Same-day purchases should be ignored.

Table:
amazon_transactions - Contains id, user_id, item, created_at, revenue

Goal:
Output a list of user_ids who made a second purchase 
between 1-7 days (inclusive) after their first purchase
*/

-- My Understanding:
-- Need to find users with at least 2 purchases on different dates
-- Calculate days between first and second purchase
-- Filter users where gap is 1-7 days (not same day, not more than 7)

-- Step-by-step approach:
-- Step 1: Get distinct purchase dates per user (remove same-day duplicates)
-- Step 2: Rank purchases by date for each user using ROW_NUMBER
-- Step 3: Extract first and second purchase dates for each user
-- Step 4: Calculate difference and filter for 1-7 day range
-- Step 5: Return qualifying user_ids

-- First attempt:
-- Tried using LAG() function to get previous purchase date
-- Issue: Complex to filter only first and second purchases
-- Also harder to calculate DATEDIFF with LAG approach
-- Fix: Used ROW_NUMBER with CASE statements for cleaner logic

-- Final Solution:
WITH daily AS (
    -- Step 1: Get unique purchase dates per user (ignore same-day duplicates)
    SELECT 
        DISTINCT user_id,
        DATE(created_at) AS purchase_date
    FROM amazon_transactions
),
ranked AS (
    -- Step 2: Rank purchases chronologically for each user
    SELECT 
        user_id,
        purchase_date,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY purchase_date) AS rn
    FROM daily
),
first_two AS (
    -- Step 3: Extract first and second purchase dates using CASE
    SELECT
        user_id,
        MAX(CASE WHEN rn = 1 THEN purchase_date END) AS first_date,
        MAX(CASE WHEN rn = 2 THEN purchase_date END) AS second_date
    FROM ranked
    WHERE rn <= 2  -- Only need first two purchases
    GROUP BY user_id
)
-- Step 4: Filter users with valid second purchase (1-7 days gap)
SELECT 
    user_id
FROM first_two
WHERE second_date IS NOT NULL  -- User must have at least 2 purchases
  AND DATEDIFF(second_date, first_date) BETWEEN 1 AND 7  -- 1-7 days gap
ORDER BY user_id;

-- Why this works:
-- • DISTINCT in daily CTE removes same-day duplicate purchases
-- • ROW_NUMBER assigns sequential ranks based on purchase date
-- • PARTITION BY user_id ensures ranking is per user, not global
-- • CASE statements pivot data - first_date gets rn=1, second_date gets rn=2
-- • MAX with GROUP BY collapses rows - each user gets one row with both dates
-- • DATEDIFF calculates exact day difference
-- • BETWEEN 1 AND 7 excludes same-day (0) and beyond 7 days

-- What I learned today:
-- Using multiple CTEs makes complex queries more readable
-- CASE with MAX is useful for pivoting ranked data
-- ROW_NUMBER is better than RANK when you need exact sequential positions
-- DISTINCT DATE() is important to handle multiple transactions on same day

-- Alternative approaches considered:
-- 1. Self-join on user_id with date conditions - but harder to limit to "first two"
-- 2. LAG() window function - but filtering specific purchases becomes complex
-- 3. Subquery with LIMIT 2 per user - MySQL doesn't support that easily

-- Edge cases handled:
-- ✓ Users with only 1 purchase (filtered by second_date IS NOT NULL)
-- ✓ Same-day purchases (removed by DISTINCT DATE)
-- ✓ Users with 0-day gap (filtered by BETWEEN 1 AND 7)
-- ✓ Users with >7 day gap (filtered by BETWEEN 1 AND 7)

-- Time taken: 35 minutes (understood CTEs concept, then implemented step by step)
```

---
