---Statascratch Prolem 10285 : Acceptance rate by date
---Difficulty : Medium
---Date Solved : 30/01/2026
/*
Problem Statement: 
Calculate the friend acceptance rate for each date when friend requests were sent. A request is sent if action = sent and accepted if action = accepted. If a request is not accepted, there is no record of it being accepted in the table.
Table:
 fb_friend_request - Contain  action, date, user_id_receiver, user_id_sender
Goal: 
For each date, calculate how many friend requests were accepted compared to how many were sent.
*/
-- My Understanding:
-- We want to calculate the acceptance rate of friend requests per date.
--Step by step approach: 
-- Step 1: Split the data into two sets – one for 'accepted' requests (CTE a) 
--         and one for 'sent' requests (CTE b).
-- Step 2: Join both sets on sender and receiver IDs so that each sent request 
--         can be matched with its accepted request (if it exists).
-- Step 3: Group the results by date and calculate the ratio of accepted requests 
--         to sent requests for each date.

-- Final Query:
WITH A AS (
    SELECT * 
    FROM fb_friend_requests 
    WHERE action = 'accepted'
),
B AS (
    SELECT * 
    FROM fb_friend_requests 
    WHERE action = 'sent'
)
SELECT 
    B.date,
    COUNT(A.user_id_receiver) / COUNT(B.user_id_sender) AS acceptance_ratio
FROM A
RIGHT JOIN B 
    ON A.user_id_sender = B.user_id_sender
   AND A.user_id_receiver = B.user_id_receiver
GROUP BY B.date;

-- Why this works:
-- • CTEs separate 'accepted' and 'sent' requests, making the logic clearer.
-- • RIGHT JOIN ensures all sent requests are included, even if they were not accepted.
-- • Grouping by date allows us to calculate results for each day separately.
-- • Dividing COUNT(accepted) by COUNT(sent) gives the daily acceptance ratio.
