import pandas as pd
import numpy as np

df = pd.read_csv('messy_dataset.csv')
print(f"Checking : {df.head()}")

# CUSTOMER_ID CLEANING : 

# Drop missing Customer_ID
df = df.dropna(subset=['Customer_ID'])
print(f"Customer_ID after dropping missing values : {df['Customer_ID'].count()}")

# Handle Duplicate values in Customer_ID
total_duplicate_in_customer_id = df['Customer_ID'].duplicated().sum()
print(f"Total Duplicate rows in Customer_ID : {total_duplicate_in_customer_id}")
df = df.drop_duplicates(subset=['Customer_ID'], keep='first')
print(f"Customer_ID after dropping duplicates : {df['Customer_ID'].count()}")

# Change Data type 
df['Customer_ID'] = df['Customer_ID'].astype(str)
print(f"Customer_ID data type after conversion : {df['Customer_ID'].dtype}")

# Standardize Customer_ID 
df['Customer_ID'] = df['Customer_ID'].str.strip().str.upper()

print(f"Customer_ID after cleaning : {df['Customer_ID'].head()}")
df['Customer_ID'].str.len().value_counts()
df['Customer_ID'] = df['Customer_ID'].str.replace("-", "").str.replace("_", "")
df['Customer_ID'] = df['Customer_ID'].str.strip()
print("Any spaces left:", df['Customer_ID'].str.contains(" ").sum())
print(df['Customer_ID'].head(10))
print(f"Unique Values : {df['Customer_ID'].nunique()}")

# FULL_NAME CLEANING : 

# Handle Missing values 
print(df['Full_Name'].nunique())
df['Full_Name'] = df['Full_Name'].fillna('Not mentioned')
missing_values = df['Full_Name'].isnull().sum()
print(f"Missing values after filling : {missing_values}")

# Data type conversion
df['Full_Name'] = df['Full_Name'].astype(str)
print(f"Full_Name after conversion : {df['Full_Name'].dtype}")

# Standardize Full_Name
df['Full_Name'] = df['Full_Name'].str.strip().str.title()
df['Full_Name'] = df['Full_Name'].str.replace(",", "")
print(df['Full_Name'].unique())
print(f"Full_Name after cleaning : {df['Full_Name'].head(10)}")

# EMAIL CLEANING :

# Handle Missing values 
df['Email'] = df['Email'].fillna('Not provided')
missing_emails = df['Email'].isnull().sum()
print(f"Missing values after filling : {missing_emails}")

# Data type conversion
df['Email'] = df['Email'].astype(str)
print(f"Email after conversion : {df['Email'].dtype}")

# Standardize Email
df['Email'] = df['Email'].str.strip().str.lower()
print(f"Email after cleaning : {df['Email'].head(10)}")

# Duplicate emails 
drop_dupp = df['Email'].duplicated().sum()
print(f"Duplicate emails : {drop_dupp}")

invalid_emails = df[~df['Email'].str.match(r'^[\w\.-]+@[\w\.-]+\.\w+$') & (df['Email'] != 'not provided')]
print("Invalid Emails:\n", invalid_emails['Email'])

# Replace invalid emails with 'Invalid'
df.loc[~df['Email'].str.match(r'^[\w\.-]+@[\w\.-]+\.\w+$') & (df['Email'] != 'not provided'), 'Email'] = 'Invalid'

print(df['Email'].head(20))
print(f"Unique Emails : {df['Email'].nunique()}")
print("Invalid count:", (df['Email'] == 'Invalid').sum())
print("Not provided count:", (df['Email'] == 'not provided').sum())

# PHONE CLEANING : 

# Handle missing values 
total_missing_phone = df['Phone'].isnull().sum()
print(f"Total missing values in Phone : {total_missing_phone}")

df['Phone'] = df['Phone'].fillna('notprovided')
print(f"Total missing values in Phone after filling : {df['Phone'].isnull().sum()}")

# Data type conversion
df['Phone'] = df['Phone'].astype(str)
print(f"Phone type : {df['Phone'].dtype}")

# Stardardize phone
df['Phone'] = df['Phone'].str.strip().str.replace("-", "").str.replace(" ", "").str.replace(".", "").str.replace("_", "").str.replace("(", "").str.replace(")", "").str.replace("+1", "").str.replace("+91", "").str.replace("+44", "").str.replace('[', "").str.replace("]", "")
print(f"Phone after stardardization : {df['Phone'].head(30)}")

# Detect invalid phones
invalid_phones = df[~df['Phone'].str.match(r'^\+?\d{7,15}$') & (df['Phone'] != 'notprovided')]
print("Invalid Phones:\n", invalid_phones['Phone'])

# CLEANING CITY

# Handle missing values 
missing_city = df['City'].isnull().sum()
print(f"Total missing values in City : {missing_city}")

df['City'] = df['City'].fillna('Not_mentioned')

# Data type conversion 
df['City'] = df['City'].astype(str)
print(f"City type : {df['City'].dtype}")

# Standardize City
df['City'] = df['City'].str.strip().str.title()

# Mapping dictionary for variation
city_mapping = {
    'Nyc': 'New York',
    'La': 'Los Angeles',
    'Unknown': 'Not_mentioned'
}
df['City'] = df['City'].replace(city_mapping)
print(f"City after stardardization : {df['City'].head(30)}")
print(df['City'].unique())

# Step 1: Handle missing values
df['Membership_Status'] = df['Membership_Status'].fillna('Not_mentioned')

# Step 2: Convert to string + lowercase + strip
df['Membership_Status'] = df['Membership_Status'].astype(str).str.strip().str.lower()

# Step 3: Mapping dictionary (simplified)
mapping_mem_status = {
    'active': 'Active',
    'inactive': 'Inactive',
    'gold': 'Gold',
    'gld': 'Gold',
    'silver': 'Silver',
    'slvr': 'Silver',
    'bronze': 'Bronze',
    'not_mentioned': 'Not_mentioned'
}

# Step 4: Apply mapping
df['Membership_Status'] = df['Membership_Status'].replace('', 'Not_mentioned')
df['Membership_Status'] = df['Membership_Status'].replace(mapping_mem_status)

# Step 5: Summary check
print(df['Membership_Status'].unique())
print(df['Membership_Status'].value_counts())

# CLEANING DATA_OF_BIRTH

print(df['Date_of_Birth'].unique())
print(df['Date_of_Birth'].value_counts())
print(df['Date_of_Birth'].unique()[:10])

df['Date_of_Birth'] = df['Date_of_Birth'].astype(str).str.strip()
df['Date_of_Birth'] = df['Date_of_Birth'].replace(['', 'nan', 'NAN', 'NULL', 'N/A'], pd.NA)
print(df['Date_of_Birth'].dtype)

df['Date_of_Birth'] = pd.to_datetime(df['Date_of_Birth'], format='mixed', dayfirst=True, errors='coerce')

failed = df[df['Date_of_Birth'].isna()]
print(f"{len(failed)} rows failed")
print(failed)
print(df['Date_of_Birth'].dtype)
print(df['Date_of_Birth'].min(), df['Date_of_Birth'].max())
print(df['Date_of_Birth'].sample(20))

# CLEANING PURCHASE AMOUNT

print(df['Purchase_Amount'].sample(20))
print(df['Purchase_Amount'].unique())

# Handle missing values 
print(df['Purchase_Amount'].isnull().sum())
df['Purchase_Amount'] = df['Purchase_Amount'].replace({'USD':'','FREE':None,'\$':''}, regex=True)

# Convert to numeric
df['Purchase_Amount'] = pd.to_numeric(df['Purchase_Amount'], errors='coerce')
df.loc[df['Purchase_Amount'] < 0, 'Purchase_Amount'] = np.nan

# Outlier
Q1 = df['Purchase_Amount'].quantile(0.25)
Q3 = df['Purchase_Amount'].quantile(0.75)
IQR = Q3 - Q1
lower = Q1 - 1.5 * IQR 
Upper = Q3 + 1.5 * IQR 
outliers = df[(df['Purchase_Amount'] < lower) | (df['Purchase_Amount'] > Upper)]
print("Outlier count :", outliers.shape[0])
print(outliers.head())

# Cap value
df['Purchase_Amount'] = df['Purchase_Amount'].clip(lower, Upper)

df['Purchase_Amount'] = df['Purchase_Amount'].round(2)
print(df['Purchase_Amount'].dtype)
print(df['Purchase_Amount'].sample(20))

# CLENAING JOIN_DATE COLUMN

# Missing values
total_missing_dates = df['Join_Date'].isnull().sum()
print(f"Total missing dates : {total_missing_dates}")
print(f"Unique values : {df['Join_Date'].unique()}")

# Replace values 
df['Join_Date'] = df['Join_Date'].astype(str).str.strip()
df['Join_Date'] = df['Join_Date'].replace({'TBD' : None}, regex=True)

# Convert to datetime
df['Join_Date'] = pd.to_datetime(df['Join_Date'], dayfirst=True, errors='coerce')
failed = df[df['Join_Date'].isna()]
print(f"{len(failed)} rows fail.")
print(failed)
print(df['Join_Date'].dtype)

print(df['Join_Date'].sample(20))

# CLEANING SATISFACTION SCORE

print(f"Unique values : {df['Satisfaction_Score'].unique()}")

# Missing values 
missing_values = df['Satisfaction_Score'].isnull().sum()
print(f"Total missing values : {missing_values}")
print(f"Statisfaction_Score data type : {df['Satisfaction_Score'].dtype}")

# Convert to numeric
df['Satisfaction_Score'] = pd.to_numeric(df['Satisfaction_Score'], errors='coerce')
print(df['Satisfaction_Score'].dtype)   # float64
print(df['Satisfaction_Score'].value_counts())
print(df['Satisfaction_Score'].sample(20))

df.to_csv('Cleaned_through_python.csv', index=False)
print("CSV Saved!")