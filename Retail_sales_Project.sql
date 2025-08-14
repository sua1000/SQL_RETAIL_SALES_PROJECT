use P1;
SELECT * FROM Retail_dat;



--TO FIND THE NULL VALUES 
SELECT * FROM Retail_dat
WHERE 
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	customer_id IS NULL
	OR 
	gender IS NULL
	OR 
	category IS NULL 
	OR 
	quantiy IS NULL
	OR 
	price_per_unit IS NULL
	OR 
	cogs IS NULL
	OR 
	total_sale IS NULL ;


	--DATA CLEANING--
	--NOW WE ARE DELETING THE NULL RECORDS IN THE TABLE 
DELETE FROM Retail_dat
WHERE
	transactions_id IS NULL
	OR 
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR 
	customer_id IS NULL
	OR 
	gender IS NULL
	OR 
	category IS NULL 
	OR 
	quantiy IS NULL
	OR 
	price_per_unit IS NULL
	OR 
	cogs IS NULL
	OR 
	total_sale IS NULL ;
	
	-- THE OUTPUT HERE IS THE 3 ROWS ARE DELETED 

SELECT COUNT(*) FROM Retail_dat;
--AFTER COUNTING WE GET THE 1997 ROWS WHICH HAVE THE DATA

--DATA EXPLORATION--


-- HOW MANY SALES WE HAVE ?
SELECT COUNT(*) AS total_sale FROM Retail_dat;
--THE OUTPUT IS 1997

--HOW MANY UNIQUE CUTOMERS WE HAVE?
SELECT COUNT(DISTINCT customer_id)  FROM Retail_dat;
--THE OUTPUT IS 155

--TO FIND THE CATEGORY?
SELECT COUNT(DISTINCT category)  FROM Retail_dat;
--COUNT IS 3
SELECT DISTINCT category FROM Retail_dat;
--TYPES OF THE CATEGORY ARE Clothing, Beauty and Electronics

--DATA ANALYSIS & BUSINESS INSIGHTS

--Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * FROM Retail_dat
WHERE sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM Retail_dat
WHERE category = 'CLOTHING' 
	AND 
	quantiy >= 4
	AND 
	sale_date BETWEEN '2022-11-01' AND '2022-11-30';

--Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT 
	category,
	SUM(total_sale) AS NET_SALE,
	COUNT(*) AS TOTAL_ORDERS
FROM Retail_dat
GROUP BY category;

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT 
	AVG(AGE) AS AVERAGE_AGE
	FROM Retail_dat
	WHERE CATEGORY ='BEAUTY';

--Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT 
transactions_id FROM Retail_dat
WHERE 
	total_sale > 1000;

SELECT * FROM Retail_dat
WHERE total_sale > 1000;

--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT 
	category,
	gender,
	COUNT(*) AS TOTAL_TRANS
FROM Retail_dat
GROUP BY
	category,
	gender


--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:


SELECT 
		YEAR,
		MONTH,
		AVERAGE_MONTHS
FROM (
SELECT 
	YEAR(sale_date) AS YEAR,
	MONTH(sale_date) AS MONTH,
	AVG(total_sale) AS AVERAGE_MONTHS,
	RANK() OVER(PARTITION BY YEAR(sale_date)ORDER BY AVG(total_sale) DESC) AS RANKTABLE
FROM Retail_dat
GROUP BY YEAR(sale_date),MONTH(sale_date)
) AS T1
WHERE RANKTABLE = 1;

--Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT TOP(5)
		CUSTOMER_ID,
		SUM(TOTAL_SALE) AS TOTAL_SALE
FROM Retail_dat
GROUP BY customer_id
ORDER BY total_sale DESC


--Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT CATEGORY,COUNT(DISTINCT CUSTOMER_ID ) AS UNIQUE_CUST FROM RETAIL_DAT
GROUP BY category

--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
AS
(

SELECT *,
	CASE
		WHEN DATEPART(HOUR,SALE_TIME) <= 12  THEN 'MORNING'
		WHEN  DATEPART(HOUR,SALE_TIME) BETWEEN 12 AND 17 THEN 'AFTERNOON' 
		ELSE 'EVENING'
	END AS SHIFT_TIMINGS
FROM Retail_dat
)
SELECT 
SHIFT_TIMINGS,
COUNT(*) AS TOTAL_ORDERS FROM hourly_sale
GROUP BY SHIFT_TIMINGS 

--END OF THE PROJECT 

