---

# 🧠 Mental Health SQL Analysis Project

## 📘 Project Overview

This project analyzes student mental health data using SQL to uncover insights into stress levels, coping mechanisms, academic performance, lifestyle choices, and support systems. The goal is to explore relationships between various factors like sleep, social media usage, physical activity, family support, and GPA.

---

## 📊 Dataset Description

The dataset contains detailed information on students and includes the following key columns:

| Column Name                        | Description                                                 |
| ---------------------------------- | ----------------------------------------------------------- |
| `Student_ID`                       | Unique identifier for each student                          |
| `Gender`                           | Gender of the student                                       |
| `Age`                              | Age of the student                                          |
| `Academic_Performance_GPA`         | Student's GPA                                               |
| `Medical_Condition`                | Binary indicator of any medical condition                   |
| `Social_Media_Usage_Hours_per_day` | Average daily social media usage                            |
| `Sleep_Duration_Hours_per_night`   | Average hours of sleep per night                            |
| `Physical_Exercise_Hours_per_week` | Hours of physical activity per week                         |
| `Family_Support`                   | Family support level (scale)                                |
| `Diet_Quality`                     | Quality of diet (categorical)                               |
| `Mental_Stress_Level`              | Mental stress level (scale)                                 |
| `Financial_Stress`                 | Financial stress level (scale)                              |
| `Relationship_Stress`              | Relationship stress level (scale)                           |
| `Study_Hours_Per_Week`             | Hours spent studying per week                               |
| `Counseling_Attendance`            | Binary value indicating whether student attended counseling |

---

## 🧠 Key Analyses and Insights

### ✅ **Student Demographics & Performance**

* Total number of students
* Average GPA of students
* High-achieving students (GPA > 3.5)
* Students with medical conditions

### 📱 **Lifestyle Factors**

* Social media usage patterns (e.g., males using >3 hours/day)
* Sleep duration categories:

  * `<6 hrs` → *Insufficient Sleep*
  * `6–8 hrs` → *Adequate Sleep*
  * `>8 hrs` → *Excessive Sleep*

### 🏋️ **Health & Well-being**

* Impact of physical activity on mental stress
* Total exercise hours among students with low family support
* Highest and lowest mental stress levels among active students

### 🧬 **Mental Stress and Support**

* Students under high financial, relationship, and mental stress
* Students with high stress who also attend counseling
* Stress flagging (High vs. Normal Stress)

### 📊 **GPA-Based Analysis**

* Ranking students by GPA
* Top 5 students with the highest GPA (via CTE)
* Age-wise average GPA (using window functions)
* Students exceeding average GPA

### 👥 **Group Comparisons & Correlations**

* GPA by sleep duration
* Study hours and GPA relationship (noting Pearson correlation needs external tools)
* GPA of students grouped by age and lifestyle habits

---

## 📁 Project Structure

* `MENTAL_HEALTH.sql` – SQL file containing all the queries used for data analysis
* `README.md` – This file, explaining the purpose and usage of the project

---

## ▶️ How to Run

1. **Import the Dataset**
   Load the dataset into your SQL database and name the table as:
   `Student_Mental_Stress_and_Coping_Mechanisms`

2. **Create a View for Convenience**

   ```sql
   CREATE VIEW SMS_CM AS
   SELECT * FROM Student_Mental_Stress_and_Coping_Mechanisms;
   ```

3. **Run the Queries**
   Execute the SQL statements in `MENTAL_HEALTH.sql` sequentially to perform the analysis.

---

## 🔬 Sample Views & CTEs

### Top Performing & Active Students

```sql
CREATE VIEW ACTIVE_AND_SUCCESSFUL_STUDENTS AS
SELECT *
FROM SMS_CM
WHERE Academic_Performance_GPA > 3
AND Physical_Exercise_Hours_per_week > 3;
```

### High Stress & Counseling Attendance

```sql
WITH MENTAL_STRESS_AND_COUNSELLING AS (
  SELECT Student_ID, Mental_Stress_Level, Counseling_Attendance
  FROM SMS_CM
  WHERE Counseling_Attendance = 1 AND Mental_Stress_Level > 7
)
SELECT * FROM MENTAL_STRESS_AND_COUNSELLING;
```

---

## 🔍 Conclusion

This SQL-based analysis provides a data-driven look at how various factors affect student mental health and performance. From stress and support systems to sleep, social media, and exercise, this project lays the groundwork for deeper psychological and behavioral research.

---

## 📈 Optional Next Steps

* Export query results for visualization in **Power BI**, **Tableau**, or **Excel**
* Perform **correlation analysis** using statistical tools (Python)
* Extend the dataset to include **temporal data** for trend analysis

---
