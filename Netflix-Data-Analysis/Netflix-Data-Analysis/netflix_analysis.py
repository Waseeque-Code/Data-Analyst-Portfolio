"""
Netflix Data Analysis - Question 1
Author: Waseeque Ahmad
Date: January 2026

Question: Data Quality Check - Understanding missing value patterns
"""

import pandas as pd
import numpy as np 
import matplotlib.pyplot as plt
import seaborn as sns

# Load dataset from data folder
df = pd.read_csv("data/netflix_titles.csv")

print("="*85)
print("QUESTION 1: DATA QUALITY CHECK - MISSING VALUE PATTERNS")
print("="*85)

# 1. Null values count
print("\n1️⃣ Null Values Count by Column:")
print("-"*85)
print(df.isnull().sum())

# 2. Total rows
print("\n2️⃣ Total Rows in Dataset:")
print("-"*85)
total_row = len(df)
print(f"Total Records: {total_row:,}")

# 3. Null percentage
print("\n3️⃣ Null Percentage by Column:")
print("-"*85)
null_percentage = (df.isnull().sum()/total_row)*100
print(null_percentage)

# 4. Summary table
print("\n4️⃣ SUMMARY TABLE (Sorted by Highest Null %):")
print("-"*85)

null_summary = pd.DataFrame({
    "Column_Name": df.columns,
    "Null_Count": df.isnull().sum().values,
    "Null_Percentage": round((df.isnull().sum()/len(df))*100, 2).values
})

# Sort by highest null percentage
null_summary = null_summary.sort_values("Null_Percentage", ascending=False)
print(null_summary.to_string(index=False))

print("\n" + "="*85)
print("KEY FINDINGS:")
print("="*85)
print("• Director column has highest missing values (30%)")
print("• Cast and Country columns also have significant nulls")
print("• Date_added and Rating have minimal missing data")
print("• Most content metadata is well-documented")
print("="*85)
print("\n✓ Question 1 Analysis Complete!")
```

---
