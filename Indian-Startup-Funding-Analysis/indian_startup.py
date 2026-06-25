


import pandas as pd
import numpy as np

#  Load 
df = pd.read_csv('startup_funding.csv')
print("Original Shape:", df.shape)
print("\nMissing Values:\n", df.isnull().sum())

# Drop useless column 
df = df.drop(columns=['Remarks', 'SNo'])

#  Fill nulls 
df['IndustryVertical'] = df['IndustryVertical'].fillna('Other')
df['SubVertical']      = df['SubVertical'].fillna('Other')
df['CityLocation']     = df['CityLocation'].fillna('Unknown')
df['InvestorsName']    = df['InvestorsName'].fillna('Not Disclosed')
df['InvestmentType']   = df['InvestmentType'].fillna('Not Specified')
df['AmountInUSD']      = df['AmountInUSD'].fillna('0')

#  AmountInUSD - clean numeric
df['AmountInUSD'] = df['AmountInUSD'].str.replace(',', '', regex=False)
df['AmountInUSD'] = df['AmountInUSD'].astype(float)
df['AmountInUSD'] = df['AmountInUSD'].replace(0, np.nan)

#  Date - datetime 
df['Date'] = df['Date'].str.replace('.', '/', regex=False)
df['Date'] = pd.to_datetime(df['Date'], format='%d/%m/%Y', errors='coerce')
df['Date'] = df['Date'].fillna(pd.Timestamp('2015-01-01'))

#  Extract Year & Month 
df['Year']  = df['Date'].dt.year
df['Month'] = df['Date'].dt.month

#  Remove duplicates 
before = len(df)
df = df.drop_duplicates()
print(f"\nDuplicates Removed: {before - len(df)}")

#  Final check 
print("\nCleaned Shape:", df.shape)
print("\nMissing Values After Cleaning:\n", df.isnull().sum())
print("\nData Types:\n", df.dtypes)
print("\nAmount Stats:\n", df['AmountInUSD'].describe())

#  Save 
df.to_csv('startup_funding_cleanedd.csv', index=False)
print("\nCleaned data saved as 'startup_funding_cleanedd.csv'")
