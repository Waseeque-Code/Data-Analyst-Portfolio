# 🚀 Indian Startup Funding Analysis (2015–2017)

An end-to-end data analysis project on Indian startup funding deals from 2015 to 2017.  
Built using **Python → MySQL → Power BI** to clean, analyze, and visualize 2,372 funding records.

---

## 📌 Project Overview

India's startup ecosystem witnessed explosive growth between 2015 and 2017. This project analyzes **2,372 startup funding deals** worth over **$18.35 Billion** to uncover trends in funding, investor behavior, city dominance, and industry growth.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Python (Pandas, NumPy) | Data Cleaning & Preprocessing |
| MySQL | Data Storage & SQL Analysis |
| Power BI | Interactive Dashboard |
| Kaggle | Dataset Source |

---

## 📂 Project Structure

```
Indian-Startup-Funding-Analysis/
│
├── indian_startup.py           # Python data cleaning script
├── Funding.sql                 # MySQL table creation + 15 SQL queries
├── startup_funding_final.csv   # Cleaned dataset
├── startup_funding_pbi.pbix    # Power BI dashboard file
├── dashboard.png               # Dashboard screenshot
└── README.md                   # Project documentation
```

---

## 📊 Dataset

- **Source:** Kaggle — Indian Startup Funding Dataset
- **Records:** 2,372 funding deals
- **Period:** 2015 – 2017
- **Columns:** Date, Startup Name, Industry, Sub-Vertical, City, Investors, Investment Type, Amount (USD)

---

## 🔧 Step 1 — Data Cleaning (Python)

**File:** `indian_startup.py`

**Issues found in raw data:**
- 847 missing values in `AmountInUSD`
- 171 missing values in `IndustryVertical`
- 179 missing values in `CityLocation`
- Inconsistent date formats (dots instead of slashes)
- Comma-formatted numbers in `AmountInUSD` (e.g. "1,300,000")

**Cleaning steps performed:**
- Dropped useless columns (`SNo`, `Remarks`)
- Filled null values with appropriate defaults
- Removed commas from `AmountInUSD` and converted to float
- Replaced 0 values with `NaN` for accurate aggregations
- Standardized date format to `DD/MM/YYYY`
- Extracted `Year` and `Month` columns from `Date`
- Removed duplicate records
- Saved cleaned data as `startup_funding_final.csv`

---

## 🗄️ Step 2 — SQL Analysis (MySQL)

**File:** `Funding.sql`

Performed **15 SQL queries** ranging from basic aggregations to advanced Window Functions, CTEs, and Subqueries.

### Key Queries & Insights

| # | Question | Key Finding |
|---|----------|-------------|
| Q1 | Total startups & funding | 1,921 unique startups raised $18.35 Billion |
| Q2 | City with most deals | Bangalore leads with 502 startups |
| Q3 | Industry with most deals | Consumer Internet dominates with 811 startups |
| Q4 | Most common investment type | Private Equity & Seed Funding cover 90%+ deals |
| Q5 | Top 10 funded startups | Flipkart ($2.3B), Paytm ($2.1B), Ola ($1.9B) |
| Q6 | Year-wise funding trend | 2015 peak → 2016 dip → 2017 recovery |
| Q7 | Total & avg funding per city | Bangalore avg $13.2M per startup |
| Q8 | Industry with highest funding | Consumer Internet — $5.99 Billion total |
| Q9 | Busiest month for deals | January 2016 — 104 deals |
| Q10 | Startup size categorization | CASE WHEN — Small / Medium / Large |
| Q11 | Top industry per year | Window Function — ROW_NUMBER() |
| Q12 | City % contribution to funding | Bangalore — 45.92% of all funding |
| Q13 | Top startup per industry | Subquery — Flipkart, Paytm, Ola lead |
| Q14 | Most diversified investors | Indian Angel Network & Ratan Tata — 6 industries each |
| Q15 | Seed vs Private Equity deal size | PE deals are 113x larger than Seed deals in 2017 |

**SQL Concepts Used:**
- Aggregate Functions (SUM, COUNT, AVG, ROUND)
- GROUP BY, ORDER BY, HAVING
- CASE WHEN
- CTEs (WITH clause)
- Window Functions (ROW_NUMBER, PARTITION BY)
- Subqueries
- LOAD DATA LOCAL INFILE

---

## 📈 Step 3 — Power BI Dashboard

**File:** `startup_funding_pbi.pbix`

### Dashboard Visuals

| Visual | Description |
|--------|-------------|
| KPI Cards | Total Startups, Total Funding, Total Cities, Total Industries |
| Bar Chart | Top 10 Cities by Total Funding |
| Bar Chart | Top 10 Most Funded Startups |
| Line Chart | Year-wise Funding Trend (2015–2017) |
| Treemap | Industry-wise Funding Distribution |
| Stacked Bar | City-wise Investment Type Distribution |
| Slicer | Filter by Investment Type |

---

## 💡 Key Business Insights

1. **Bangalore dominates** — 45.92% of all startup funding went to Bangalore-based startups, making it the undisputed startup capital of India.

2. **Top 3 startups = 33% of all funding** — Flipkart, Paytm, and Ola alone raised over $6 Billion out of $18.35 Billion total.

3. **2016 was a tough year** — Funding dipped to $3.8 Billion in 2016 compared to $8.7 Billion in 2015, but recovered to $5.8 Billion in 2017.

4. **Consumer Internet rules** — The Consumer Internet sector received the highest total funding of $5.99 Billion, driven by food delivery, eCommerce, and mobility startups.

5. **Private Equity vs Seed** — In 2017, the average Private Equity deal ($25.6M) was **113x larger** than the average Seed Funding deal ($0.23M), showing how deal sizes scale with startup maturity.

6. **Metro concentration** — Top 3 cities (Bangalore, New Delhi, Mumbai) account for over **74% of all funding**, showing that Indian startup activity is heavily concentrated in major metros.

---

## 🚀 How to Run This Project

**Step 1 — Python Cleaning:**
```bash
pip install pandas numpy
python indian_startup.py
```

**Step 2 — MySQL Setup:**
```sql
-- Run Funding.sql in MySQL Workbench
-- Import startup_funding_final.csv using LOAD DATA LOCAL INFILE
```

**Step 3 — Power BI:**
- Open `startup_funding_pbi.pbix` in Power BI Desktop
- Refresh data if needed

---

## 👤 Author

**Waseeque Ahmad**  
Aspiring Data Analyst | SQL • Python • Power BI • Excel  
📧 waseequeahmad123@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/waseeque-ahmad-ba8691298)  
🐙 [GitHub](https://github.com/Waseeque-Code/Data-Analyst-Portfolio)
