--Stratascratch Problem 10284 : Popularity Percentage
--Difficulty : Hard
--Date Solved : 31/01/2026
/*
Problem Statement : 
Find the popularity percentage for each user on Meta/Facebook. The dataset contains two columns, user1 and user2, which represent pairs of friends. Each row indicates a mutual friendship between user1 and user2, meaning both users are friends with each other. A user's popularity percentage is calculated as the total number of friends they have (counting connections from both user1 and user2 columns) divided by the total number of unique users on the platform. Multiply this value by 100 to express it as a percentage.

Table : 
facebook_friends - contain user1, user2

Goal : 
Our goal is to calculate the popularity percentage of each user’s friends.

*/
-- Step-by-step approach :
-- Step 1: Use a CTE to normalize the friendship data by converting user1 and user2
--         into a single user column using UNION ALL. This creates a list of all
--         friend connections per user.
-- Step 2: Aggregate the normalized data to count the total number of friends
--         for each user using GROUP BY and COUNT(*).
-- Step 3: Calculate the total number of unique users on the platform by counting
--         distinct users from the normalized dataset.
-- Step 4: Join the per-user friend counts with the total user count using a
--         CROSS JOIN to make the total available for every row.
-- Step 5: Compute the popularity percentage by dividing each user’s friend count
--         by the total number of users and multiplying by 100.
-- Step 6: Order the final results by user ID in ascending order.

--Final Query
WITH name AS (
    SELECT user1 AS user FROM facebook_friends
    UNION ALL
    SELECT user2 AS user FROM facebook_friends
),
friends AS (
    SELECT 
        user,
        COUNT(*) AS friend_count
    FROM name
    GROUP BY user
),
total AS (
    SELECT 
        COUNT(DISTINCT user) AS unique_user
    FROM name
)
SELECT 
    f.user AS user_id,
    (f.friend_count * 100.0) / t.unique_user AS popularity_percent
FROM friends f
CROSS JOIN total t
ORDER BY user_id;

--Why This Works :
--• Ensures all friendships are counted symmetrically  
--• Separates user-level metrics from global metrics for clarity  
--• Uses CTEs for readability and maintainability 
