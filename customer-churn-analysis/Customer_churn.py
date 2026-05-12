import pandas as pd

df = pd.read_csv("Telco-Customer-Churn.csv")
print(df.head())
print(df.info())

# Total Customer
TotalCustomer = len(df)
print(f"\nTotalCustomers : {TotalCustomer}")

# Total Churned
Churned = (df['Churn'] == 'Yes').sum()
print(f"\nTotal Churn Customes : {Churned}")

# Churn Rate
Churn_rate = (Churned / TotalCustomer) * 100
print(f"\nChurn Rate : {Churn_rate}")

# Churn Rate according to Contact type
Contact_churn = df.groupby('Contract')['Churn'].apply(lambda x : (x == 'Yes').mean() * 100)
print(f"\nContact Churn Rate : {Contact_churn}" )

# Tenure group
df['tenure_group'] = pd.cut(df['tenure'],
                            bins=[0, 6, 12, 72],
                            labels = ['0-6 months', '7-12 months', '12+ months'])

#Tenure Rate
tenure_group = df.groupby('tenure_group')['Churn'].apply(lambda x: (x == 'Yes').mean() * 100)
print(f"\nTenure Group : {tenure_group}")

# Churn according to Payment method
payment_churn = df.groupby('PaymentMethod')['Churn'].apply(lambda x : (x == 'Yes').mean()*100)
print(f"\nPayment Churn : {payment_churn.sort_values(ascending=False)}")

# Churn according to Tech Tickets

tech_churn = df.groupby('TechSupport')['Churn'].apply(lambda x: (x == 'Yes').mean()*100)
print(f"\nTech Churn : {tech_churn}")

# Monthly contract + 0-6 months tenure

deadly_combo = df[(df['Contract'] == 'Month-to-month') & (df['tenure_group'] == '0-6 months')]
deadly_churn = (deadly_combo['Churn'] == 'Yes').mean() * 100
print(f"\nMonthly + New Customer (<6 months) Churn Rate: {deadly_churn:.2f}%")
print(f"\nTotal Customers in this group : {len(deadly_combo)}")

# Senior Citizen

senior_churn = df.groupby('SeniorCitizen')['Churn'].apply(lambda x: (x == 'Yes').mean() * 100)
print("\nSeniorCitizen (0=No, 1=Yes)")
print(f"Senior Citizen Churn : {senior_churn}")

# Monthly Charges Effect

df['Charge_group'] = pd.cut(df['MonthlyCharges'],
                            bins = [0, 30, 60, 90, 150],
                            labels = ['Low (0-30)', 'Medium (30-60)', 'High (60-90)', 'Very High (90+)'])
charge_churn = df.groupby('Charge_group')['Churn'].apply(lambda x: (x == 'Yes').mean() * 100)
print(f"\nMonthly Charge Churn : {charge_churn}")

# Chart 1 : Contract vs Churn

import matplotlib.pyplot as plt

contract_data = df.groupby('Contract')['Churn'].apply(lambda x: (x == 'Yes').mean() * 100)
plt.figure(figsize=(8,5))
contract_data.plot(kind = 'bar', color = ['red', 'green', 'yellow'])
plt.title('Churn Rate by Contract Type', fontsize = 14)
plt.xlabel('Contract Type')
plt.ylabel('Churn Rate (%)')
plt.xticks(rotation=0)
for i, v in enumerate(contract_data):
    plt.text(i, v + 1, f"{v:.1f}%", ha = 'center', fontweight = 'bold')
plt.tight_layout()
plt.savefig('contract_churn.png')
plt.show()

# Chart 2 : Tenure vs Churn

tenure_data = df.groupby('tenure_group')['Churn'].apply(lambda x: (x == 'Yes').mean()*100)
plt.figure(figsize=(8,5))
tenure_data.plot(kind = 'bar', color = ['red', 'green', 'blue'])
plt.title('Churn Rate by Customer Tenure', fontsize = 14, fontweight = 'bold')
plt.xlabel('Tenure Group')
plt.ylabel('Churn Rate (%)')
plt.xticks(rotation=0)
for i, v in enumerate(tenure_data):
    plt.text(i, v + 1, f"{v:.1f}%", ha = 'center', fontweight = 'bold')
plt.tight_layout
plt.savefig('tenure_churn.png')
plt.show()

# Chart 3 : Payment vs Churn

payment_data = df.groupby('PaymentMethod')['Churn'].apply(lambda x: (x == 'Yes').mean()*100)
payment_data = payment_data.sort_values(ascending=False)
plt.figure(figsize=(10, 7))
payment_data.plot(kind = 'bar', color = 'coral')
plt.title('Churn Rate by Payment Method', fontsize = 14, fontweight = 'bold')
plt.xlabel('Payment Method')
plt.ylabel('Churn Rate (%)')
plt.xticks(rotation = 45, ha = 'right')
for i, v in enumerate(payment_data):
    plt.text(i, v + 1, f"{v:.1f}%", ha = 'center', fontsize = 9)
plt.tight_layout
plt.savefig('payment_churn.png')
plt.show()

