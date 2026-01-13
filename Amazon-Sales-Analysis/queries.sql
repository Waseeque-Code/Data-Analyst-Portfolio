-- ================================================
-- AMAZON SALES DATA ANALYSIS
-- Author: Waseeque Ahmad
-- Date: January 2025
-- ================================================

-- Q1: Total number of orders
SELECT COUNT(*) AS total_orders 
FROM amazon_sales_raw;
-- Result: 128,975

-- -----------------------------------------------

-- Q2: Date range of dataset
SELECT 
    MIN(date) AS first_order_date, 
    MAX(date) AS last_order_date
FROM amazon_sales_raw;
-- Result: 2022-03-31 to 2022-06-29

-- -----------------------------------------------

-- Q3: [Coming Soon]
-- Will be added on Day 2

-- -----------------------------------------------

-- Q4: [Coming Soon]

-- -----------------------------------------------

-- Q5: [Coming Soon]

-- -----------------------------------------------
-- END OF DAY 1
-- ================================================
```

### 5️⃣ Commit message:
```
Added queries.sql file with Q1-Q2
