 # Retail Sales Analysis SQL Project
 ## Project Overview
- **Project Title:** Retail Sales Analysis
- **Level:** Beginner
- **Database:** `p1_retail_db`

This project aims to showcase SQL skills and techniques commonly used by data analysts to explore, clean, and analyze retail sales data. It involves setting up a retail sales database, performing Exploratory Data Analysis (EDA), and answering specific business questions using SQL queries. This project is ideal for beginners looking to build a strong foundation in SQL.

 ## Objectives
- **Set up a retail sales database:** Create and populate a database with sales data.
- **Data Cleaning:** Identify and remove records with missing or null values.
- **Exploratory Data Analysis (EDA):** Perform basic analysis to understand the dataset.
-**Business Analysis:** Use SQL to answer business-related questions and extract insights.

 ## Project Structure
 ###  1. **Database Setup:**
 - **Database Creation:** The project starts by creating a database named `SQL_Project1.`
 - **Table Creation:** A table named `retailsales` is created to store sales data, including the following columns:
Transaction ID
Sale date & time
Customer ID, gender, and age
Product category & quantity sold
Price per unit & Cost of Goods Sold (COGS)
Total sale amount

``` sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retailsales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```
 ### 2. **Data Exploration & Cleaning**
- **Total Records:** Calculate the overall number of entries in the dataset.
- **Unique Customers:** Count the distinct customers present in the dataset.
- **Product Categories:** List all unique product categories available.
- **Missing Data Handling:** Detect null values in the dataset and remove incomplete records.
``` sql
  SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```
## **3. Data Analysis & Findings**
 The following SQL queries were developed to answer specific business questions:
1. **retrieve all columns for sales made on '2022-11-05**
``` sql
  SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'
```
2.**retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:**
``` sql
SELECT *
	FROM retailsales
	WHERE year(sale_date) = 2022  
	AND month(sale_date) = 11
	AND quantiy >= 4 
	AND category = 'Clothing' ;
```
3.**calculate the total sales (total_sale) for each category.**
``` sql
SELECT  category ,
	SUM(total_sale) as total_sales,
	COUNT(*) as total_orders
	FROM retailsales
	GROUP BY  category;
```
4.**find the average age of customers who purchased items from the 'Beauty' category.**
``` sql
SELECT AVG(age) as avg_age
	FROM retailsales
	WHERE category = 'Beauty';
```
5.** find all transactions where the total_sale is greater than 1000.**
``` sql
SELECT * 
	FROM retailsales
	WHERE total_sale > 1000 ;
```
6.**find the total number of transactions (transaction_id) made by each gender in each category.**
``` sql
SELECT  gender , category  ,count(transactions_id) as total_transaction
	FROM retailsales
	GROUP BY gender
	, category;
```
7.**calculate the average sale for each month. Find out best selling month in each year**
``` sql
WITH X1 AS (
    SELECT
        YEAR(sale_date) AS year, 
        MONTH(sale_date) AS month, 
        AVG(total_sale) AS avg_sale, 
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS sales_rank
    FROM retailsales
    group by YEAR(sale_date), MONTH(sale_date)
)
 SELECT year , month , avg_sale 
 FROM X1
 where sales_rank = 1 ;
```
8.**find the top 5 customers based on the highest total sales**
``` sql
SELECT  top 5  customer_id , sum(total_sale) as total_sales 
 FROM retailsales
 GROUP BY  customer_id 
 ORDER BY  sum(total_sale) desc;
```
9.**find the number of unique customers who purchased items from each category.**
``` sql
SELECT COUNT(distinct customer_id) as uniqe_customers, category 
 FROM retailsales
 GROUP BY  category ;
```
10.**create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**
``` sql
SELECT
	shift,
	COUNT(*) as total_orders 
	FROM (
	SELECT * ,
	CASE 
	WHEN datepart(Hour ,sale_time) < 12 then 'Morning'
        WHEN datepart(Hour ,sale_time) between  12 and 17  then 'Afternoon'
	ELSE 'Evening'
	END AS  shift 
	FROM retailsales) as X2
	GROUP BY shift ;
```
















