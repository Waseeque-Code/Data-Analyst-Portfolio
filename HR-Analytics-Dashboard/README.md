# 📊 HR Analytics Dashboard — Power BI

## 🔍 Project Overview
An interactive HR Analytics Dashboard built in Power BI
using the IBM HR Employee Attrition & Performance dataset.
The dashboard helps HR teams analyze attrition trends,
salary distribution, and department-level insights
through dynamic drill-through pages and slicers.

---

## 📁 Dataset
- **Source:** IBM HR Analytics Employee Attrition Dataset (Kaggle)

---

## 📌 KPIs
| Metric | Value |
|---|---|
| Attrition Rate | 16.12% |
| Average Salary | $6.50K/month |
| Total Headcount | 1,470 |

---

## 📄 Dashboard Pages

### 1. Overview Page
- Headcount by Department
- Attrition Rate by Department (Donut Chart)
- Avg Salary by Department (Column Chart)
- Attrition Rate by Age Group
- Slicers — Department, Gender, OverTime

### 2. Attrition Details Page (Drill-Through)
- Attrition Rate by MaritalStatus
- Attrition Rate by OverTime
- Attrition Rate by Gender
- Attrition Rate by WorkLife Group
- Attrition Rate by JobLevel
- Attrition Rate by Age Group

### 3. Salary Details Page (Drill-Through)
- Avg Salary by JobRole
- Avg Salary by Gender
- Avg Salary by Age Group
- Avg Salary by JobLevel
- Avg Salary by EducationField
- KPI Cards — Avg, Max, Min Salary

---

## 🔧 Tools & Technologies
| Tool | Usage |
|---|---|
| Power BI Desktop | Dashboard Development |
| DAX | Custom Measures & Columns |
| Power Query | Data Cleaning & Transformation |

---

## 📐 DAX Measures Created
- Attrition Rate
- Avg Salary
- Headcount
- Max Salary
- Min Salary

## 🧮 Calculated Columns Created
- Age Group
- WorkLife Group
- Age Sort

---

## 💡 Key Insights
- 🔴 Employees aged **18-25** have highest attrition (30%+)
- 🔴 **Sales** department has highest attrition rate
- 🔴 Employees doing **OverTime** leave more
- 🔴 **Single** employees leave more than married/divorced
- 🟢 Higher **JobLevel** = Lower attrition
- 🟢 Higher **Salary** = Lower attrition
- 🟢 Employees aged **46-55** earn highest avg salary

---


## 🚀 How to Use
1. Download `HR_Analytics.pbix`
2. Open in Power BI Desktop
3. Explore Overview page
4. Right-click on any chart → Drill Through
5. Use slicers to filter data

---

## 👨‍💻 Author
**Waseeque Ahmad**
linkedin.com/in/waseeque-ahmad-ba8691298
