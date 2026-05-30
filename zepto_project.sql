drop table if exists zepto:

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR (150) NOT NULL,
mrp NUMERIC (8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingprice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

--data exploration

--count of rows

SELECT COUNT (*) FROM zepto;

--sample data
SELECT * FROM zepto
LIMIT 10;

--null values
SELECT * FROM zepto
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountpercent IS NULL
OR
discountedsellingprice IS NULL
OR
weightingms IS NULL
OR 
availablequantity IS NULL
OR
outofstock IS NULL
OR
quantity IS NULL;

--different product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

--product in stock vs out of stock
SELECT outofstock, COUNT(sku_id)
FROM zepto
GROUP BY outofstock

--product names present multiple times
SELECT name,COUNT(sku_id) as "number of skus"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id)DESC; 

--data cleaning

--products with price = 0
SELECT * FROM zepto
WHERE mrp= 0 OR discountedsellingprice=0;

DELETE FROM zepto
WHERE mrp=0;

--convert paise to rupees
UPDATE zepto
SET mrp=mrp/100.0,
discountedsellingprice=discountedsellingprice/100.0;

SELECT mrp,discountedsellingprice FROM zepto

--Q1.find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name,mrp,discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--Q2.what are the products with high mrp but out of stock
SELECT DISTINCT NAME , mrp
FROM zepto
WHERE outofstock=TRUE and mrp>300
ORDER BY mrp DESC;

--calculate estimated revenue for each category
SELECT category,
SUM(discountedsellingprice * availablequantity) AS total_revenue
FROM zepto
GROUP BY category
ORDER BY total_revenue;

--Q4.find all the product where mrp is greater than 500 and discount is less than 10%.
SELECT DISTINCT name, mrp,discountpercent
FROM zepto
WHERE mrp >500 and discountpercent<10
ORDER BY mrp DESC,discountpercent DESC;

--Q5.identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountpercent),2) as avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

--Q6.find the price per gram for products above 100g and sort by value.
SELECT DISTINCT name ,weightingms,discountedsellingprice,
ROUND(discountedsellingprice/weightingms,2) AS price_per_gram
FROM zepto
WHERE weightingms>=100
ORDER BY price_per_gram;

--group the products into categories like low,medium,bulk.
SELECT DISTINCT name,weightingms,
CASE WHEN weightingms <1000 THEN 'low'
     WHEN weightingms <5000 THEN 'medium'
	 else'bulk'
	 END AS weight_category
	 FROM zepto;
--Q8.what is the total inventory weight per category
SELECT category,
SUM(weightingms*availablequantity)AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight DESC;