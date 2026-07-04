# 📊 Marketing Campaign Performance Analysis

An end-to-end data analysis project on 200,000 marketing campaign records.  
Built using **Python → MySQL → Power BI** to clean, analyze, and visualize campaign performance across channels, locations, and customer segments.

---

## 📌 Project Overview

This project analyzes **200,000 marketing campaigns** run by 5 companies across multiple channels, locations, and customer segments. The goal was to uncover which campaigns, channels, and segments deliver the best ROI and conversion rates.

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
Marketing-Campaign-Analysis/
│
├── marketing_campaign_cleaned.py     # Python data cleaning script
├── marketing_campaign_analysis.sql   # MySQL table creation + 15 SQL queries
├── marketing_campaign_cleaned.csv    # Cleaned dataset
├── marketing_campaign_dashboard.pbix # Power BI dashboard file
├── dashboard.png                     # Dashboard screenshot
└── README.md                         # Project documentation
```

---

## 📊 Dataset

- **Source:** Kaggle — Marketing Campaign Dataset
- **Records:** 200,000 campaigns
- **Period:** 2021
- **Columns:** Campaign_ID, Company, Campaign_Type, Target_Audience, Duration, Channel_Used, Conversion_Rate, Acquisition_Cost, ROI, Location, Language, Clicks, Impressions, Engagement_Score, Customer_Segment, Date

---

## 🔧 Step 1 — Data Cleaning (Python)

**File:** `marketing_campaign_cleaned.py`

**Issues found in raw data:**
- `Acquisition_Cost` — stored as string with `$` and `,` (e.g. "$12,500")
- `Duration` — stored as string with "days" text (e.g. "30 days")
- `Date` — stored as object, needed datetime conversion

**Cleaning steps performed:**
- Removed `$` and `,` from `Acquisition_Cost` → converted to float
- Removed "days" from `Duration` → converted to int
- Converted `Date` to datetime format
- Extracted `Year` and `Month` columns from `Date`
- Verified 0 missing values and 0 duplicates
- Saved cleaned data as `marketing_campaign_cleaned.csv`

---

## 🗄️ Step 2 — SQL Analysis (MySQL)

**File:** `marketing_campaign_analysis.sql`

Performed **15 SQL queries** ranging from basic aggregations to advanced Window Functions, CTEs, and Subqueries.

### Key Queries & Insights

| # | Question | Key Finding |
|---|----------|-------------|
| Q1 | Total campaigns, clicks & impressions | 200K campaigns, 110M clicks, 1.1B impressions |
| Q2 | Campaign type with most campaigns | Influencer leads with 40,169 campaigns |
| Q3 | Most frequently used channel | Email — 33,599 campaigns |
| Q4 | Location with most campaigns | Miami — 40,269 campaigns |
| Q5 | Top companies by average ROI | TechCorp leads with avg ROI of 5.01 |
| Q6 | Campaign type with highest conversion rate | Influencer — 8.03% avg conversion rate |
| Q7 | Channel with best average ROI | Facebook — avg ROI of 5.02 |
| Q8 | Month-wise clicks trend | October highest (9.38M), February lowest (8.43M) |
| Q9 | Most targeted customer segment | Foodies — 40,208 campaigns |
| Q10 | Acquisition cost categorization | 66.6% High cost, 33.4% Medium cost (CASE WHEN) |
| Q11 | Best channel per campaign type | Facebook dominates 4 out of 5 campaign types (Window Function) |
| Q12 | Location % contribution to clicks | New York & Miami tied at 20.06% each (Window Function) |
| Q13 | Best campaign type per segment | Tech Enthusiasts → Influencer, Fashionistas → Email (Subquery) |
| Q14 | Month-wise conversion rate trend | April highest (8.05%), August lowest (7.97%) — very stable (CTE) |
| Q15 | Top company per channel by engagement | TechCorp leads Website, Innovate leads Google Ads & YouTube (CTE) |

**SQL Concepts Used:**
- Aggregate Functions (SUM, COUNT, AVG, ROUND)
- GROUP BY, ORDER BY, HAVING
- CASE WHEN
- CTEs (WITH clause)
- Window Functions (RANK, SUM OVER, PARTITION BY)
- Subqueries

---

## 📈 Step 3 — Power BI Dashboard

**File:** `marketing_campaign_dashboard.pbix`

### Dashboard Visuals

| Visual | Description |
|--------|-------------|
| KPI Cards | Total Campaigns, Total Clicks, Average ROI, Avg Conversion Rate |
| Pie Chart | Average ROI by Campaign Type |
| Bar Chart | Average ROI by Channel |
| Line Chart | Month-wise Clicks Trend |
| Treemap | Customer Segment Distribution |
| Bar Chart | Top 5 Locations by Total Clicks |
| Donut Chart | Acquisition Cost Distribution (High/Medium/Low) |
| Slicers | Filter by Channel Used & Campaign Type |

---

## 💡 Key Business Insights

1. **Facebook dominates ROI** — Facebook delivers the best average ROI of 5.02 and is the top-performing channel for 4 out of 5 campaign types, making it the most reliable channel for marketing investment.

2. **Influencer campaigns convert best** — With an 8.03% average conversion rate, Influencer campaigns outperform all other types, suggesting influencer marketing is the most effective strategy for driving conversions.

3. **200K campaigns, 110M clicks** — At an average of 550 clicks per campaign across 1.1 Billion impressions, the overall click-through performance is consistent across all channels and locations.

4. **Segment-specific strategies work best** — Tech Enthusiasts respond best to Influencer campaigns, Fashionistas to Email, and Foodies/Outdoor Adventurers to Display — showing that personalized campaign targeting significantly improves ROI.

5. **66.6% of campaigns are high-cost** — Over two-thirds of all campaigns fall in the High acquisition cost category (>$10,000), indicating that most marketing investments are premium-level spends.

6. **Geographic distribution is balanced** — All 5 cities (New York, Miami, Chicago, Los Angeles, Houston) contribute almost equally to total clicks (~20% each), showing no single city dominates campaign reach.

---

## 🚀 How to Run This Project

**Step 1 — Python Cleaning:**
```bash
pip install pandas numpy
python marketing_campaign_cleaned.py
```

**Step 2 — MySQL Setup:**
```sql
-- Run marketing_campaign_analysis.sql in MySQL Workbench
-- Import marketing_campaign_cleaned.csv using LOAD DATA LOCAL INFILE
```

**Step 3 — Power BI:**
- Open `marketing_campaign_dashboard.pbix` in Power BI Desktop
- Refresh data if needed

---

## 👤 Author

**Waseeque Ahmad**  
Aspiring Data Analyst | SQL • Python • Power BI • Excel  
📧 waseequeahmad123@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/waseeque-ahmad-ba8691298)  
🐙 [GitHub](https://github.com/Waseeque-Code/Data-Analyst-Portfolio)
