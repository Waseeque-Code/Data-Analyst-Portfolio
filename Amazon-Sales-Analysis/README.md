# 📊 Amazon Sales Data Analysis - SQL Project

## 🎯 Project Overview
Analysis of **128,975 Amazon orders** from March-June 2022 to uncover sales patterns, trends, and business insights using SQL.

**Tools Used:** SQL (MySQL/PostgreSQL)  
**Dataset Size:** 128K+ records  
**Time Period:** Q2 2022 (3 months)  
**Total Questions:** 30

---

## 📚 Table of Contents
- [Questions Solved](#-questions-solved)
- [Key Insights](#-key-insights)
- [About This Project](#-about-this-project)

---

## ❓ Questions Solved

### Q1: Total Number of Orders in Dataset

**❓ Business Question**  
What is the total number of orders placed on Amazon in our dataset?

**🧾 SQL Query**
```sql
SELECT COUNT(*) AS total_orders 
FROM amazon_sales_raw;
```

**📈 Result / Insight**
- **Total Orders:** 128,975
- This represents the complete order volume in our analysis period
- Dataset contains sufficient records for meaningful analysis

**💡 Business Conclusion**  
The dataset contains 128,975 orders, providing a robust sample size for comprehensive sales analysis and pattern identification.

---

### Q2: Date Range of the Dataset

**❓ Business Question**  
What is the time period covered by our sales data? Understanding the date range helps us identify seasonal trends and ensures our analysis reflects the correct business period.

**🧾 SQL Query**
```sql
SELECT 
    MIN(date) AS first_order_date, 
    MAX(date) AS last_order_date
FROM amazon_sales_raw;
```

**📈 Result / Insight**
- **First Order Date:** March 31, 2022
- **Last Order Date:** June 29, 2022
- **Total Duration:** 3 months (90 days approximately)
- Dataset covers **Q2 2022** - Spring to early Summer period
- This is a relatively short but recent snapshot of sales activity

**💡 Business Conclusion**  
The dataset spans 3 months (Mar-Jun 2022), making it ideal for analyzing recent quarterly trends but limited for year-over-year or long-term seasonal comparisons.

---

### Q3: Unique Products in Dataset

**❓ Business Question**  
How many unique products are available in our sales data? Understanding product variety helps analyze catalog depth and SKU management.

**🧾 SQL Query**
```sql
SELECT 
    COUNT(DISTINCT sku) AS unique_sku,
    COUNT(DISTINCT asin) AS unique_asin
FROM amazon_sales_raw;
```

**📈 Result / Insight**
- **Unique SKUs:** 7,195
- **Unique ASINs:** 7,190
- **Difference:** 5 SKUs (SKU > ASIN indicates product variants)
- SKUs represent individual stock items while ASINs represent product listings
- Multiple SKUs per ASIN suggest products with variations (size, color, bundle options)

**💡 Business Conclusion**  
The dataset contains 7,190 unique product listings (ASINs) with 7,195 stock keeping units (SKUs), indicating minimal product variation - most products don't have multiple variants, suggesting a focused catalog strategy.

---

### Q4: Unique Product Categories and Styles

**❓ Business Question**  
How many unique product categories and styles does our catalog contain? Understanding product variety helps in inventory planning and marketing strategy.

**🧾 SQL Query**
```sql
SELECT 
    COUNT(DISTINCT category) AS unique_category,
    COUNT(DISTINCT style) AS unique_style
FROM amazon_sales_raw;
```

**📈 Result / Insight**
- **Unique Categories:** 9
- **Unique Styles:** 1,377
- **Average Styles per Category:** ~153
- Limited categories indicate focused business segments
- High style count shows deep product variety within each category
- Suggests a strategy of specialization rather than broad diversification

**💡 Business Conclusion**  
With only 9 product categories but 1,377 distinct styles, Amazon demonstrates a focused catalog strategy - targeting specific market segments with extensive product variety rather than spreading thin across many categories.

---

### Q5: B2B vs Non-B2B Orders Distribution

**❓ Business Question**  
What is the split between B2B (Business-to-Business) and B2C (Business-to-Consumer) orders? Understanding customer segments helps tailor marketing and service strategies.

**🧾 SQL Query**
```sql
SELECT 
    b2b, 
    COUNT(*) AS order_count
FROM amazon_sales_raw
GROUP BY b2b;
```

**📈 Result / Insight**
- **Non-B2B Orders (FALSE):** 128,104 (99.32%)
- **B2B Orders (TRUE):** 871 (0.68%)
- **Total Orders:** 128,975
- Consumer segment is overwhelmingly dominant
- B2B represents less than 1% of total orders
- Platform primarily serves individual consumers during this period

**💡 Business Conclusion**  
The dataset shows a heavily consumer-oriented sales channel with 99.32% non-B2B orders, indicating Amazon's primary focus on individual customers rather than business clients in this Q2 2022 snapshot.

---

### Q6: Fulfillment Distribution Analysis

### ❓ Business Question
How many orders were fulfilled by Amazon vs Merchant? We are asking this to understand the distribution of fulfilment responsibility. This helps in evaluating operational efficiency, customer experience, and dependency on Amazon vs third‑party merchants.

### 🧾 SQL Query
```sql
SELECT fulfilment, COUNT(order_id) AS Fulfilled 
FROM amazon_sales_raw 
GROUP BY fulfilment;
```

### 📈 Result / Insight
* **Merchant Fulfilled (FALSE):** 128,104 orders
* **Amazon Fulfilled (TRUE):** 871 orders
* **Pattern observed:** The vast majority of orders are fulfilled by merchants, while Amazon directly fulfils only a very small fraction.

### 💡 Business Conclusion
Order fulfilment is heavily merchant‑driven, with Amazon handling less than 1% of total orders. This indicates strong reliance on third‑party sellers, which may impact quality control, delivery speed, and customer satisfaction strategies.

---

## 🔑 Key Insights

### Dataset Overview
- 📦 Total Orders: **128,975**
- 📅 Time Period: **March 31 - June 29, 2022** (Q2)
- ⏱️ Duration: **~90 days**

### Initial Findings
- Strong sample size for statistical analysis
- Quarterly data suitable for seasonal pattern identification
- Recent data (2022) provides relevant market insights

---

## 📊 About This Project

### 🎯 Objective
To perform comprehensive SQL analysis on Amazon sales data, extracting actionable business insights through 30 analytical questions covering:
- Sales trends and patterns
- Customer behavior analysis
- Product performance metrics
- Time-based analysis
- Revenue optimization opportunities

### 🛠️ Tools & Technologies
- **Database:** MySQL / PostgreSQL
- **Dataset:** Amazon Sales Data (128K+ records)
- **Analysis Period:** Q2 2022

### 📁 Repository Structure
```
Amazon-Sales-Analysis/
├── README.md          # Project documentation & analysis
└── queries.sql        # SQL queries with results
```

---

## 👨‍💻 Author

**Waseeque**  
💼 [LinkedIn](www.linkedin.com/in/waseeque-ahmad-ba8691298)  
🐙 [GitHub](https://github.com/Waseeque-Code)

---

**⭐ If you find this project helpful, please consider giving it a star!**

*Last Updated: January 13, 2025*
