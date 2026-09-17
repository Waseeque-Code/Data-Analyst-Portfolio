# Zomato Delivery Time — Exploratory Data Analysis

## 📌 Project Overview
End-to-end EDA on Zomato delivery dataset (45,584 rows, 20 columns) to identify 
key factors affecting delivery time and derive business insights.

## 🎯 Objective
- Analyze factors impacting `Time_taken (min)`
- Clean and prepare data for analysis
- Identify peak hours and high-risk conditions
- Provide actionable business recommendations

## 🛠️ Tech Stack
- **Python** — pandas, numpy
- **Visualization** — matplotlib, seaborn
- **Environment** — Jupyter Notebook

## 📊 Key Findings

| Factor | Impact on Delivery Time |
|---|---|
| Multiple deliveries (0→3) | +26 min ⬆️ |
| Festival days | +20 min ⬆️ |
| Traffic Jam (vs Low) | +10 min ⬆️ |
| Bad weather (Fog/Cloudy) | +8 min ⬆️ |
| Age 30-39 (vs 20-29) | +6 min ⬆️ |
| Dinner peak (7-9 PM) | 31 min avg (slowest) |

## 🧹 Data Cleaning
- Handled missing values (8 columns)
- Fixed invalid ages (<18) and ratings (>5)
- Converted Excel decimal times → HH:MM format
- Dropped invalid lat-long based distance feature

## 💡 Business Recommendations
1. **Festival days:** Scale up rider supply (~80% time increase)
2. **Dinner peak (7-9 PM):** Realistic ETAs + rider incentives
3. **Cap multiple deliveries:** 3 concurrent = 48 min avg
4. **Traffic jam:** Route optimization can save ~10 min
5. **Bad weather:** Dynamic ETA buffers

## 📁 Files
- `zomato_eda.ipynb` — full analysis code
- `zomato_cleaned.csv` — cleaned dataset
- `plots/` — all visualizations
- `report/Zomato_EDA_Report.pdf` — detailed report

## 📬 Connect with Me
- **LinkedIn:** www.linkedin.com/in/waseeque-ahmad-ba8691298
- **GitHub:** https://github.com/Waseeque-Code/Data-Analyst-Portfolio
- **Email:** waseequeahmad123@gmail.com
