-- LeetCode Problem 1070: Product Sales Analysis III
-- Difficulty: Medium
-- Date Solved: 26/01/2026

/* 
Problem Statement:
Find all sales that occurred in the first year each product was sold.
For each product, identify the earliest year and return all sales from that year.

Tables:
Sales - Contains sale_id, product_id, year, quantity, price
(sale_id, year) is composite primary key
A product can have multiple sales in the same year

Goal:
Return product_id, first_year, quantity, price for all sales 
that occurred in each product's first year
*/

-- My Understanding:
-- Need to find the minimum year for each product (first sale year)
-- Then fetch all sales entries for that product in that specific year

-- Step-by-step approach:
-- Step 1: Use subquery to find MIN(year) for each product_id
-- Step 2: JOIN this result back to the original Sales table
-- Step 3: Match on both product_id AND year to get correct entries
-- Step 4: Select required columns (product_id, first_year, quantity, price)

-- First attempt:
-- SELECT product_id, MIN(year), quantity, price FROM Sales GROUP BY product_id;
-- Issue: Can't select quantity and price with GROUP BY - aggregate function error
-- Also, which quantity/price to pick if multiple sales in first year?
-- Fix: Used subquery + JOIN approach to get all matching rows properly

-- Final Solution:
SELECT 
    s.product_id,
    f.first_year,
    s.quantity,
    s.price
FROM Sales s
JOIN ( 
    SELECT 
        product_id, 
        MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
) AS f ON s.product_id = f.product_id
       AND s.year = f.first_year;

-- Why this works:
-- • Subquery identifies the earliest year for each product using MIN()
-- • GROUP BY ensures we get one first_year per product_id
-- • JOIN connects back to original table using TWO conditions (product_id AND year)
-- • This fetches ALL sales entries that match both product and its first year
-- • If a product had multiple sales in first year, all will be returned

-- What I learned today:
-- Cannot mix aggregate functions (MIN) with non-aggregated columns (quantity, price)
-- Subquery + JOIN is cleaner than using window functions for this case
-- Multiple conditions in JOIN (using AND) helps filter precisely

-- Alternative approach considered:
-- Could use window function: RANK() OVER (PARTITION BY product_id ORDER BY year)
-- But subquery approach is more readable and efficient here


-- Time taken: 10 minutes (understood problem in 3 mins, coded in 7 mins)

---
