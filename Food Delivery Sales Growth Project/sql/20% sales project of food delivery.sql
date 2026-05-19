CREATE TABLE food_delivery (
  order_id VARCHAR(50),
  city_tier VARCHAR(20),
  order_hour INT,
  order_month INT,
  delivery_distance_km DECIMAL(10,2),
  preparation_time_minutes INT,
  delivery_time_minutes INT,
  traffic_level_score DECIMAL(10,2),
  weather_severity_score DECIMAL(10,2),
  customer_rating DECIMAL(3,1),
  order_value DECIMAL(10,2),
  discount_amount DECIMAL(10,2),
  final_amount_paid DECIMAL(10,2),
  number_of_items INT,
  cancellation_flag VARCHAR(10),
  delayed_delivery_flag VARCHAR(10),
  promo_code_used VARCHAR(10),
  premium_customer_flag VARCHAR(10),
  festival_or_weekend_flag VARCHAR(10)
);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Data Analyst/SQL/Case study project 2/Food_delivery.csv'
INTO TABLE food_delivery
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM food_delivery;
SELECT * FROM food_delivery;

-- TOTAL AMOUNT, AVG AMOUUNT, TOTAL ORDERS, CANCELLATION ORDERS
SELECT 
	SUM(final_amount_paid) AS Total_amount,
    ROUND(AVG(final_amount_paid), 2) AS Avg_amount,
    COUNT(order_id) AS Total_orders,
    SUM(CASE
			WHEN cancellation_flag = 'TRUE' THEN 1
            ELSE 0
		END) AS Cancellation_orders
FROM food_delivery;
-- Cancellation flag TRUE = Cancelled and FALSE = Not Cancelled

SELECT 
	SUM(final_amount_paid) AS Total_amount,
    ROUND(AVG(final_amount_paid), 2) AS Avg_amount,
    COUNT(order_id) AS Total_orders,
    SUM(CASE
			WHEN cancellation_flag = 'FALSE' THEN 1
            ELSE 0
		END) AS Cancellation_orders
FROM food_delivery;

-- MONTH SALES TREND (LAST 6 MONTHS)
SELECT
	order_month,
    COUNT(order_id) AS Total_orders,
    ROUND(SUM(final_amount_paid), 2) AS Total_amount,
    ROUND(AVG(final_amount_paid), 2) AS Avg_amount
FROM food_delivery
WHERE cancellation_flag = 'FALSE'
GROUP BY order_month
ORDER BY order_month DESC
LIMIT 6;

-- AVERAGE SALES BY CUSTOMER SEGMENT
SELECT
	premium_customer_flag,
    COUNT(order_id) AS Total_orders,
    ROUND(SUM(final_amount_paid), 2) AS Total_sales,
    ROUND(AVG(final_amount_paid), 2) AS Avg_order_value
FROM food_delivery
WHERE cancellation_flag = 'FALSE'
GROUP BY premium_customer_flag;

-- PROMO CODE IMPACT
SELECT
	promo_code_used,
    COUNT(*) AS Orders,
    ROUND(AVG(final_amount_paid), 2) AS Avg_sales,
    ROUND(AVG(discount_amount), 2) AS Avg_discount
FROM food_delivery
WHERE cancellation_flag = 'FALSE'
GROUP BY promo_code_used;

-- DELAY IMPACT ON SALES & CANCELLATION
SELECT
	delayed_delivery_flag,
    COUNT(*) AS Orders,
    ROUND(SUM(final_amount_paid), 2) AS Sales,
    SUM(CASE
			WHEN cancellation_flag = "TRUE"
            THEN 1 ELSE 0
            END) AS Cancellations
FROM food_delivery
GROUP BY delayed_delivery_flag;

-- CUSTOMER RATING VS ORDER VALUE
SELECT
	CASE
		WHEN customer_rating >= 4.5 THEN 'Excellent (4.5-5)'
        WHEN customer_rating >= 3.5 THEN 'Good (3.5-4.4)'
        WHEN customer_rating >= 2.5 THEN 'Average (2.5-3.4)'
        ELSE 'Poor (1-2.4)'
        END AS rating_group,
        COUNT(order_id) AS Orders,
        ROUND(AVG(final_amount_paid), 2) AS Avg_sales,
        ROUND(AVG(order_value), 2) AS Avg_order_value
FROM food_delivery
WHERE cancellation_flag = "FALSE"
GROUP BY rating_group;
    
