-- StrataScratch Problem 9917: Average Salaries
-- Difficulty: Easy
-- Date Solved: 26/01/2026

/* 
Problem Statement:
Compare each employee's salary with their department's average salary.
Display department, employee name, individual salary, and department average.

Table:
employee - Contains id, first_name, last_name, department, salary, and other fields

Goal:
Output department, first_name, salary, and average salary of that department
for all employees
*/

-- My Understanding:
-- Need to show each employee's info alongside their department's avg salary
-- Department average should be same for all employees in that department
-- Every employee row should appear in output

-- Step-by-step approach:
-- Step 1: Calculate average salary per department
-- Step 2: Display each employee with their department's average
-- Step 3: Window function is perfect - no need to GROUP BY collapse rows

-- First attempt:
-- WITH dept_avg AS (
--     SELECT 
--         department,
--         first_name,
--         salary,
--         AVG(salary) AS avg_salary
--     FROM employee
--     GROUP BY department
-- )
-- Issue: Can't GROUP BY department and also include first_name, salary
-- GROUP BY collapses rows - we'd lose individual employee details
-- Fix: Use window function instead - keeps all rows intact

-- Final Solution:
SELECT 
    department,
    first_name,
    salary,
    AVG(salary) OVER (PARTITION BY department) AS avg_salary
FROM employee;

-- Why this works:
-- • Window function AVG() OVER calculates average without collapsing rows
-- • PARTITION BY department creates separate calculation for each department
-- • Each employee row is preserved with their individual details
-- • Department average is repeated for all employees in that department
-- • No GROUP BY needed - window functions work on full result set

-- What I learned today:
-- Window functions (OVER clause) don't reduce rows like GROUP BY does
-- PARTITION BY is like "GROUP BY for window functions"
-- When you need row-level + aggregate data together, use window functions
-- GROUP BY would collapse rows and lose individual employee information

-- Window Function vs GROUP BY:
-- GROUP BY: Aggregates and collapses - one row per group
-- Window Function: Aggregates but keeps all rows - calculation per partition

-- Example output logic:
-- Sales dept has employees: John ($50k), Mary ($60k), Bob ($70k)
-- Avg = $60k
-- Output:
-- Sales, John, 50000, 60000
-- Sales, Mary, 60000, 60000
-- Sales, Bob, 70000, 60000

-- Why CTE approach failed:
-- CTE with GROUP BY department would give one row per department
-- Can't include first_name and salary in GROUP BY without wrong aggregation
-- Would need to JOIN back - unnecessary complexity

-- Alternative approaches considered:
-- 1. Subquery: SELECT ..., (SELECT AVG(salary) FROM employee e2 WHERE e2.dept = e1.dept)
--    Works but slower and less readable
-- 2. Self-join on department - overly complex for this simple requirement
-- 3. Window function - cleanest and most efficient ✓

-- Time taken: 10 minutes (initially confused about GROUP BY vs window functions)
```
