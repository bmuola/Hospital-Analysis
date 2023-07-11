![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)
[![View My Profile](https://img.shields.io/badge/View-My_Profile-green?logo=GitHub)](https://github.com/bmuola)
[![View Repositories](https://img.shields.io/badge/View-My_Repositories-blue?logo=GitHub)](https://github.com/bmuola?tab=repositories)

# Edgar Hospital Case Study

> 
## 📕 **Table of contents**
<!--ts-->
   * 🛠️ [Overview](#️-overview)
   * 🚀 [Solutions](#-solutions)
   * 💻 [Key Highlights](#-key-highlight)

## 🛠️ Overview
With the **Health Analytics Mini Case Study**, I queried data to bring insights to the following questions:
1. What is the count of distinct users present in the logs dataset?
2. On average, how many measurements are recorded per user?
3. Can we determine the median number of measurements per user?
4. How many users have three or more measurements recorded?
5. How many users have accumulated 1,000 or more measurements?
6. Are there any users who have logged blood glucose measurements?
7. Among the users, how many have at least two types of measurements?
8. Are there users who have all three measures (blood glucose, weight, and blood pressure) recorded?
9. What are the median values for systolic and diastolic blood pressure?

---
## 🚀 Solutions

![Question 1](https://img.shields.io/badge/Question-1-971901)

**How many unique users exist in the logs dataset?**
```sql
SELECT COUNT (DISTINCT id)
FROM health.user_logs;
```

Output: 554

---

![Question 2](https://img.shields.io/badge/Question-2-971901)
**How many total measurements do we have per user on average?**
```sql
SELECT
  ROUND (AVG(measure_count), 2) AS mean_value
FROM user_measure_count;
```

Output: 79.23

---

![Question 3](https://img.shields.io/badge/Question-3-971901)
**What about the median number of measurements per user?**
```sql 
SELECT 
   PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY measure_count) AS median_value 
FROM user_measure_count;
```

Output: 2

---

![Question 4](https://img.shields.io/badge/Question-4-971901)
**How many users have 3 or more measurements?**
```sql
SELECT COUNT(*)
FROM user_measure_count
WHERE measure_count >= 3;
```

Output: 209

---

![Question 5](https://img.shields.io/badge/Question-5-971901)
**How many users have 1,000 or more measurements?**
```sql 
SELECT COUNT(*)
FROM user_measure_count
WHERE measure_count >= 1000;
```

Output: 5

---

![Question 6](https://img.shields.io/badge/Question-6-971901)
**Have logged blood glucose measurements?**
```sql
SELECT 
  COUNT(DISTINCT id)
FROM health.user_logs
WHERE measure = 'blood_glucose';
```

Output: 325

---

![Question 7](https://img.shields.io/badge/Question-7-971901)
**Have at least 2 types of measurements?**
```sql
SELECT 
  COUNT(*)
FROM user_measure_count
WHERE unique_measures >= 2;
```

Output: 204

---

![Question 8](https://img.shields.io/badge/Question-8-971901)
**Have all 3 measures - blood glucose, weight and blood pressure?**
```sql
SELECT
  COUNT(*)
FROM user_measure_count
WHERE unique_measures = 3;
```

Output: 50

---

![Question 9](https://img.shields.io/badge/Question-9-971901)
**What is the median systolic/diastolic blood pressure values?**
```sql
SELECT
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY systolic) AS median_systolic,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY diastolic) AS median_diastolic
FROM health.user_logs
WHERE measure = 'blood_pressure';
```

|median_systolic|median_diastolic|
|---------------|----------------|
|126            |79              |
```
```

**Final Thoughts**
<br>
This case study turned out to be a bit more challenging than I expected but I got to learn new ways and tricks to analyze data like I didn't know there was an easier way to get the median.<br>
I was busy forming temp tables trying to find a way to get it when there was an easier way to do it.<br>
Plus finally😂, a whole query where I don't use the ``WITH`` clause
