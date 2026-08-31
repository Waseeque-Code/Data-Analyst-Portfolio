import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv('Value_of_Production_E_All_Data_(Normalized).csv', low_memory=False)
print(f"Total Rows : {df.shape[0]}")
print(f"Total Columns : {df.shape[1]}")
print("\nColumns :")
print(df.columns.tolist())
print(f"First 5 rows : {df.head()}")

# FILTER INDIA
india = df[df['Area'] == 'India']
print("Rows of India : ", len(india))
print(india['Element'].unique())
print(india['Year'].min(), "-", india['Year'].max())
print(india['Item'].head(10))

# Top 10 major crops (Items) in India by total value
top_crops = india[india['Element'] == 'Gross Production Value (current thousand US$)']
top_crops = top_crops.groupby('Item')['Value'].sum().sort_values(ascending=False).head(10)
print(top_crops)