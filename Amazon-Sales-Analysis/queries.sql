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

-- Q3: Unique products
SELECT 
    COUNT(DISTINCT sku) AS unique_sku,
    COUNT(DISTINCT asin) AS unique_asin
FROM amazon_sales_raw;
-- Result: SKU: 7195, ASIN: 7190

-- -----------------------------------------------

-- Q4: Unique categories and styles
SELECT 
    COUNT(DISTINCT category) AS unique_category,
    COUNT(DISTINCT style) AS unique_style
FROM amazon_sales_raw;
-- Result: Categories: 9, Styles: 1377

-- -----------------------------------------------

-- Q5: B2B vs Non-B2B orders
SELECT 
    b2b, 
    COUNT(*) AS order_count
FROM amazon_sales_raw
GROUP BY b2b;
-- Result: FALSE: 128104, TRUE: 871
```
-- -----------------------------------------------
-- END OF DAY 2
-- ================================================
