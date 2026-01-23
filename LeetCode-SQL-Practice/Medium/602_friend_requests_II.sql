-- LeetCode Problem 602: Friend Requests II - Who Has the Most Friends
-- Difficulty: Medium
-- Date Solved: January 24, 2026

/* 
Problem Description:
Find the person who has the most friends and return their ID along with the count.
Each friendship is bidirectional (if A accepts B's request, both are friends).

Table: RequestAccepted
- requester_id: User who sent friend request
- accepter_id: User who accepted the request
- accept_date: Date when request was accepted
*/

-- My Approach:
-- 1. Need to count friendships from both directions (requester and accepter)
-- 2. Use UNION ALL to combine both perspectives
-- 3. Group by user ID and count total friends
-- 4. Order by count and get the top result

-- Solution:
SELECT id, COUNT(*) AS num
FROM (
    -- Get all friendships where this person was the requester
    SELECT requester_id AS id, accepter_id AS friend
    FROM RequestAccepted
    
    UNION ALL
    
    -- Get all friendships where this person was the accepter
    SELECT accepter_id AS id, requester_id AS friend
    FROM RequestAccepted
) AS AllFriendship
GROUP BY id
ORDER BY num DESC
LIMIT 1;

-- Key Learnings:
-- • UNION ALL combines results from both directions without removing duplicates
-- • Subquery creates a unified view of all friendships
-- • GROUP BY + COUNT aggregates total friends per person
-- • LIMIT 1 gets only the person with maximum friends

-- Time Complexity: O(n) where n is number of accepted requests
-- Space Complexity: O(n) for the subquery result
