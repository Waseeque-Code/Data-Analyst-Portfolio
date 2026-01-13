-- ================================================
-- LeetCode #184: Department Highest Salary
-- Difficulty: Medium
-- Link: https://leetcode.com/problems/department-highest-salary/
-- Author: Waseeque Ahmad
-- Date: January 14, 2025
-- ================================================

/*
PROBLEM DESCRIPTION:
Find employees who have the highest salary in each department.

Table: Employee
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
| salary        | int     |
| departmentId  | int     |
+---------------+---------+

Table: Department
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+

Output: Department name, Employee name, Salary (highest in each dept)
*/

-- -----------------------------------------------
-- SOLUTION
-- -----------------------------------------------

SELECT 
    d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e
JOIN Department d ON e.departmentId = d.id
WHERE e.salary = (
    SELECT MAX(salary) 
    FROM Employee
    WHERE departmentId = e.departmentId
);

-- -----------------------------------------------
-- EXPLANATION
-- -----------------------------------------------
/*
Approach: Correlated Subquery

1. JOIN Employee with Department tables
   - Links departmentId to get department names

2. WHERE clause with correlated subquery
   - For each employee, finds MAX salary in their department
   - Only selects employees whose salary = department's max

3. Subquery runs for EACH row
   - WHERE departmentId = e.departmentId (correlation)
   - Compares current employee's salary with dept max

Key Concept: Correlated Subquery
- Inner query references outer query (e.departmentId)
- Runs once per row of outer query
- Useful for row-by-row comparisons

Time Complexity: O(n²) for correlated subquery
Space Complexity: O(n)
*/

-- -----------------------------------------------
-- Status: ✅ Accepted
-- -----------------------------------------------
