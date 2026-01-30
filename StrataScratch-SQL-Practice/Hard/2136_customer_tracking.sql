--Stratascratch Problem 2136 : Customer Tracking
--Difficulty : Hard
--Date Solved : 30/01/2026
/*
Problem Statement :
Given the users' sessions logs on a particular day, calculate how many hours each user was active that day.
Table :
cust_tracking - Contain cust_id, state, timestamp
Goal :
The goal of the analysis is to determine how many hours each person spent in state 1 before moving to state 0
*/
-- My Understanding:
-- The problem is to calculate how many hours each customer spent in state = 1 
-- before moving to state = 0.

-- Step-by-step approach:
-- Step 1: Use a CTE to assign ranks to each event per customer and state using RANK().
-- Step 2: Self-join the CTE so that state=1 rows can be paired with state=0 rows 
--         for the same customer and same rank.
-- Step 3: Calculate the time difference between timestamps of state=1 and state=0, 
--         convert it into hours, and sum it per customer.

-- First attempt (I made mistakes):
-- SELECT a1.cust_id, SUM(TIME_TO_SEC(TIMEDIFF(a2.timestamp, a1.timestamp)))/3600 hour_diff
-- FROM active a1
-- JOIN active a2 ON a1.cust_id, = a2.cust_id and a1.state != a2.state and a1.rnk = a2.rnk
-- WHERE a1.state = 1 and a2.state = 0
-- GROUP BY a1.cust_id;
-- Issue: Extra comma in JOIN condition and misplaced WHERE after GROUP BY.

-- Fix: Remove the comma in JOIN condition and place WHERE before GROUP BY.

-- Final Solution:
WITH active AS (
    SELECT *,
           RANK() OVER (PARTITION BY cust_id, state ORDER BY timestamp) rnk
    FROM cust_tracking
)
SELECT a1.cust_id,
       SUM(TIME_TO_SEC(TIMEDIFF(a2.timestamp, a1.timestamp)))/3600 AS hour_diff
FROM active a1
JOIN active a2 
     ON a1.cust_id = a2.cust_id 
    AND a1.state != a2.state 
    AND a1.rnk = a2.rnk
WHERE a1.state = 1 
  AND a2.state = 0
GROUP BY a1.cust_id;

-- Why this works:
-- • RANK() ensures we can pair the first occurrence of state=1 with the first occurrence of state=0, 
--   second with second, and so on.
-- • Self-join allows us to compare timestamps of state=1 and state=0 for the same customer.
-- • TIMEDIFF + TIME_TO_SEC converts the difference into seconds, and dividing by 3600 gives hours.
-- • SUM aggregates all such durations to get the total hours spent in state=1 before moving to state=0.

