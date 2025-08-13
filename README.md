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
  SELECT COUNT(*) FROM Retail_dat;
  SELECT DISTINCT category FROM Retail_dat;
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
