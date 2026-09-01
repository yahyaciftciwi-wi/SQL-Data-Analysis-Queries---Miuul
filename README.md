# Asking Questions to Data with SQL

## 📌 Project Overview
As part of the Miuul Data Analytics Bootcamp, I focused on querying relational databases to solve real-world business problems. The main goal of this project was to move beyond basic syntax and learn how to ask the right questions to data, converting unstructured operational records into meaningful business intelligence.

Using relational datasets (including retail transactions and Northwind e-commerce models), I crafted queries ranging from basic filtering logic to complex analytical window functions.

---

## 🔑 Key SQL Capabilities & Analytical Applications

### 🛠️ 1. Relational Joins & Data Aggregation
* **Multi-Table Mapping:** Applied `LEFT JOIN` and `INNER JOIN` logic across `Suppliers`, `Products`, `Categories`, and `Customers` tables to reconstruct business relationships.
* **Category Breakdown:** Utilized `GROUP BY` and `COUNT()` to dynamically summarize product counts per category ordered by volume (`ORDER BY 3 DESC`).
* **Customer Interaction History:** Aggregated customer records with `MAX(OrderDate)` to track recency and extract last-order timestamps per account.

### 📊 2. Filtering & Condition Logic
* **Stock & Price Filtering:** Leveraged `BETWEEN` and `WHERE` clauses to isolate mid-tier pricing strategies (e.g., unit prices between 10 and 30) and high-inventory suppliers (units in stock > 50).
* **Revenue Aggregation:** Used `SUM(Quantity * Price)` grouped by `CustomerID` paired with `HAVING Customer_ID IS NOT NULL` to extract individual customer monetary metrics for RFM inputs.

### 🚀 3. Advanced Subqueries & Window Functions
* **Country-Level Product Ranking:** Constructed nested subqueries incorporating `ROW_NUMBER() OVER (PARTITION BY Country ORDER BY SUM(Quantity) DESC)` to isolate top-selling products per geographic region.
* **Revenue Calculation:** Applied mathematical functions like `ROUND()` to compute rounded financial turnover figures per market.

---

## 🛠️ Concepts & Functions Used
* **Clauses:** `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`
* **Joins & Functions:** `LEFT JOIN`, `INNER JOIN`, `COUNT()`, `SUM()`, `MAX()`, `ROUND()`
* **Advanced Logic:** Window Functions (`ROW_NUMBER() OVER`), Subqueries, `BETWEEN`, `TOP`
* **Curriculum Context:** Miuul Data Analytics Bootcamp
