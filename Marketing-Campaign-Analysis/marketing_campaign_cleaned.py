import pandas as pd
import numpy as np

df = pd.read_csv('marketing_campaign_dataset.csv')
print('Shape :', df.shape)
print('Columns :', list(df.columns))
print('\nData Types :\n', df.dtypes)
print('\nMissing Values :\n', df.isnull().sum())
print('\nDuplicate Rows :\n', df.duplicated().sum())
print('\nFirst 5 Rows :\n', df.head())
print('\nBasic Stats :\n', df.describe())

df['Acquisition_Cost'] = df['Acquisition_Cost'].str.replace('$', '', regex=False)
df['Acquisition_Cost'] = df['Acquisition_Cost'].str.replace(',', '', regex=False)
df['Acquisition_Cost'] = df['Acquisition_Cost'].astype(float)

df['Duration'] = df['Duration'].str.replace(' days', '', regex=False)
df['Duration'] = df['Duration'].astype(int)

df['Date'] = pd.to_datetime(df['Date'])

df['Year'] = df['Date'].dt.year
df['Month'] = df['Date'].dt.month

print('\nData types after cleaning :\n', df.dtypes)
print('\nAcquisition Cost Sample :\n', df['Acquisition_Cost'].head())
print('\nDuration Sample :\n', df['Duration'].head())

df.to_csv('marketing_campaign_cleaned.csv', index=False)
print("Saved!")