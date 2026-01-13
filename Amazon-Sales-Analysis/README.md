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
├── README.md          # Project documentation
└── queries.sql        # SQL queries (coming soon)
```

---

## 👨‍💻 Author

**Waseeque**  
💼 [LinkedIn](www.linkedin.com/in/waseeque-ahmad-ba8691298)  
🐙 [GitHub](https://github.com/Waseeque-Code)

---

**⭐ If you find this project helpful, please consider giving it a star!**

*Last Updated: January 13, 2025*
