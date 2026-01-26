-- StrataScratch Problem 10304: Risky Projects
-- Difficulty: Medium
-- Date Solved: 26/01/2026

/* 
Problem Statement:
Identify overbudget projects by calculating prorated employee costs.
A project is overbudget if total prorated employee salaries exceed the project budget.

Tables:
linkedin_projects - id, title, budget, start_date, end_date
linkedin_emp_projects - emp_id, project_id (mapping table)
linkedin_employees - id, first_name, last_name, salary (annual)

Goal:
Return projects where prorated employee expenses > budget
Output: title, budget, prorated_employee_expenses (rounded up)
Assume 365 days/year, no leap years
*/

-- My Understanding:
-- Need to prorate each employee's annual salary based on project duration
-- If project runs 6 months (182 days), use (182/365) * annual_salary
-- Sum all employee costs for each project and compare with budget

-- Step-by-step approach:
-- Step 1: JOIN all three tables to connect projects with employees
-- Step 2: Calculate project duration using DATEDIFF(end_date, start_date)
-- Step 3: Sum all employee salaries assigned to each project
-- Step 4: Prorate: (duration/365) * total_salaries
-- Step 5: Use CEILING to round up to nearest dollar
-- Step 6: Filter using HAVING where prorated cost > budget

-- First attempt:
-- Tried calculating proration per employee first, then summing
-- Issue: Redundant calculation, same duration for all employees in a project
-- Fix: Calculate duration once, multiply by SUM(salary) - more efficient

-- Final Solution:
SELECT 
    a.title, 
    a.budget,
    CEILING(DATEDIFF(a.end_date, a.start_date) * SUM(c.salary) / 365) AS prorated_employee_expenses
FROM linkedin_projects a
INNER JOIN linkedin_emp_projects b ON a.id = b.project_id
INNER JOIN linkedin_employees c ON b.emp_id = c.id
GROUP BY 
    a.title,
    a.budget,
    a.end_date,
    a.start_date
HAVING CEILING(DATEDIFF(a.end_date, a.start_date) * SUM(c.salary) / 365) > a.budget
ORDER BY a.title ASC;

-- Why this works:
-- • INNER JOIN connects projects → mapping table → employees (3-table JOIN)
-- • DATEDIFF calculates exact project duration in days
-- • SUM(c.salary) adds all employee annual salaries for the project
-- • Formula: (days/365) * total_salaries gives prorated cost
-- • CEILING rounds up - even $0.01 over becomes $1 (conservative approach)
-- • GROUP BY project ensures one row per project with aggregated salary
-- • HAVING filters AFTER aggregation (WHERE can't be used with aggregates)
-- • Must include end_date and start_date in GROUP BY for MySQL compatibility

-- What I learned today:
-- HAVING is used after GROUP BY to filter aggregated results
-- CEILING always rounds up (vs ROUND which rounds nearest, FLOOR which rounds down)
-- Need to include all non-aggregated SELECT columns in GROUP BY
-- DATEDIFF returns days between two dates (end_date - start_date)
-- Proration formula: (actual_days / total_days_in_period) * full_amount

-- Why CEILING instead of ROUND:
-- Financial calculations often round up for safety/conservatism
-- If project costs $100.20, budget $100 - should flag as overbudget
-- CEILING ensures we don't underestimate expenses

-- Alternative approaches considered:
-- Could use subquery to calculate prorated costs, then filter in WHERE
-- But HAVING is cleaner and more efficient for this use case

-- Edge cases handled:
-- ✓ Projects with multiple employees (SUM aggregates correctly)
-- ✓ Projects with 0 employees (won't appear due to INNER JOIN)
-- ✓ Fractional dollar amounts (CEILING handles rounding)
-- ✓ Projects exactly at budget (> comparison excludes these)

-- Time taken: 30 minutes (understood proration logic, then coded the JOINs)
```

---
