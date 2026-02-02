--Stratascratch Problem 10134 : Spam Posts
--Difficulty : Medium
--Date Solved : 02-02-2026
/*
Problem Statement :
Calculate the percentage of spam posts in all viewed posts by day. A post is considered a spam if a string "spam" is inside keywords of the post. Note that the facebook_posts table stores all posts posted by users. The facebook_post_views table is an action table denoting if a user has viewed a post.

Table :
facebook_posts, facebook_posts_views

Goal :
To calculate, for each day, the percentage of viewed posts that are spam. A post is considered spam if the word "spam" appears in its keywords.

*/
--Step-by-step approach :
--Step 1: Use a CASE expression with the LIKE operator to identify posts that contain the word "spam" in their keywords. Count these spam posts among the viewed posts.
--Step 2: Calculate the total number of viewed posts for each day. Then divide the number of spam posts by the total viewed posts to get the spam percentage.
--Step 3:Join the facebook_posts table with the facebook_post_views table on post_id so that you can connect views with their keywords. Finally, group the results by the view date and order them chronologically.

--Final Query:

SELECT 
    v.post_date,
    100.0 * SUM(CASE 
                    WHEN post_keywords LIKE '%spam%' THEN 1 
                    ELSE 0 
                END) / COUNT(*) AS spam_share
FROM facebook_posts v
JOIN facebook_post_views p 
    ON v.post_id = p.post_id
GROUP BY v.post_date
ORDER BY v.post_date;

--Why this work:
--The CASE + LIKE combination smartly flags spam posts, and SUM counts them without needing a separate filter query.
--Dividing spam counts by total views (COUNT(*)) directly gives the spam share, making the query concise and efficient.
--Using GROUP BY post_date ensures the spam percentage is calculated per day, giving clear, time‑based insights.
