-- ================================================
-- LeetCode #570: Managers with at Least 5 Direct Reports
-- Difficulty: Medium
-- Link: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/
-- Author: Waseeque Ahmad
-- Date: January 14, 2025
-- ================================================

/*
PROBLEM DESCRIPTION:
Write a solution to find managers with at least five direct reports.

Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+

id is the primary key (column with unique values) for this table.
Each row indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.

Output: Names of managers with at least 5 direct reports
*/

-- -----------------------------------------------
-- SOLUTION
-- -----------------------------------------------

SELECT e.name 
FROM Employee e
JOIN Employee r ON e.id = r.managerId 
GROUP BY e.id, e.name
HAVING COUNT(r.id) >= 5;

-- -----------------------------------------------
-- EXPLANATION
-- -----------------------------------------------
/*
Approach: Self Join with GROUP BY and HAVING

1. Self Join on Employee table
   - e (left side): Potential managers
   - r (right side): Their reports (employees)
   - Join condition: e.id = r.managerId (links manager to their reports)

2. GROUP BY e.id, e.name
   - Groups all reports under each manager
   - e.id included to avoid ambiguity with duplicate names
   - e.name needed for final output

3. HAVING COUNT(r.id) >= 5
   - Filters groups after aggregation
   - Only keeps managers with 5 or more direct reports
   - COUNT(r.id) counts number of reports per manager

Key Concept: Self Join
- Table joins with itself
- Different aliases (e, r) represent different roles
- Useful for hierarchical data (manager-employee relationships)

Why HAVING instead of WHERE?
- WHERE filters BEFORE grouping
- HAVING filters AFTER grouping/aggregation
- COUNT() is an aggregate function, so HAVING is required

Time Complexity: O(n²) for join operation
Space Complexity: O(n) for result set
*/

-- -----------------------------------------------
-- Status: ✅ Accepted
-- -----------------------------------------------
