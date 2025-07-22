---

# 🦠 COVID-19 Data Analysis with SQL

## 📌 Project Overview

This project focuses on analyzing COVID-19 data using SQL to extract meaningful insights. The dataset contains information on confirmed cases, deaths, and recoveries across various Indian states and regions. Through a combination of basic to advanced SQL queries, we explore case trends, calculate rates, identify regional patterns, and highlight key indicators in the pandemic progression.

---

## 📊 Dataset Description

The dataset includes the following fields:

| Column Name   | Description                                    |
| ------------- | ---------------------------------------------- |
| **State**     | Name of the state where data is recorded       |
| **Region**    | Geographical region to which the state belongs |
| **Confirmed** | Total confirmed COVID-19 cases                 |
| **Deaths**    | Number of deaths reported due to COVID-19      |
| **Recovered** | Number of recovered patients                   |

---

## 🔍 Key SQL Queries

### ✅ **Basic Queries**

* Filter records by specific state or region.
* Calculate total confirmed cases across the dataset.
* Sort data by number of deaths or recoveries.

### ⚙️ **Intermediate Queries**

* Group data by region to get regional summaries.
* Calculate **Death Rate** = (Deaths / Confirmed) × 100
* Calculate **Recovery Rate** = (Recovered / Confirmed) × 100
* Identify **high-risk areas** with low recovery and high death rates.

### 📈 **Advanced Queries**

* Calculate **Active Cases** = Confirmed - (Deaths + Recovered)
* Perform **ranking** of states based on recovery rate.
* Generate **rolling averages** for tracking trends over time (if date-wise data is available).

---

## ⭐ Project Highlights

* ✅ Active Cases Computation
* 📊 Death Rate & Recovery Rate Analysis
* 🗺️ Region-wise Summary & Trends
* 🏆 Ranking States by Performance
* ⚠️ Identification of Critical or High-Risk States

---

## 📌 How to Run

1. **Import the Dataset**
   Load the COVID-19 dataset into your preferred SQL database (e.g., MySQL, PostgreSQL, SQL Server).

2. **Run SQL Queries**
   Execute the queries from the `covid_sql_queries.sql` file provided with this project to perform the analysis.

3. **Visualize Insights (Optional but Recommended)**
   Use BI tools like **Power BI**, **Tableau**, or **Excel** to create interactive dashboards and visualizations based on the SQL query outputs.

---

## 🧠 Conclusion

This project showcases the power of SQL in real-world data analysis. By querying COVID-19 statistics, we uncover valuable insights into the spread and control of the pandemic. This analysis framework can serve as a foundation for more advanced epidemiological studies or as a component in a broader data-driven decision-making tool.

---

