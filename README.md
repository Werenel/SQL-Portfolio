# SQL Portfolio

Welcome to my SQL portfolio! This repository contains scripts I wrote to analyze various business datasets. The primary focus of these projects is data extraction, transformation, and calculating key business metrics.

## 🛠 Tools & Technologies
* **Dialect:** Google Standard SQL (BigQuery)
* **Techniques used:** Joins, CTEs (Common Table Expressions), Window Functions, Data Aggregation, Date/Time Manipulation.

## 📂 Projects Overview

### 1. Emails Sent by Month (with & without CTEs)
* **Goal:**  / Calculate the percentage of emails sent to each account during the month out of the total number of emails.
Determine the first and last date an email was sent for each account during the month.
* **Key Skills:** Aggregation, joining multiple relational tables (`email_sent`, `account_session`, `session`), and calculating activity percentages.
* **Files:** `Emails_Sent_by_Month.sql`, `Emails_Sent_by_Month_with_CTEs.sql`

### 2. Revenue by Device and Continent with Sessions
* **Goal:** Aggregate global revenue statistics broken down by device type (mobile vs. desktop) and calculate the percentage of total revenue for each continent.
* **Key Skills:** Window functions (`SUM() OVER()`), conditional aggregation (`CASE WHEN`), and complex `LEFT JOIN` logic to combine sales, registration, and session data.
* **File:** `Revenue_by_Device_and_Continent_with_Sessions.sql`

### 3. Email Marketing Performance & Top 10 Countries
* **Goal:** Merge account creation data with email engagement metrics to rank the Top 10 countries by user acquisition and messaging volume.
* **Key Skills:** `UNION ALL` for combining different data granularities, multi-level CTEs, Data Deduplication, and advanced window functions (`DENSE_RANK()`).
* **Dashboard:** [Interactive Looker Studio Report](https://datastudio.google.com/reporting/43c2984a-854f-448b-8026-40b54131ade8) 📊
* **File:** `Top_10_Countries_Email_Metrics_Module_Task.sql`

---
*Feel free to explore the code to see my analytical approach!*
