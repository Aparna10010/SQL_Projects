---
# 🏘️ Nashville Housing Data Analysis (SQL Project)

This project contains a series of SQL queries and analytical solutions performed on the **Nashville Housing** dataset. It explores property sales, pricing trends, land use, and market behavior using SQL Server.

---

## 📂 Dataset Overview

The dataset, `Nashville Housing`, includes property-level information such as:

- Property address
- Sale price & sale date
- Land and building value
- Parcel ID
- Tax district
- Property features (bedrooms, bathrooms, year built, etc.)
- Land use category
- Acreage

---

## 🎯 Project Objectives

- Explore and clean the Nashville Housing dataset.
- Perform time-based, location-based, and value-based analytics.
- Identify patterns in sales, appreciation, and land use.
- Create views and aggregate metrics.
- Classify and segment properties based on financial thresholds.
- Use window functions to analyze multi-sale properties.

---

## 🛠️ Key SQL Concepts Used

- Joins and subqueries  
- Aggregation (`AVG`, `SUM`, `COUNT`, `MAX`, etc.)  
- Grouping and filtering  
- Window functions (`OVER`, `RANK`, `LAG`)  
- Conditional logic (`CASE` statements)  
- Views and CTEs  
- Date functions and value comparisons

---

## 📊 Sample Queries

### 🔹 Properties Sold After 2010
```sql
SELECT PropertyAddress, SaleDate
FROM "Nashville Housing"
WHERE SaleDate > '2010-01-01';
````

### 🔹 Average Sale Price by Land Use

```sql
SELECT AVG(SalePrice) AS AverageSalePrice, LandUse
FROM "Nashville Housing"
GROUP BY LandUse;
```

### 🔹 Top 5 Most Expensive Properties (by Total Value)

```sql
SELECT ParcelID, TotalValue
FROM (
  SELECT ParcelID, TotalValue, 
         RANK() OVER (ORDER BY TotalValue DESC) AS Rank
  FROM "Nashville Housing"
) AS Ranked
WHERE Rank <= 5;
```

### 🔹 Price Difference Between Sales (Same Property)

```sql
SELECT
  UniqueID,
  SaleDate,
  SalePrice,
  SalePrice - LAG(SalePrice) OVER(PARTITION BY ParcelID ORDER BY SaleDate) AS PriceDifference
FROM "Nashville Housing";
```

---

## 🧠 Insights Gained

* Identified undervalued and overvalued properties.
* Tracked appreciation for properties sold more than once.
* Ranked properties by land use, acreage, and price metrics.
* Detected patterns in property sales based on year and location.
* Created reusable SQL views for recent sales.

---

## 📁 Folder Structure

```
📦 Nashville-Housing-SQL
┣ 📄 README.md
┣ 📄 Nashville_Housing_Queries.sql
┗ 📄 Data Dictionary (optional)
```

---

## 📌 Requirements

* SQL Server (tested on Microsoft SQL Server)
* Basic knowledge of SQL syntax

---

## 🚀 Getting Started

1. Clone the repo:

   ```bash
   git clone https://github.com/yourusername/Nashville-Housing-SQL.git
   ```
2. Import the dataset into your SQL Server environment.
3. Open the `Nashville_Housing_Queries.sql` file.
4. Run queries and explore the data insights.

---

## 🤝 Contributions

Contributions are welcome! If you find bugs or want to improve the analysis, feel free to submit a pull request or open an issue.

---

## 📜 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 🙋‍♂️ Author

**Aparna Sharma**
📧 [Email](aparnasharma10010@gmail.com)


---

```


```
