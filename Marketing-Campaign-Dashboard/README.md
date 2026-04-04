# 📊 Marketing Campaign Performance Dashboard

> **Data Analytics Journey**  
> An interactive Power BI dashboard analyzing marketing campaign performance across multiple channels, segments, and locations.

---

## 🖼️ Dashboard Preview

![Marketing Campaign Dashboard](./dashboard_screenshot.png)

---

## 📌 Project Overview

This dashboard provides a comprehensive view of marketing campaign performance metrics. It helps stakeholders quickly identify which channels, campaign types, and locations are delivering the best ROI, conversion rates, and customer acquisition efficiency.

The dashboard was built entirely in **Power BI** using **DAX measures**, **Power Query** for data cleaning, and a custom **White & Orange theme** for a clean, professional look.

---

## 🎯 KPIs Tracked

| KPI | Description |
|-----|-------------|
| **Avg ROI** | Average Return on Investment across all campaigns |
| **Conversion Rate** | Percentage of clicks that converted |
| **Avg Acquisition Cost** | Average cost to acquire one customer |
| **CTR** | Click Through Rate (Clicks / Impressions) |

---

## 📊 Visuals Used

| Visual | Purpose |
|--------|---------|
| **KPI Cards** | Quick snapshot of 4 key metrics |
| **Funnel Chart** | Campaign journey — Impressions → Clicks → Conversions |
| **Line Chart** | ROI trend over months by channel |
| **Donut Chart** | Clicks distribution by Campaign Type |
| **Matrix** | Channel-wise breakdown of ROI, CAC & Conversion Rate |
| **Location Slicer** | Filter dashboard by city |

---

## 🛠️ Tools & Technologies

| Tool | Usage |
|------|-------|
| **Power BI Desktop** | Dashboard creation & visualization |
| **Power Query** | Data cleaning & transformation |
| **DAX** | Custom measures & calculations |
| **Kaggle** | Dataset source |

---

## 🧮 DAX Measures

```dax
Avg_ROI = AVERAGE(marketing_campaign_dataset[ROI])

Avg_Conversion_Rate = AVERAGE(marketing_campaign_dataset[Conversion_Rate])

Avg_CAC = AVERAGE(marketing_campaign_dataset[Acquisition_Cost])

CTR = DIVIDE(
    SUM(marketing_campaign_dataset[Clicks]),
    SUM(marketing_campaign_dataset[Impressions]),
    0
)

Total_Clicks = SUM(marketing_campaign_dataset[Clicks])

Total_Impressions = SUM(marketing_campaign_dataset[Impressions])
```

---

## 📁 Dataset

- **Source:** Kaggle
- **Dataset:** [Marketing Campaign Performance Dataset](https://www.kaggle.com/datasets/manishabhatt22/marketing-campaign-performance-dataset)
- **Columns Used:** Campaign_ID, Company, Campaign_Type, Target_Audience, Duration, Channel_Used, Conversion_Rate, Acquisition_Cost, ROI, Location, Language, Clicks, Impressions, Engagement_Score, Customer_Segment, Date

---

## 📂 Folder Structure

```
Data-Analyst-Portfolio/
│
└── Marketing-Campaign-Dashboard/
    ├── README.md
    ├── marketing_campaign_dashboard.pbix
    ├── dashboard_screenshot.png
```

---

## 🔍 Key Insights

- 📈 **Average ROI** of **500%+** across all campaigns
- 📧 **Email & Website** channels show highest ROI
- 🎯 **Conversion Rate** consistent at **~8%** across channels
- 💰 **Acquisition Cost** relatively uniform across channels (~$12.5K)
- 📅 **ROI trend** stays stable throughout the year with minor fluctuations

---

## 🤝 Connect with Me

If you found this project helpful or want to collaborate, feel free to connect!

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Waseeque%20Ahmad-blue?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/waseeque-ahmad-ba8691298)

---

## 📌 Part of My Data Analytics Journey

I build real-world data analytics projects daily.

⭐ **Star this repo** if you found it helpful!
