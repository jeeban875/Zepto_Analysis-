# Zepto_Analysis-
Zepto Sales Analysis Using SQL  This project analyzes Zepto's e-commerce sales data using SQL to uncover business insights, customer purchasing patterns, product performance, revenue trends, and inventory behavior.
# 🛒 Zepto Data Analysis Using SQL

## 📌 Project Overview

This project analyzes Zepto's product inventory and pricing dataset using SQL. The goal is to extract meaningful business insights related to product pricing, discounts, stock availability, inventory management, and revenue estimation.

The project demonstrates how SQL can be used for **data exploration, cleaning, and business analysis** on a real-world quick-commerce dataset.

---

## 📂 Dataset Information

The dataset contains product-level information, including:

| Column                 | Description                  |
| ---------------------- | ---------------------------- |
| sku_id                 | Unique product identifier    |
| category               | Product category             |
| name                   | Product name                 |
| mrp                    | Maximum Retail Price (₹)     |
| discountPercent        | Discount percentage offered  |
| availableQuantity      | Available inventory quantity |
| discountedSellingPrice | Selling price after discount |
| weightInGms            | Product weight in grams      |
| outOfStock             | Stock availability status    |
| quantity               | Product quantity/unit        |

---

## 🛠️ Database Schema

```sql
CREATE TABLE zepto(
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);
```

---

## 🔍 Data Exploration

The project begins with exploratory queries to understand the dataset:

* Total number of records
* Sample data inspection
* Null value detection
* Unique product categories
* In-stock vs out-of-stock products
* Duplicate product names across SKUs

Example:

```sql
SELECT DISTINCT category
FROM zepto
ORDER BY category;
```

---

## 🧹 Data Cleaning

Data cleaning steps performed:

### Remove Invalid Records

```sql
DELETE FROM zepto
WHERE mrp = 0;
```

### Convert Paise to Rupees

```sql
UPDATE zepto
SET mrp = mrp/100.0,
    discountedSellingPrice = discountedSellingPrice/100.0;
```

---

## 📊 Business Analysis

### 1️⃣ Top 10 Best Value Products

Identify products offering the highest discounts.

```sql
SELECT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
```

---

### 2️⃣ High-Value Products That Are Out of Stock

Find expensive products currently unavailable.

```sql
SELECT name, mrp
FROM zepto
WHERE outOfStock = TRUE
AND mrp > 300;
```

---

### 3️⃣ Estimated Revenue by Category

Calculate potential revenue based on inventory and selling price.

```sql
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category;
```

---

### 4️⃣ Premium Products With Low Discounts

Find products with:

* MRP > ₹500
* Discount < 10%

```sql
SELECT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500
AND discountPercent < 10;
```

---

### 5️⃣ Categories Offering Highest Discounts

```sql
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;
```

---

### 6️⃣ Price Per Gram Analysis

Determine value-for-money products.

```sql
SELECT name,
weightInGms,
discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto;
```

---

### 7️⃣ Product Weight Segmentation

Classify products based on weight.

```sql
CASE
    WHEN weightInGms < 1000 THEN 'Low'
    WHEN weightInGms < 5000 THEN 'Medium'
    ELSE 'Bulk'
END
```

---

### 8️⃣ Total Inventory Weight by Category

```sql
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight DESC;
```

---

## 🎯 Key Insights Generated

* Products offering the highest discounts.
* Categories generating the highest estimated revenue.
* Premium products with minimal discounts.
* Inventory distribution across categories.
* High-value products currently unavailable.
* Price-per-gram analysis for better product comparison.
* Weight-based product segmentation.
* Total inventory weight per category.

---

## 💡 SQL Concepts Used

* SELECT Statements
* WHERE Clauses
* ORDER BY
* GROUP BY
* Aggregate Functions (`SUM`, `AVG`, `COUNT`)
* CASE Statements
* DISTINCT
* Data Cleaning Operations (`UPDATE`, `DELETE`)
* Filtering and Sorting

---

## 🚀 Tools & Technologies

* PostgreSQL
* SQL
* GitHub
* Data Analysis

---

## 📈 Project Outcome

This project showcases how SQL can transform raw retail inventory data into actionable business insights. The analysis helps understand pricing strategies, inventory management, discount effectiveness, and revenue opportunities in a quick-commerce business like Zepto.

---

### ⭐ If you found this project useful, consider giving it a star on GitHub!
