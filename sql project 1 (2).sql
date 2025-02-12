
CREATE DATABASE SQL_Project1;
--- Create Tables
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'retailsales')
BEGIN
    CREATE TABLE retailsales (
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
END

SELECT TOP 10 * 
FROM retailsales;
---
select count(*)
from retailsales ;

--- Data Clean
select * 
from retailsales
  where transactions_id is null 
  OR 
  sale_date is null 
  OR
  sale_time is null
  OR
  customer_id is null
  OR
  gender is null
  OR 
  age is null
  OR 
  category is null
  OR
  quantiy is null
  OR
  price_per_unit is null
  OR 
  cogs is null 
  OR
  total_sale is null
  ---
  Delete from retailsales
  where transactions_id is null 
  OR 
  sale_date is null 
  OR
  sale_time is null
  OR
  customer_id is null
  OR
  gender is null
  OR 
  age is null
  OR 
  category is null
  OR
  quantiy is null
  OR
  price_per_unit is null
  OR 
  cogs is null 
  OR
  total_sale is null ;
  --- Data Exploration

  --- How many sales we have ?
  select count(*) as total_sales
  from retailsales ;

  --- How many customer we have ?
  select  count(distinct transactions_id) as customers_num
   from retailsales;

   --- How many category we have ?
   select distinct category as uniqe_category
    from retailsales ;

	--- Business Analysis & Key Problems & Answers 
	--Write a SQL query to retrieve all columns for sales made on '2022-11-05
	select * 
	from retailsales
	where sale_date = '2022-11-05' ;

	--- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
	select *
	from retailsales
	where  year(sale_date) = 2022  
	AND month(sale_date) = 11
	AND quantiy >= 4 
	AND category = 'Clothing' ;

	--- Write a SQL query to calculate the total sales (total_sale) for each category.
	select  category ,
	sum(total_sale) as total_sales,
	count(*) as total_orders
	from retailsales
	group by category;

	--- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
	select avg(age) as avg_age
	from retailsales
	where category = 'Beauty';

	--- Write a SQL query to find all transactions where the total_sale is greater than 1000.
	select * 
	from retailsales
	where total_sale > 1000 ;

	---Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
	select   gender , category  ,count(transactions_id) as total_transaction
	from retailsales
	group by gender
	, category;

	--- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
WITH X1 AS (
    select 
        YEAR(sale_date) AS year, 
        MONTH(sale_date) AS month, 
        AVG(total_sale) AS avg_sale, 
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS sales_rank
    from retailsales
    group by YEAR(sale_date), MONTH(sale_date)
)
 select year , month , avg_sale 
 from X1
 where sales_rank = 1 ;

 --- Write a SQL query to find the top 5 customers based on the highest total sales.
 select  top 5  customer_id , sum(total_sale) as total_sales 
 from retailsales
 group by customer_id 
 order by  sum(total_sale) desc;

 --- Write a SQL query to find the number of unique customers who purchased items from each category.
 select count(distinct customer_id) as uniqe_customers, category 
 from retailsales
 group by category ;

 --- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
	select 
	shift,
	count(*) as total_orders 
	from (
	select * ,
	case 
	when datepart(Hour ,sale_time) < 12 then 'Morning'
    when datepart(Hour ,sale_time) between  12 and 17  then 'Afternoon'
	else 'Evening'
	end as shift 
	from retailsales) as X2
	group by shift ;

	--- THE END :)
