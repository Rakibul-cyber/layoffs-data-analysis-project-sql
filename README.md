# layoffs-data-analysis-project-sql


# Layoffs Data Analysis using SQL

This project involves **data cleaning** and **exploratory data analysis (EDA)** of global layoffs data using SQL. The goal is to prepare a clean dataset and uncover insights about layoffs trends by company, industry, country, and time period.

---

##  Dataset

The data is assumed to be loaded from a source table named `layoffs`. A working copy (`layoffs_staging` and later `layoffs_staging2`) is used for cleaning and transformations.

---

##  Part 1: Data Cleaning

All cleaning steps are done in SQL using MySQL. The main objectives were:

###  Cleaning Goals:
1. **Remove duplicates** using `ROW_NUMBER()` and CTE.
2. **Standardize string values** (e.g., trim whitespace, fix capitalization issues).
3. **Handle null and blank values** by either replacing or removing them.
4. **Fix incorrect formats** (e.g., convert `date` from text to `DATE` type).
5. **Drop unnecessary columns** (like `row_num` after cleaning).

### 🛠 Key Techniques Used:
- CTEs (`WITH` clause)
- `ROW_NUMBER()` window function
- `TRIM()` and `LIKE` for string cleaning
- `STR_TO_DATE()` for date conversion
- Conditional `UPDATE` and `DELETE` operations

---

## Part 2: Exploratory Data Analysis (EDA)

After cleaning, multiple SQL queries were written to analyze the dataset.

###  Questions Explored:
- Total layoffs by company, industry, and country
- Highest percentage layoffs and companies affected
- Layoffs trends over time (monthly, yearly)
- Layoffs by funding stage (e.g., Series A, B, Public)
- Top 5 companies with the most layoffs per year

###  Techniques Used:
- Aggregations: `SUM()`, `MAX()`, `MIN()`, `AVG()`
- Grouping: `GROUP BY` with company, industry, date, etc.
- Time-based analysis using `YEAR()` and `SUBSTRING(date)`
- Rolling totals with `SUM() OVER(ORDER BY date)`
- Ranking with `DENSE_RANK()` over partitioned data

---

##  Time-Series Insights

Monthly and yearly trends were analyzed using:
```sql
SUBSTRING(date, 1, 7)  -- for monthly
YEAR(date)             -- for yearly
