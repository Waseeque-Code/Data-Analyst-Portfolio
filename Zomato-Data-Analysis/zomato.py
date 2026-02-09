#ZOMATO DATA ANALYSIS

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

print("="*60)
print("STEP 1 : LOADING DATA")
print("="*60)

#Load the data

df = pd.read_csv('reviews.csv')

#First look at the data

print("\nFirst 5 rows :")
print(df.head())

print("n\Dataset Shape:")
print(df.shape)

print("n\Dataset Info:")
print(df.info())

print("\n" + "="*60)
print("STEP 2 : DATA CLEANING")
print("="*60)

#1. Checking for missing values

print("\nMissing Values:")
print(df.isnull().sum())

#2. Check for duplicate

print(f"\nDuplicates : {df.duplicated().sum()}")

#3. Remove duplicate if any

df = df.drop_duplicates()
print(f"After removing duplicates : {df.shape}")

#4. Look at unique values in categorical columns

print("\nCity Distribution :")
print(df['City'].value_counts())

print("\nCuisine Distribution (Top 10) :")
print(df['Cuisine'].value_counts().head(10))

#4. Clean 'Rate for two' column (remove ₹ or commas if present)

print("\nBefore cleaning Rate for two : ")
print(df['Rate for two'].head())

#Clean it 

df['Rate for two'] = pd.to_numeric(df['Rate for two'], errors = 'coerce')

print("\nAfter cleaning Rate for two : ")
print(df['Rate for two'].head())

print("\n" + "="*60)
print("STEP 3 : BASIC STATISTICS")
print("="*60)

#Numerical stats

print("\nNumerical Statistics : ")
print(df.describe())

#Specific insights

df['Overall_Rating'] = pd.to_numeric(df['Overall_Rating'], errors="coerce")
print(f"\nAverage Rating : {df['Overall_Rating'].mean() :.2f}")
print(f"Median Rating : {df['Overall_Rating'].median():.2f}")
print(f"Average Cost for Two : ₹{df['Rate for two'].mean():.2f}")
print(f"Median Cost for Two : ₹{df['Rate for two'].median():.2f}")

#Categorical Analysis

print(f"\nTotal Cities : {df['City'].nunique()}")
print(f"Total Cuisines : {df['Cuisine'].nunique()}")
print(f"Total Restaurants : {len(df)}")
print(f"\nMost common city : {df['City'].mode()[0]}")
print(f"Most common cuisine : {df['Cuisine'].mode()[0]}")

print("\n" + "="*60)
print("STEP 4 : KEY INSIGHTS")
print("="*60)

print("\n1. Average rating across all restaurants:", f"{df['Overall_Rating'].mean():.2f}")
print("2. City with most restaurants:", df['City'].value_counts().index[0])
print("3. Most popular cuisine:", df['Cuisine'].value_counts().index[0])
print("4. Average cost for two:", f"₹{df['Rate for two'].mean():.2f}")

#Correlation between price and rating

correlation = df['Rate for two'].corr(df['Overall_Rating'])
print(f"5. Correlation between price and rating: {correlation:.3f}")

#City with highest average rating

city_ratings = df.groupby('City')['Overall_Rating'].mean().sort_values(ascending=False)
print(f"6. City with highest average rating: {city_ratings.index[0]}")

print("\n" + "="*60)
print("STEP 5 : CREATING VISUALIZATIONS")
print("="*60)

#Visualization 1 : Rating Distribution

plt.figure(figsize=(10, 6))
plt.hist(df['Overall_Rating'], bins=20, color='skyblue', edgecolor='black')
plt.title('Distribution of Overall Ratings', fontsize=14, fontweight='bold')
plt.xlabel('Rating')
plt.ylabel('Frequency')
plt.grid(axis='y', alpha=0.3)
plt.savefig('rating_distribution.png', dpi=300, bbox_inches='tight')
print("Saved : rating_distribution.png")
plt.close()

#Visualization 2 : Top Cities

plt.figure(figsize=(10, 6))
df['City'].value_counts().head(10).plot(kind='barh', color='coral', edgecolor='black')
plt.title('Top 10 Cities by Restaurant Count', fontsize=14, fontweight='bold')
plt.xlabel('Count')
plt.ylabel('City')
plt.grid(axis='x', alpha=0.3)
plt.tight_layout()
plt.savefig('top_cities.png', dpi=300, bbox_inches='tight')
print("Saved : top_cities.png")
plt.close()

#Visualization 3 : Price VS Rating

plt.figure(figsize=(10, 6))
plt.scatter(df['Rate for two'], df['Overall_Rating'], alpha=0.5, color='green')
plt.title('Price vs Rating', fontsize=14, fontweight='bold')
plt.xlabel('Cost for two (₹)')
plt.ylabel('Overall Rating')
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig('price_vs_rating.png', dpi=300, bbox_inches='tight')
print("Saved : price_vs_rating.png")
plt.close()

print("\n" + "="*60)
print("ANALYSIS COMPLETE")
print("="*60)
print("\nFiles Created:")
print("  . rating_distribution.png")
print("  . top_cities.png")
print("  . price_vs_rating.png")
