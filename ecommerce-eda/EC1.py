import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import warnings
warnings.filterwarnings('ignore')

plt.style.use('seaborn-v0_8')
sns.set_palette('husl')

df = pd.read_csv('online_retail_II.csv')
print("Shape:", df.shape)
print("\nFirst 5 rows:")
print(df.head())

#Initial Exploration

print("=== DATASET TNFO ===")
print(df.info())
print("\n=== BASIC STATISTICS ===")
print(df.describe())
print("\n=== NULL VALUES ===")
print(df.isnull().sum())
print("\n=== NULL PERCENTAGE ===")
print(round(df.isnull().sum()/len(df)*100, 2))

#Data Cleaning

print("Shape BEFORE cleaning:", df.shape)

#Drop rows with missing Customer ID 
df.dropna(subset=['Customer ID'], inplace=True)

#Drop rows with missing Description
df.dropna(subset=['Description'], inplace=True)

#Remove cancelled orders (Invoice starts with "C")
df = df[~df['Invoice'].astype(str).str.startswith('C')]

#Remove negative or zero Quantity
df = df[df['Quantity'] > 0]

#Remove Duplicates
df.drop_duplicates(inplace=True)

#Fix data types
df['InvoiceDate'] = pd.to_datetime(df['InvoiceDate'])
df['Customer ID'] = df['Customer ID'].astype(str)

#Create new useful columns

df['TotalPrice'] = df['Quantity'] * df['Price']
df['Month'] = df['InvoiceDate'].dt.to_period('M')
df['DayOfWeek'] = df['InvoiceDate'].dt.day_name()
df['Hour'] = df['InvoiceDate'].dt.hour

print("Shape AFTER cleaning:", df.shape)
print("\nCleaned Data Sample:")
print(df.head())

#Basic EDA

print("\n=== KEY BUSINESS METRICS ===")
print(f"Total Orders : {df['Invoice'].nunique():,}")
print(f"Total Customers : {df['Customer ID'].nunique():,}")
print(f"Total Products : {df['StockCode'].nunique():,}")
print(f"Total Revenue : {df['TotalPrice'].sum():,.2f}")
print(f"Avg Order Value : {df.groupby('Invoice')['TotalPrice'].sum().mean():,.2f}")
print(f"Date Range : {df['InvoiceDate'].min().date()} to {df['InvoiceDate'].max().date()}")
print(f"Countries : {df['Country'].nunique()}")

#Top Products

#Top 10 Products by renvenue
top_products = (df.groupby('Description')['TotalPrice']
                .sum()
                .sort_values(ascending=False)
                .head(10)
                .reset_index())
top_products.columns = ['Product', 'Revenue']

plt.figure(figsize=(12, 6))
sns.barplot(data=top_products, x='Revenue', y='Product', palette='viridis')
plt.title('Top 10 Products by Revenue', fontsize=16, fontweight='bold')
plt.xlabel('Total Revenue')
plt.ylabel('')
plt.tight_layout()
plt.savefig('top_product.png', dpi=150)
plt.show()
print(top_products)

#Monthly Revenue Trend

monthly_revenue = df.groupby('Month')['TotalPrice'].sum().reset_index()
monthly_revenue['Month'] = monthly_revenue['Month'].astype(str)

plt.figure(figsize=(14, 5))
plt.plot(monthly_revenue['Month'], monthly_revenue['TotalPrice'],
         marker='o', linewidth=2.5, color='steelblue', markersize=7)
plt.fill_between(range(len(monthly_revenue)), monthly_revenue['TotalPrice'], alpha=0.2)
plt.xticks(range(len(monthly_revenue)), monthly_revenue['Month'], rotation=45)
plt.title('Monthly Revenue Trend', fontsize=16, fontweight='bold')
plt.xlabel('Month')
plt.ylabel('Total Revenue')
plt.tight_layout()
plt.savefig('monthly_trend.png', dpi=150)
plt.show()
print(monthly_revenue)

#Sales by Day of Week

day_order = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
day_sales = df.groupby('DayOfWeek')['TotalPrice'].sum().reindex(day_order)

plt.figure(figsize=(10, 5))
sns.barplot(x=day_sales.index, y=day_sales.values, palette='coolwarm')
plt.title('Revenue by Day of Week', fontsize=16, fontweight='bold')
plt.xlabel('Day')
plt.ylabel('Total Revenue')
plt.tight_layout()
plt.savefig('day_of_week.png', dpi=150)
plt.show()
print(day_sales)

print('\n')
top_countries = (df[df['Country'] != 'United Kingdom']
                 .groupby('Country')['TotalPrice']
                 .sum()
                 .sort_values(ascending=False)
                 .head(10))

plt.figure(figsize=(10, 5))
sns.barplot(x=top_countries.values, y=top_countries.index, palette='magma')
plt.title('Top 10 Countries by Revenue (Excl. UK)', fontsize=16, fontweight='bold')
plt.xlabel('Total Revenue')
plt.ylabel('')
plt.tight_layout()
plt.savefig('top_countries.png', dpi=150)
plt.show()

print(top_countries)

#RFM Customer Segmentation

reference_date = df['InvoiceDate'].max() + pd.Timedelta(days=1)

rfm = df.groupby('Customer ID').agg(
    Recency = ('InvoiceDate', lambda x: (reference_date - x.max()).days),
    Frequency = ('Invoice', 'nunique'),
    Monetary = ('TotalPrice', 'sum')
).reset_index()

#Score each metric 1-5

rfm['R_Score'] = pd.qcut(rfm['Recency'], 5, labels=[5,4,3,2,1])
rfm['F_Score'] = pd.qcut(rfm['Frequency'].rank(method='first'), 5, labels=[1,2,3,4,5])
rfm['M_Score'] = pd.qcut(rfm['Monetary'], 5, labels=[1,2,3,4,5])

rfm['RFM_Score'] = rfm['R_Score'].astype(str) + rfm['F_Score'].astype(str) + rfm['M_Score'].astype(str)
rfm['RFM_Total'] = rfm[['R_Score', 'F_Score', 'M_Score']].astype(int).sum(axis=1)

#Segment customers

def segment(score):
    if score >= 13:
        return 'Champions'
    elif score >= 10:
        return 'Loyal Customers'
    elif score >= 7:
        return 'Potential Loyalists'
    elif score >= 5:
        return 'At Risk'
    else:
        return 'Lost Customers'

rfm['Segment'] = rfm['RFM_Total'].apply(segment)

print("=== RFM SEGMENTS ===")
print(rfm['Segment'].value_counts())
print("\nRFM Table Sample:")
print(rfm.head())

#RFM Segment Distribution Plot

segment_order = ['Champions', 'Loyal Customers', 'Potential Loyalists', 'At Risk', 'Lost Customers']
seg_counts = rfm['Segment'].value_counts().reindex(segment_order)
seg_revenue = rfm.groupby('Segment')['Monetary'].sum().reindex(segment_order)

fig, axes = plt.subplots(1, 2, figsize = (16,6))

#Plot 1 - Cusotmer Count

colors = ['#2ecc71', '#3498db', '#f39c12', '#e74c3c', '#95a5a6']
axes[0].bar(seg_counts.index, seg_counts.values, color=colors)
axes[0].set_title('Customer Count by Segment', fontsize=14, fontweight='bold')
axes[0].set_xlabel('Segment')
axes[0].set_ylabel('Number of Customers')
axes[0].tick_params(axis='x', rotation=30)
for i, v in enumerate(seg_counts.values):
    axes[0].text(i, v+20, str(v), ha='center', fontweight='bold', )

#Plot 2 - Revenue by Segment

axes[1].bar(seg_revenue.index, seg_revenue.values, color=colors)
axes[1].set_title('Total Revenue by Segment', fontsize=14, fontweight='bold')
axes[1].set_xlabel('Segment')
axes[1].set_ylabel('Revenue')
axes[1].tick_params(axis='x', rotation=30)
for i, v in enumerate(seg_revenue.values):
    axes[1].text(i, v+5000, f'{v:,.0f}', ha='center', fontsize=8, fontweight='bold')
plt.tight_layout()
plt.savefig('rfm_segment.png', dpi=150)
plt.show()

#RFM Scatter Plot (Recency vs Monetory)
plt.figure(figsize=(12,7))
colors_map = {
    'Champions' : '#2ecc71',
    'Loyal Customers' : '#3498db',
    'Potential Loyalists' : '#f39c12',
    'At Risk' : '#e74c3c',
    'Lost Customers' : '#95a5a6'
}
for segment, group in rfm.groupby('Segment'):
    plt.scatter(group['Recency'], group['Monetary'],
                label=segment, alpha=0.6, s=50,
                color=colors_map[segment])
    
plt.title('Customer Segments - Recency vs Monetory Value', fontsize=14, fontweight='bold')
plt.xlabel('Recency (Days since last purchase)')
plt.ylabel('Total Spend')
plt.legend(title='Segment')
plt.savefig('rfm_scatter.png', dpi=150)
plt.show()

#Revenue Distribution

fig, axes = plt.subplots(1, 2, figsize=(14, 5))

#Customer spend distribution

axes[0].hist(rfm['Monetary'], bins=50, color='steelblue', edgecolor = 'white')
axes[0].set_title('Customer Spend Distribution', fontsize=13, fontweight='bold')
axes[0].set_xlabel('Total Spend')
axes[0].set_ylabel('Number of Customers')

#Log scale version

axes[1].hist(np.log1p(rfm['Monetary']), bins=50, color='coral', edgecolor='white')
axes[1].set_title('Customer Spend Distribution (Log Scale)', fontsize=13, fontweight='bold')
axes[1].set_xlabel('Log(Total Spend)')
axes[1].set_ylabel('Number of Customers')

plt.tight_layout()
plt.savefig('spend_distribution.png', dpi=150)
plt.show()

#Yearly Revenue Comparison (2010 vs 2011)

df['Year'] = df['InvoiceDate'].dt.year
df['MonthNum'] = df['InvoiceDate'].dt.month

yearly = df[df['Year'].isin([2010, 2011])].groupby(['Year', 'MonthNum'])['TotalPrice'].sum().reset_index()
y2010 = yearly[yearly['Year']==2010]
y2011 = yearly[yearly['Year']==2011]

months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

plt.figure(figsize=(14, 6))
plt.plot(y2010['MonthNum'], y2010['TotalPrice'], marker='o', label='2010', linewidth=2.5, color='steelblue')
plt.plot(y2011['MonthNum'], y2011['TotalPrice'], marker='o', label='2011', linewidth=2.5, color='coral')
plt.xticks(range(1, 13), months)
plt.title('Monthly Revenue : 2010 vs 2011', fontsize=15, fontweight='bold')
plt.xlabel('Month')
plt.ylabel('Revenue')
plt.legend(fontsize=12)
plt.tight_layout()
plt.savefig('yearly_comparison.png', dpi=150)
plt.show()

#Top 10 Customers

top_customers = rfm.sort_values('Monetary', ascending=False).head(10)[
    ['Customer ID', 'Recency', 'Frequency', 'Monetary', 'Segment']
]
top_customers['Monetary'] = top_customers['Monetary'].map('{:,.2f}'.format)
print("=== TOP 10 CUSTOMERS BY REVENUE ===")
print(top_customers.to_string(index=False))

#Correlation Heatmap

plt.figure(figsize=(7, 5))
corr = rfm[['Recency', 'Frequency', 'Monetary']].corr()
sns.heatmap(corr, annot=True, fmt='.2f', cmap='coolwarm',
            square=True, linewidth=0.5, annot_kws={'size':13})
plt.title('RFM Correlation Heatmap', fontsize=14, fontweight='bold')
plt.tight_layout()
plt.savefig('rfm_heatmap.png', dpi=150)
plt.show()

df.to_csv('cleaned_ecommerce.csv', index=False)
rfm.to_csv('rfm_segments.csv', index=False)
print("Files saved successfully!")