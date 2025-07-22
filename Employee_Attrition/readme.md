---

# 👩‍💼 Employee Attrition Data Analysis using SQL

## 📌 Project Overview

This project involves analyzing employee data to understand attrition patterns, employee satisfaction, compensation, and departmental trends using **SQL queries**. The goal is to uncover insights that can help improve employee retention and HR decision-making.

---

## 📁 Database Used

**Database Name:** `EMPLOYEE_ATTRITION_DATA`
**Table Name:** `[EMPLOYEE DATA]`

---

## 🔍 Key SQL Analyses Performed

### 📊 General Stats

* **Total employees** in the company
* Employees **older than 40**
* **Total attrition count** (number of employees who left)

### 💸 Compensation Insights

* **Average monthly income** by department
* **Top 5 highest monthly rate** earners
* **Average salary hike** based on job involvement
* **Income comparison** between employees working overtime vs not

### 🧠 Employee Satisfaction & Job Role

* Employees with **high job satisfaction**
* Average **years with current manager** by job role
* **Top factors** contributing to attrition (Job Satisfaction, Environment Satisfaction)

### 👨‍👩‍👧‍👦 Demographic Insights

* **Gender distribution**
* Number of employees by **education field**

### 📈 Attrition Analysis

* Attrition **rate by department**
* Attrition **based on years at the company**
* **Top 3 departments** with the highest attrition rate
* Employees with **>10 years at company but no promotion**
* Attrition correlation with **distance from home** and **total working years**

### 🕒 Overtime Insights

* Employees **working overtime** with high job satisfaction
* Average income of employees **working overtime vs not**

---

## ✅ Sample Query: Attrition Rate by Department

```sql
SELECT
    DEPARTMENT,
    (COUNT(CASE WHEN ATTRITION = 1 THEN 1 END) * 100.0 / COUNT(*)) AS ATTRITION_RATE
FROM
    [EMPLOYEE DATA]
GROUP BY
    Department;
```

---

## 🔧 How to Use

1. Create the database and import the dataset:

   ```sql
   CREATE DATABASE EMPLOYEE_ATTRITION_DATA;
   USE EMPLOYEE_ATTRITION_DATA;
   ```

2. Run the provided SQL queries to explore and analyze the data.

3. Optionally, visualize insights using tools like **Power BI** or **Tableau**.

---

## 📌 Conclusion

This SQL project offers actionable insights into employee behavior and attrition, helping HR and business teams make informed decisions to improve retention and workplace satisfaction.

---

