-- LeetCode Problem 1045: Customers Who Bought All Products
-- Difficulty: Medium
-- Date Solved: January 24, 2026

/* 
Problem Description:
Find all customers who have bought ALL products available in the Product table.

Table: Customer
- customer_id: ID of the customer
- product_key: ID of the product bought (can have duplicates)

Table: Product
- product_key: Unique product ID (primary key)

Goal: Return customer_id of customers who bought every single product
*/

-- My Approach:
-- 1. Join Customer and Product tables to get valid purchases
-- 2. Group by customer_id to count distinct products per customer
-- 3. Use HAVING to filter only customers whose product count matches total products
-- 4. Subquery counts total unique products available

-- Solution:
SELECT c.customer_id 
FROM Customer c
JOIN Product p ON c.product_key = p.product_key
GROUP BY c.customer_id
HAVING COUNT(DISTINCT c.product_key) = (SELECT COUNT(*) FROM Product);

-- Key Learnings:
-- • JOIN ensures only valid product purchases are counted
-- • COUNT(DISTINCT) handles duplicate purchases by same customer
-- • HAVING clause filters aggregated results (used after GROUP BY)
-- • Subquery in HAVING dynamically gets total product count
-- • This is a "division" problem in relational algebra

-- Why DISTINCT is important:
-- If customer bought product A twice, COUNT(DISTINCT) counts it once only

-- Alternative approach (without JOIN):
-- Could use WHERE product_key IN (SELECT product_key FROM Product)
-- But JOIN is more readable and efficient

-- Time Complexity: O(n + m) where n = customers, m = products
-- Space Complexity: O(1) excluding output
