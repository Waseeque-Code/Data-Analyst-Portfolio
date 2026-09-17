import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Load data

df = pd.read_csv('Zomato Dataset.csv')
print(f'First 5 rows : {df.head(5)}')

# Basic Understanding

print(df.info())

# Missing values 

print('Missing values :')
print(df.isnull().sum())

# Delivery_person_ID Column
df['Delivery_person_Age'] = df['Delivery_person_Age'].fillna(df['Delivery_person_Age'].median())
print('Delivery Person ID After filling :')
print(df['Delivery_person_Age'].isnull().sum())

print('Categorical Data :')
print(df['Delivery_person_Age'].value_counts())

# Delivery_person_Ratings

df.loc[(df['Delivery_person_Ratings'] < 1) | (df['Delivery_person_Ratings'] > 5), 'Delivery_person_Ratings'] = np.nan

df['Delivery_person_Ratings'] = df['Delivery_person_Ratings'].fillna(df['Delivery_person_Ratings'].median())

print('Total missing values after filling :')
print(df['Delivery_person_Ratings'].isnull().sum())

print('Categorical Data :')
print(df['Delivery_person_Ratings'].value_counts())

# Time_Orderd

def fix_time(val):
    if pd.isna(val):
        return np.nan
    val = str(val).strip()
    if ':' in val:
        return val  # already "21:55" format
    try:
        num = float(val)
        if 0 <= num < 1:
            total_min = int(round(num * 24 * 60))
            h, m = divmod(total_min, 60)
            return f"{h:02d}:{m:02d}"
        elif num == 1:
            return "00:00"
    except:
        return np.nan
    return np.nan

df['Time_Orderd'] = df['Time_Orderd'].apply(fix_time)
print(df['Time_Orderd'].sample(20))

print(df['Time_Orderd'].head(20).tolist())
print(df['Time_Orderd'].isnull().sum())

df['Time_Orderd'] = df['Time_Orderd'].fillna(df['Time_Orderd'].mode()[0])
print('After filling :')
print(df['Time_Orderd'].isnull().sum())
print(df['Time_Orderd'].head(20))

print(df.isnull().sum())

# Weather Condiditon

print(df['Weather_conditions'].value_counts())
print(df['Weather_conditions'].dtype)

df['Weather_conditions'] = df['Weather_conditions'].fillna(df['Weather_conditions'].mode()[0])
print(f'After filling : {df['Weather_conditions'].isnull().sum()}')
print(f'After filling : \n{df['Weather_conditions'].value_counts()}')

print(df.isnull().sum())

# Road_traffic_density 

print(df['Road_traffic_density'].value_counts())
print(df['Road_traffic_density'].dtype)

df['Road_traffic_density'] = df['Road_traffic_density'].fillna(df['Road_traffic_density'].mode()[0])
print(f'Missing values after filling : \n{df['Road_traffic_density'].isnull().sum()}')
print(f'After filling : \n{df['Road_traffic_density'].value_counts()}')

print(df.isnull().sum())

# multiple_deliveries 

print(df['multiple_deliveries'].value_counts())
print(df['multiple_deliveries'].dtype)

df['multiple_deliveries'] = df['multiple_deliveries'].fillna(df['multiple_deliveries'].median())
print(f'After handling missing values : \n{df['multiple_deliveries'].isnull().sum()}')
print(f'After filling : \n{df['multiple_deliveries'].value_counts()}')

print(df.isnull().sum())

# Festival

print(df['Festival'].value_counts())

df['Festival'] = df['Festival'].fillna(df['Festival'].mode()[0])
print(f'After filling : {df['Festival'].isnull().sum()}')
print(f'After filling : {df['Festival'].value_counts()}')

print(df.isnull().sum())

print(df['City'].value_counts())
df['City'] = df['City'].fillna(df['City'].mode()[0])
print(f'After filling : {df['City'].isnull().sum()}')
print(f'After filling : {df['City'].value_counts()}')

print(df.isnull().sum())

# EXPLORATORY DATA ANALYSIS

# Univeriate Analysis

#1. Time_Taken
plt.figure(figsize=(12, 4))

plt.subplot(1, 2, 1)
sns.histplot(df['Time_taken (min)'], bins=30, kde=True)
plt.title('Distribution of Time Taken')
plt.xlabel('Time Taken (Minutes)')

plt.subplot(1, 2, 2)
sns.boxplot(x=df['Time_taken (min)'])
plt.title("Boxplot of Time Taken Min")

plt.tight_layout()

print(df['Time_taken (min)'].describe())
plt.savefig('Hist + Box.png', dpi=100, bbox_inches='tight')
plt.show()

#2. Delivery_person_Age

print("Age < 18:", (df['Delivery_person_Age'] < 18).sum())
print(df[df['Delivery_person_Age'] < 18]['Delivery_person_Age'].value_counts())

df.loc[df['Delivery_person_Age'] < 18, "Delivery_person_Age"] = np.nan

df['Delivery_person_Age'] = df['Delivery_person_Age'].fillna(df['Delivery_person_Age'].median())
print(f'Missing : {df['Delivery_person_Age'].isnull().sum()}')
print("Age < 18:", (df['Delivery_person_Age'] < 18).sum()) 

plt.figure(figsize=(10, 4))
sns.histplot(df['Delivery_person_Age'], bins=25, kde=True)
plt.title('Distribution of Delivery Person Age')
plt.xlabel("Age")
print(df['Delivery_person_Age'].describe())
plt.savefig('Age Distribution.png', dpi=100, bbox_inches='tight')
plt.show()

#3. Delivery Person Rating

plt.figure(figsize=(10, 4))
sns.histplot(df['Delivery_person_Ratings'], bins=25, kde=True)
plt.title("Distribution of Delivery Person Rating")
plt.xlabel('Ratings')
plt.savefig('Distribution of Delivery Person Rating.png', dpi=100, bbox_inches='tight')
print(df['Delivery_person_Ratings'].describe())
plt.show()

#4. Road Traffic Density

plt.figure(figsize=(10, 4))
order = ['Low', 'Medium', 'High', 'Jam']
sns.countplot(x='Road_traffic_density', data=df, order=order)
plt.title('Count of Road traffic density')
plt.savefig('Count of Road traffic density.png', dpi=100, bbox_inches='tight')
plt.show()
print(df['Road_traffic_density'].value_counts())

#5. Weather Condition

plt.figure(figsize=(12, 4))
sns.countplot(x='Weather_conditions', data=df)
plt.title('Count of Weather Condition')
plt.savefig('Count of Weather Condition.png', dpi=100, bbox_inches='tight')
plt.show()
print(df['Weather_conditions'].value_counts())

#6. Type_of_vehicle

plt.figure(figsize=(10, 4))
sns.countplot(x='Type_of_vehicle', data=df)
plt.title("Count of Type of vehicle")
plt.savefig("Type of vehicle.png", dpi=100, bbox_inches='tight')
plt.show() 

#7. Festival

plt.figure(figsize=(6, 4))
sns.countplot(x='Festival', data=df)
plt.title('Count of Festival')
plt.savefig('Festival.png', dpi=100, bbox_inches='tight')
plt.show()

# Bivariate Analysis

#1. Time_taken vs Road_traffic_density

plt.figure(figsize=(8, 5))
order = ['Low', 'Medium', 'High', 'Jam']
sns.boxplot(x='Road_traffic_density', y='Time_taken (min)', data=df, order=order)
plt.title('Time taken VS Road traffic density')
plt.savefig('Time vs Road traffic.png', dpi=100, bbox_inches='tight')
plt.show()

print(df.groupby('Road_traffic_density')['Time_taken (min)'].median())

#2. Time_taken vs Weather Conditions

plt.figure(figsize=(8, 5))
sns.boxplot(x = 'Weather_conditions', y='Time_taken (min)', data=df)
plt.title('Time Taken VS Weather Condition')
plt.savefig('Time vs Weather conditions.png', dpi=100, bbox_inches='tight')
plt.show()

print(df.groupby('Weather_conditions')['Time_taken (min)'].median())

#3. Time_taken vs Type of Vehicle

plt.figure(figsize=(8, 5))
sns.boxplot(x = 'Type_of_vehicle', y='Time_taken (min)', data=df)
plt.title('Time Taken VS Vehicle Type')
plt.savefig('Time vs Vehicle.png', dpi=100, bbox_inches='tight')
plt.show()

print(df.groupby('Type_of_vehicle')['Time_taken (min)'].median())

#4. Time_taken vs Festival

plt.figure(figsize=(8, 5))
sns.boxplot(x = 'Festival', y='Time_taken (min)', data=df)
plt.title('Time VS Festival')
plt.savefig('Time vs Festival.png', dpi=100, bbox_inches='tight')
plt.show()

print(df.groupby('Festival')['Time_taken (min)'].median())

#5. Multiple Deliveries vs Time taken

plt.figure(figsize=(8, 5))
sns.boxplot(x = 'multiple_deliveries', y='Time_taken (min)', data=df)
plt.title('Time Taken vs Multiple Deliveries')
plt.savefig('Time vs multi_deli.png', dpi=100, bbox_inches='tight')
plt.show()

print(df.groupby('multiple_deliveries')['Time_taken (min)'].median())

#6. Delivery Age Person vs Time taken

plt.figure(figsize=(10, 5))
sns.scatterplot(x = 'Delivery_person_Age', y= 'Time_taken (min)', data=df, alpha=0.3)
plt.title('Time Taken VS Delivery Person Age')
plt.savefig('Time vs Delivery_perosn_age.png', dpi=100, bbox_inches='tight')
plt.show()

print("Correlation:", df['Delivery_person_Age'].corr(df['Time_taken (min)']))

#7. Correlation

plt.figure(figsize=(10, 8))
sns.heatmap(df.corr(numeric_only=True), annot=True, cmap='coolwarm', fmt='.2f')
plt.title('Correlation Matrix')
plt.savefig('Correlation_Matrix.png', dpi=100, bbox_inches='tight')
plt.show()

#8. Time-based Pattern

df['Order_Hour'] = pd.to_datetime(df['Time_Orderd'], format='%H:%M', errors='coerce').dt.hour

print("NaN hours:", df['Order_Hour'].isnull().sum())
print(df['Order_Hour'].describe())

# Hour-wise average Time_taken
hourly = df.groupby('Order_Hour')['Time_taken (min)'].mean()

plt.figure(figsize=(12, 5))
sns.lineplot(x=hourly.index, y=hourly.values, marker='o')
plt.title("Hour-wise Average Time_taken")
plt.xlabel("Hour of Day")
plt.ylabel("Avg Time_taken (min)")
plt.xticks(range(0, 24))
plt.grid(True)
plt.savefig("hourly_pattern.png", dpi=100, bbox_inches='tight')
plt.show()

print(hourly)

Q1 = df['Time_taken (min)'].quantile(0.25)
Q3 = df['Time_taken (min)'].quantile(0.75)
IQR = Q3 - Q1

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR

print(f'Q1 : {Q1}')
print(f'Q3 : {Q3}')
print(f'IQR : {IQR}')
print(f'Lower bound : {lower_bound}')
print(f'Upper bound : {upper_bound}')

# Outlier Count
outliers = df[(df['Time_taken (min)'] < lower_bound) | (df['Time_taken (min)'] > upper_bound)]
print(f"\nTotal Outliers : {len(outliers)} ({len(outliers)/len(df)*100:.2f}%)")

# Boxplot
plt.figure(figsize=(8, 4))
sns.boxplot(x=df['Time_taken (min)'])
plt.title('Boxplot - Time taken with outliers')
plt.savefig('Outliers.png', dpi=100, bbox_inches='tight')
plt.show()

df.to_csv('zomato_cleaned.csv', index=False)
print("Saved! Shape:", df.shape)

df.to_csv('zomato_cleaned.csv', index=False)
print("Saved! Shape:", df.shape)