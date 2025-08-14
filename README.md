# SQL_RETAIL_SALES_PROJECT
Retail Sales Analysis project using Microsoft SQL Server. Includes database creation, sample dataset, and SQL queries for sales trends, customer insights, best-selling products, and performance metrics. Designed for practicing SQL joins, aggregations, and date functions in real-world retail scenarios

- ---
## **Objectives**
- **To design and implement a retail sales database in Microsoft SQL Server.**  
- **To analyze sales performance by customer, product, and time period.**  
- **To identify best-selling products and peak sales periods.**  
- **To demonstrate the use of SQL joins, aggregations, and date functions.**  
- **To provide real-world retail data analysis practice for learners and developers.**

- ---
## 🛠 Tech Stack
- **Database:** Microsoft SQL Server
- **Language:** T-SQL (Transact-SQL)
- **Tool:** SQL Server Management Studio (SSMS)
- ---

## 📊 Dataset Information
**Table Name:** `Retail_dat`

| Column Name       | Description |
|-------------------|-------------|
| transactions_id   | Unique ID for each transaction |
| sale_date         | Date of the sale |
| sale_time         | Time of the sale |
| customer_id       | Unique ID of the customer |
| gender            | Gender of the customer |
| category          | Product category (Clothing, Beauty, Electronics) |
| quantiy           | Quantity sold |
| price_per_unit    | Price per unit item |
| cogs              | Cost of goods sold |
| total_sale        | Total sales amount |
| age               | Age of the customer |

- ---


## 📂 Project Workflow
1. **Data Cleaning**
   - Identified and removed rows with `NULL` values.
   - Verified row count after cleaning.

2. **Data Exploration**
   - Counted total sales transactions.
   - Counted unique customers.
   - Identified product categories.

3. **Data Analysis**
   - Sales on specific dates.
   - High-quantity orders.
   - Category-wise total sales.
   - Customer demographics.
   - Best-selling month.
   - Top customers by total sales.
   - Shift-wise sales performance.

   - ---

1.**Database setup**

  - Database creation : Create a database in the SSMS as P1.
  - Table creation : A table named Retail_dat is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

    ```sql
    CREATE DATABASE P1;

    CREATE TABLE Retail_dat
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
2.**Data ecploring and cleaning**
- Record count:Determine the total number of records in the dataset.
- Category count: Identify all unique product categories in the dataset.
- Customer count:Find out how many unique customers are in the dataset.
- Null value check:Identify and remove records containing null or missing values from the dataset.

  ```sql
  SELECT COUNT(*) AS total_sale FROM Retail_dat;
  SELECT COUNT(DISTINCT category)  FROM Retail_dat;
  SELECT COUNT(DISTINCT customer_id) FROM Retail_dat;
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
  ```

  3.**Data analysis and findings**

  The following SQL queries were developed to find the business insights from the dataset
     1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
  ```sql
  SELECT * FROM Retail_dat
  WHERE sale_date = '2022-11-05';
  ```
     2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
  ```sql
  SELECT * FROM Retail_dat
  WHERE category = 'CLOTHING' 
	AND 
	quantiy >= 4
	AND 
	sale_date BETWEEN '2022-11-01' AND '2022-11-30';
  ```
     3.Write a SQL query to calculate the total sales (total_sale) for each category.:
  ```sql
  SELECT 
	category,
	SUM(total_sale) AS NET_SALE,
	COUNT(*) AS TOTAL_ORDERS
  FROM Retail_dat
  GROUP BY category;
  ```
  4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
  ```sql
  SELECT 
	AVG(AGE) AS AVERAGE_AGE
	FROM Retail_dat
	WHERE CATEGORY ='BEAUTY';
  ```
  5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
  ```sql
  SELECT 
	transactions_id FROM Retail_dat
	WHERE 
		total_sale > 1000;

  SELECT * FROM Retail_dat
  WHERE total_sale > 1000;
  ```
  6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
  ```sql
  SELECT 
	category,
	gender,
	COUNT(*) AS TOTAL_TRANS
  FROM Retail_dat
  GROUP BY
	category,
	gender
  ```
  7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
```sql
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
```
8.Write a SQL query to find the top 5 customers based on the highest total sales.:
```sql
SELECT TOP(5)
		CUSTOMER_ID,
		SUM(TOTAL_SALE) AS TOTAL_SALE
FROM Retail_dat
GROUP BY customer_id
ORDER BY total_sale DESC
```
9.Write a SQL query to find the number of unique customers who purchased items from each category.:
```sql
SELECT CATEGORY,COUNT(DISTINCT CUSTOMER_ID ) AS UNIQUE_CUST FROM RETAIL_DAT
GROUP BY category
```
10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
```sql
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
```
## **Findings**
-- **Customer Demographics:** Customers from diverse age groups and genders, with purchases spanning categories like Clothing, Beauty, Electronics
-- **High-Value Transactions:** Numerous orders crossed ₹1000 in value, reflecting strong demand for high-end products.
-- **Sales Trends:** Monthly analysis reveals fluctuating sales patterns, pinpointing peak and off-peak seasons.
--**Customer Insights:** Analysis highlights top-spending customers and the highest-demand product categories.
- ---
## **Reports:**

* **Sales Summary:** Comprehensive overview of total sales, customer demographics, and category-wise performance.
* **Trend Analysis:** Detailed insights into monthly sales patterns and shift-based purchasing behavior.
* **Customer Insights:** Identification of top customers and unique customer counts across categories.
- ---
## **Conclusion:**
This project provides a complete hands-on introduction to SQL for data analysis, encompassing database setup, data cleaning, exploratory analysis, and business-oriented queries. Insights from the analysis enable informed decision-making by revealing sales trends, customer purchasing behavior, and product performance patterns.
- ---
