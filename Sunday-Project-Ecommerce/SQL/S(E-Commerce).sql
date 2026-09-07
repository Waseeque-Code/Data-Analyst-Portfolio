
DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    Order_ID VARCHAR(20) PRIMARY KEY,
    Product VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Unit_Price DECIMAL(15,4),  -- Changed from 10,2 to 15,4
    Order_Date DATE,
    Customer_Name VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50),
    Payment_Method VARCHAR(50),
    Order_Status VARCHAR(50),
    Discount_Rate DECIMAL(10,2) DEFAULT 0.00,
    Customer_Rating INT DEFAULT 0
);

-- Re-import
LOAD DATA LOCAL INFILE 'C:/Data Analyst/Data Analyst Portfolio/Sunday Project/E-commerce_sql.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Order_ID, 
    Product, 
    Category, 
    Quantity, 
    @Unit_Price, 
    @Order_Date, 
    Customer_Name, 
    Email, 
    City, 
    Payment_Method, 
    Order_Status, 
    @Discount_Rate, 
    @Customer_Rating
)
SET 
    Unit_Price = NULLIF(@Unit_Price, ''),
    Order_Date = STR_TO_DATE(NULLIF(@Order_Date, ''), '%d-%m-%Y'),
    Discount_Rate = NULLIF(@Discount_Rate, ''),
    Customer_Rating = NULLIF(REPLACE(@Customer_Rating, '\r', ''), '');
    
Select * from Orders;

# INSIGHTS ------

#Q1. Find total revenue (Quantity × Unit_Price) per Category, sorted in descending order.
SELECT 
	Category,
	ROUND(SUM(Quantity * Unit_Price), 2) AS Total_Revenue
FROM Orders
GROUP BY Category
ORDER BY SUM(Quantity * Unit_Price) DESC;

#Q2. Find the top 5 products by total quantity sold.
SELECT 
	Product,
    SUM(Quantity) AS Total_Quantity
FROM Orders
GROUP BY Product
ORDER BY SUM(Quantity) DESC
LIMIT 5;

#Q3. Find total orders and total revenue per City, ranked by revenue.
WITH CityAgg AS (
	SELECT 
		City,
        COUNT(Order_ID) AS Total_Orders,
        SUM(Quantity * Unit_Price) AS Total_Revenue
	FROM Orders
    GROUP BY City
)
SELECT 
	City,
    Total_Orders,
    ROUND(Total_Revenue, 2),
    RANK() OVER(ORDER BY Total_Revenue DESC) AS RANKK
FROM CityAgg;

#Q4. Find month-wise total sales trend (extract month/year from Order_Date) — compare 2023 vs 2024.
WITH TM AS (
	SELECT 
		MONTH(Order_Date) AS Month,
        Year(Order_Date) AS Year,
        SUM(Quantity * Unit_Price) AS Total_Sales
	FROM Orders
    WHere Year(Order_Date) IN (2023, 2024) 
    GROUP BY MONTH(Order_Date), YEAR(Order_Date) 
)
SELECT 
	Month,
    ROUND(SUM(CASE WHEN Year = 2023 THEN Total_Sales ELSE 0 END), 2) AS Sales_2023,
    ROUND(SUM(CASE WHEN Year = 2024 THEN Total_Sales ELSE 0 END), 2) AS Sales_2024,
    (ROUND(SUM(CASE WHEN Year = 2023 THEN Total_Sales ELSE 0 END), 2) -  ROUND(SUM(CASE WHEN Year = 2024 THEN Total_Sales ELSE 0 END), 2)) AS Diff
FROM TM
GROUP BY Month
ORDER BY Diff DESC;

#Q5. Find the count and percentage of Cancelled orders for each Payment_Method.
WITH CN AS (
	SELECT 
		Payment_Method,
        COUNT(*) AS Total_Orders,
        SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled_Orders
	FROM Orders
    GROUP BY Payment_Method
)
SELECT 
	Payment_Method,
    Cancelled_Orders,
    ROUND((Cancelled_Orders * 100 / Total_Orders), 2) AS Percentagee
FROM CN
ORDER BY Cancelled_Orders DESC;

#Q6. Find the top 5 customers by total spend using a window function (RANK/DENSE_RANK).
WITH T5C AS (
	SELECT 
		Customer_Name,
        ROUND(SUM(Quantity * Unit_Price), 2) AS Total_spending,
        DENSE_RANK() OVER(ORDER BY ROUND(SUM(Quantity * Unit_Price), 2) DESC) AS RNKK
	FROM Orders
    GROUP BY Customer_Name
)
SELECT 
	Customer_Name,
    Total_spending
FROM T5C
WHERE RNKK <= 5;

#Q7. Find each customer's average Customer_Rating, showing only customers with rating below 3 (using HAVING).
SELECT 
	Customer_Name,
    AVG(Customer_Rating) AS Avg_Cust_Rating
FROM Orders
GROUP BY Customer_Name
HAVING AVG(Customer_Rating) <= 3
ORDER BY AVG(Customer_Rating) DESC;

#Q8. Find duplicate customers — same Email but orders from different Cities.
WITH TT AS (
SELECT 
	COUNT(DISTINCT City) AS City,
    Email
FROM Orders
GROUP BY Email
HAVING COUNT(DISTINCT City) > 1
)
SELECT 
	o.Email,
    o.Customer_Name,
    o.City
FROM Orders o 
INNER JOIN TT t on o.Email = t.Email
ORDER BY o.Email, o.City;

#Q9. Using a self-join or subquery, find customers who ordered from more than one different Category.
SELECT 
    Customer_Name,
    COUNT(*) AS total_orders
FROM Orders 
GROUP BY Customer_Name
HAVING COUNT(*) > (
    SELECT MAX(Total_or)
    FROM (
        SELECT COUNT(*) AS Total_or
        FROM Orders
        GROUP BY Category
    ) AS CatCounts
);

#Q10. Using a CTE, first calculate monthly revenue, then calculate month-over-month growth %.
WITH MonthlyRevenue AS (
	SELECT 
		YEAR(Order_Date) AS Year,
        MONTH(Order_Date) AS Month,
        SUM(Quantity * Unit_Price) AS Total_Revenue
	FROM Orders 
    GROUP BY Year(Order_Date), Month(Order_Date) 
),
MOM AS (
	SELECT 
		Year,
        Month,
        Total_Revenue,
        LAG(Total_Revenue) OVER(Order BY Year, Month) AS Pre_Revenue
	FROM MonthlyRevenue
)
SELECT 
	Year,
    Month,
    ROUND(Total_Revenue, 2) AS Total_Revenue,
    ROUND(
		(Total_Revenue - Pre_Revenue) * 100.0 / NULLIF(Pre_Revenue, 0), 2) AS Month_Over_Month_Growth
FROM MOM
Order by Month, Year;






















































































































































