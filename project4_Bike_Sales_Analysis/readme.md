---

# 🏍️ Bike Sales India Analysis using SQL & Power BI

## 📘 Project Overview

This project focuses on analyzing a dataset of bike sales across India using SQL queries. It provides insights into resale trends, pricing, mileage, fuel types, and city-tier distributions. Additionally, Power BI is used for visual storytelling and dashboarding to enhance decision-making based on the data.

---

## 📁 Dataset Description

The dataset `BIKE_SALES_INDIA` includes the following columns:

| Column Name             | Description                               |
| ----------------------- | ----------------------------------------- |
| `Brand`                 | Bike manufacturer (e.g., Yamaha, Honda)   |
| `Model`                 | Specific model of the bike                |
| `Price_INR`             | Original price of the bike                |
| `Resale_Price_INR`      | Current resale value                      |
| `Year_of_Manufacture`   | Year the bike was manufactured            |
| `Registration_Year`     | Year the bike was registered              |
| `Fuel_Type`             | Fuel type (Petrol, Electric, etc.)        |
| `Engine_Capacity_cc`    | Engine size in cubic centimeters          |
| `Mileage_km_l`          | Mileage in kilometers per liter           |
| `Avg_Daily_Distance_km` | Average distance covered daily            |
| `Insurance_Status`      | Insurance status (Active/Expired)         |
| `Owner_Type`            | Type of owner (First, Second, etc.)       |
| `Seller_Type`           | Type of seller (Dealer, Individual, etc.) |
| `City_Tier`             | Classification of the city (Tier 1, 2, 3) |
| `State`                 | Indian state where the bike is listed     |

---

## 🔑 Key SQL Analyses

### 🔍 **Exploratory Queries**

* List all bike brands and models
* Count of total bikes listed
* Retrieve oldest and newest models
* Distinct fuel types and their bike counts

### 💰 **Pricing Analysis**

* Average resale price by brand, model, and state
* Price difference between original and resale
* Top 5 most expensive brands (resale)
* Bikes with resale price above average
* Bikes with resale price greater than those in Tier 2 cities

### 🛞 **Mileage and Performance**

* Average mileage by brand/model
* Highest mileage bikes by brand
* Bikes with above-average mileage by fuel type (via CTE)

### 🛡️ **Insurance and Ownership**

* Percentage of bikes with vs without insurance
* Insurance impact on resale price
* Bikes listed more than once by same owner type

### 📊 **City and State-Level Insights**

* Bike distribution by city tier
* Resale price by city tier and state
* Average engine capacity per city tier
* Top 3 states by average resale price
* CTE to identify city tiers with >1000 bike listings

### 📈 **Advanced SQL Features**

* Window functions (`RANK`, `LAG`, `CUMULATIVE SUM`)
* CTEs for filtered aggregations
* Views for reusability (`AVG_RESALEPRICE_MILEAGE_VIIEW`)

---

## 📊 Power BI Dashboard

To enhance the insights from SQL analysis, a **Power BI dashboard** was created which includes:

### 📌 Key Visuals

* Bar chart of average resale price by brand
* Pie chart of fuel type distribution
* Line chart of mileage trends over time
* Tree map of city tier vs average resale price
* Table of top 10 bikes by mileage

### 🔗 Interactive Filters

* Slicers for state, fuel type, and brand
* Drill-through for model-wise details
* Tooltip-based data exploration

---

## ▶️ How to Use

1. **Import Dataset**

   * Load the `BIKE_SALES_INDIA` dataset into your SQL database.

2. **Run SQL Queries**

   * Use `bike_sales_analysis.sql` (your SQL script) in SSMS, MySQL Workbench, or Azure Data Studio.

3. **Power BI Reporting**

   * Connect Power BI to the same database.
   * Use visuals to build dashboards or use the shared `.pbix` file (if applicable).

---

## ✅ Sample View and CTE Usage

### View: Avg Resale Price & Mileage

```sql
CREATE VIEW AVG_RESALEPRICE_MILEAGE_VIIEW AS
SELECT 
    Brand,
    Model,
    AVG(Resale_Price_INR) AS 'Average Resale Price',
    AVG(Mileage_km_l) AS 'Average Mileage'
FROM bike_sales_india
GROUP BY Brand, Model;
```

### CTE: Mileage Above Fuel Type Average

```sql
WITH AVG_MILEAGE_PER_FUEL_TYPE AS (
    SELECT Fuel_Type, AVG(Mileage_km_l) AS Avg_Mileage
    FROM bike_sales_india
    GROUP BY Fuel_Type
)
SELECT BS.Brand, BS.Model, BS.Mileage_km_l
FROM bike_sales_india AS BS
JOIN AVG_MILEAGE_PER_FUEL_TYPE AM
ON BS.Fuel_Type = AM.Fuel_Type
WHERE BS.Mileage_km_l > AM.Avg_Mileage;
```

---

## 📌 Conclusion

This project demonstrates how SQL can be used for advanced business intelligence on the two-wheeler resale market in India. Combined with Power BI, it enables deep exploration of trends across pricing, fuel types, geography, and usage patterns.


---

