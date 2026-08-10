# Customer Data Cleaning — Excel vs Python

A side-by-side data cleaning exercise on a messy 550-row customer dataset, solved twice — once in Excel (Power Query) and once in Python (pandas) — to compare workflows and outputs.

## The Problem

Raw dataset (550 rows, 10 columns) had:
- 15 missing Customer IDs, 38 duplicate Customer IDs
- 35 missing emails, 44 duplicate emails, invalid email formats
- 44 missing phone numbers, inconsistent formats (dashes, spaces, country codes)
- 30 missing/inconsistent city names (e.g. "NYC", "LA", "Unknown")
- 48 missing purchase amounts, values stored as text ("$450", "FREE"), and outliers
- Inconsistent date formats in Date of Birth and Join Date
- Inconsistent membership status labels (e.g. "gld", "slvr" instead of "Gold", "Silver")

## Approach

**Python (pandas):**
- Dropped rows with missing/duplicate Customer_ID
- Regex-based email and phone validation
- Standardized text fields (`.str.strip()`, `.str.title()`, `.str.upper()`)
- City name mapping dictionary for variants
- `pd.to_datetime()` with mixed-format parsing for date columns
- IQR method to detect and cap purchase amount outliers
- Script: `cleaning_with.py`

**Excel (Power Query):**
- Same cleaning logic replicated using Power Query — remove duplicates, trim/clean text, replace values, change data types, and conditional column mapping for standardization
- File: `Excel_cleaning.xlsx`

## Result

550 raw rows → 511 clean rows after removing invalid/duplicate Customer IDs, with standardized formats across all 10 columns.

## Key Takeaway

Both tools reached the same clean output, but the workflows differ: pandas is faster for regex-heavy validation (emails, phone numbers) and reusable via script, while Power Query's UI makes the transformation steps more visual and easier to audit step-by-step. Good example of choosing the right tool for the task rather than a "better" one.
