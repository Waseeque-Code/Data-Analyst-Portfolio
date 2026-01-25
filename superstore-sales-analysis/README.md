# 📊 Superstore Sales Analysis Dashboard

<img width="1569" height="925" alt="Screenshot 2026-01-25 114630" src="https://github.com/user-attachments/assets/37c78d6b-6783-4465-af90-c52f099e8731" />

## 🎯 Project Overview

An in-depth sales analysis of a US-based superstore using **Excel** and **advanced formulas** to uncover actionable business insights. This project analyzes 4 years of sales data (2014-2017) covering 9,994 orders to identify revenue trends, profit margins, regional performance, and product profitability.

**Live Dashboard:** [View Excel File](Superstore_Sales_Dashboard.xlsx)


---

## 📁 Dataset Information

- **Source:** [Kaggle - Superstore Sales Dataset](https://www.kaggle.com/)
- **Time Period:** January 2014 - December 2017
- **Total Records:** 9,994 orders
- **Geographic Coverage:** United States (4 regions)
- **Product Categories:** Furniture, Office Supplies, Technology

### Dataset Fields:
- Order & Ship Dates
- Customer Information (Name, Segment, Location)
- Product Details (Category, Sub-Category, Name)
- Sales Metrics (Sales, Quantity, Discount, Profit)

---

## 🎯 Key Performance Indicators (KPIs)

<img width="1834" height="116" alt="Screenshot 2026-01-25 114810" src="https://github.com/user-attachments/assets/83a09f3b-d12c-4bd5-a67d-1bb59dfa6e7c" />

| Metric | Value |
|--------|-------|
| **Total Revenue** | $2,297,200.86 |
| **Total Profit** | $286,397.02 |
| **Profit Margin** | 12.47% |
| **Total Orders** | 9,994 |
| **Average Order Value** | $229.86 |

---

## 📈 Key Insights & Findings

### 1. Regional Performance
- **West Region** leads in profitability with **$108,418** profit
- **East Region** has highest sales volume ($678,781)
- **Central Region** shows opportunity for improvement (lowest profit margin)

### 2. Product Category Analysis
- **Technology** is the most profitable category ($145,455 profit, 17% margin)
- **Furniture** has concerning low margins (only 2.5% - needs pricing review)
- **Office Supplies** provides steady revenue ($719,047 sales)

### 3. Discount Impact ⚠️
- Orders **with discounts**: -8% profit margin (LOSS!)
- Orders **without discounts**: +34% profit margin
- **52% of orders** have discounts - major profit killer

### 4. Growth Trajectory 📊
- **51% revenue growth** from 2014 to 2017
- Orders nearly **doubled** (1,993 → 3,312)
- Consistent upward trend indicates healthy business expansion

### 5. Top Performing Products
**Best Sellers:**
1. Canon Imageclass 2200 Advanced Copier - $61,599 sales, $25,199 profit
2. Fellowes Pb500 Electric Punch Binding Machine - $27,453 sales
3. Cisco Telepresence System Ex90 - $22,638 sales

**Loss-Making Products:**
1. Cubify Cubex 3D Printer Double Head - Loss of $8,879
2. Lexmark Mx611Dhe Monochrome Laser Printer - Loss of $4,589
3. 3D Printers consistently underperforming

### 6. Shipping Analysis
- **Standard Class** (60% of orders): Average 5 days delivery
- **Same Day** delivery: Only 1.6 days (premium service working well)
- Most customers prefer economical shipping options

---

## 💡 Business Recommendations

1. **🚨 URGENT: Reduce Discount Strategy**
   - Current discount policy is destroying profits (-8% margin)
   - Implement tiered discounting (max 10-15%)
   - Focus on value messaging instead of price cuts

2. **📈 Expand West Region Operations**
   - Highest profit margin region ($108K)
   - Allocate more marketing budget here
   - Replicate successful strategies to other regions

3. **🛠️ Review Furniture Pricing**
   - 2.5% margin is unsustainable
   - Increase prices or reduce costs
   - Consider discontinuing low-margin items

4. **❌ Discontinue 3D Printers**
   - Consistent losses across all models
   - Not aligned with core business
   - Reallocate inventory investment

5. **🎯 Focus on Technology Category**
   - 17% margin - best performing
   - Expand product range
   - Increase inventory of top sellers (Canon, Cisco)

6. **👔 Target Corporate Segment More**
   - Higher average order values
   - Better profit margins than Consumer
   - Develop B2B marketing campaigns

---

## 🛠️ Tools & Technologies

### Excel Features Used:
- **Pivot Tables** - Multi-dimensional data analysis
- **Advanced Formulas:**
  - `SUMIF` / `SUMIFS` - Conditional aggregation
  - `AVERAGEIF` - Segment-wise averages
  - `IF` with `AND` - Data validation
  - `TEXT` / `DATE` functions - Time-based analysis
  - `COUNTIF` - Frequency analysis

- **Data Visualization:**
  - Column Charts (Regional comparison)
  - Line Charts (Trend analysis)
  - Combo Charts (Sales vs Profit)
  
- **Dashboard Design:**
  - KPI Cards with conditional formatting
  - Interactive slicers for filtering
  - Professional color scheme and layout

### Power Query:
- Date format standardization
- Data type conversions
- Data cleaning and transformation

---

## 📊 Dashboard Components

<img width="1569" height="925" alt="Screenshot 2026-01-25 114630" src="https://github.com/user-attachments/assets/45d4266b-78ed-4ded-96be-666e463f7771" />

### Visualizations Included:
1. **Sales by Region** - Column chart showing regional performance
2. **Sales Trend (2014-2017)** - Line chart displaying growth trajectory
3. **Category Performance** - Combo chart comparing sales vs profit
4. **Top 5 Products** - Ranked table of best performers
5. **Bottom 5 Products** - Loss-making items requiring action
6. **Shipping Mode Analysis** - Delivery performance metrics

---

## 📂 Project Structure
```
Superstore_Sales_Analysis/
│
├── README.md                              # Project documentation
├── Superstore_Sales_Dashboard.xlsx  # Main Excel file with dashboard
│
├── data/
│   └── superstore_sales_cleaned.csv       # Cleaned dataset
│
└── screenshots/
    ├── dashboard_full.png                 # Complete dashboard view
    ├── kpi_cards.png                      # KPI metrics
    ├── charts_overview.png                # Visualization section
    └── insights_products.png              # Product analysis
```

---

## 🔍 Data Quality Notes

**Data Cleaning Performed:**
- Identified ~200 records (2%) with invalid shipping data
- Ship dates occurring before order dates excluded from delivery analysis
- Unrealistic delivery times (>30 days) filtered out
- **Valid records used:** 9,794 (98% of dataset)

**Methodology:**
- Invalid records excluded from delivery time calculations only
- All other metrics calculated on complete dataset
- Business impact: Minimal (<2% data loss)

---

## 📚 How to Use This Project

1. **Download the Excel file:**
```
Superstore_Sales_Dashboard.xlsx
```

2. **Open in Microsoft Excel** (2016 or later recommended)

3. **Navigate through sheets:**
   - `Dashboard` - Main interactive dashboard
   - `Raw Data` - Complete cleaned dataset
   - `Calculations` - All metrics and formulas
   - `Pivot Analysis` - Detailed pivot tables

4. **Use Slicers to Filter:**
   - Filter by Region, Category, or Year
   - Charts update automatically

5. **Explore Insights:**
   - Review KPI cards for quick overview
   - Analyze trends in charts
   - Check product performance tables

---

## 🎓 Skills Demonstrated

- ✅ Data Cleaning & Validation
- ✅ Advanced Excel Formulas (SUMIFS, AVERAGEIF, IF/AND)
- ✅ Pivot Table Analysis
- ✅ Data Visualization Best Practices
- ✅ Dashboard Design & UX
- ✅ Business Intelligence & Insights
- ✅ Statistical Analysis
- ✅ Power Query for ETL
- ✅ Professional Documentation

---

## 📈 Future Enhancements

- [ ] Add predictive analytics using trend lines
- [ ] Customer cohort analysis
- [ ] Geographic mapping with Power BI
- [ ] Real-time data connection
- [ ] Automated email reports
- [ ] Interactive web dashboard using Python/Tableau

---

## 👤 Author

**Waseeque Ahmad**
- LinkedIn: www.linkedin.com/in/waseeque-ahmad-ba8691298
- GitHub: https://github.com/Waseeque-Code/Data-Analyst-Portfolio/new/main

---

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

---

## 🙏 Acknowledgments

- Dataset: Kaggle Superstore Sales Dataset
- Inspired by real-world business analytics challenges
- Tools: Microsoft Excel 365, Power Query

---

### ⭐ If you found this project helpful, please give it a star!

---

**Last Updated:** January 25, 2026
