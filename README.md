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
 SELECT TOP 10 * 
FROM retailsales;
```
``` sql
select count(*)
from retailsales ;
```
  select * 
from retailsales
  where transactions_id is null OR sale_date is null  OR
  sale_time is null OR customer_id is null OR
  gender is null OR age is null OR 
  category is null OR quantiy is null OR
  price_per_unit is null OR cogs is null OR 
  total_sale is null
  Delete from retailsales
  where transactions_id is null 
  OR sale_date is null OR sale_time is null OR customer_id is null OR gender is null
  OR age is null OR  category is null OR quantiy is null
  OR price_per_unit is null OR cogs is null OR total_sale is null ;
  ```
  


























