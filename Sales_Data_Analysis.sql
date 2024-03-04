use Sales_Analysis
/*
Data cleaning 
*/

-- checking data 
select * from sales_data

select count(row_id) from Sales_Data

--checking distinct values in columns which may be important 
select distinct Ship_Mode from Sales_Data
select distinct segment from Sales_Data
select distinct Category from Sales_Data
select distinct Sub_Category from Sales_Data
select distinct state from Sales_Data
select distinct city from Sales_Data

--removing duplicates 

DELETE Tupple 
FROM ( SELECT *, Duplicate= ROW_NUMBER() OVER( PARTITION BY ROW_ID ORDER BY(SELECT NULL)) FROM Sales_Data) AS Tupple
WHERE Duplicate > 1


--checking null values 

select count(Row_id) from Sales_Data where Postal_Code is NULL
select * from Sales_Data where postal_code is NULL

/*
Data processing 
*/

--removing unwanted columns
alter table sales_data
drop column Customer_ID,Postal_Code, Product_ID

-- making new values that we need 

select  Row_id,year( order_date) as d from Sales_Data 

ALTER TABLE sales_data 
ADD Years int

update Sales_Data
set years = YEAR(order_date)

select * from Sales_Data


ALTER TABLE sales_data 
add Months varchar(50)
alter table sales_data
drop column Months

update Sales_Data
set Months = month(order_date)

select order_date,datename(month,order_date) as 'Month' from Sales_Data
UPDATE Sales_Data
set Months = datename(month,order_date)

select * from Sales_Data

select DATEDIFF(day,Order_Date,Ship_Date) from Sales_Data

alter table sales_data
add Shipping_Time int

update sales_data
set Shipping_Time = Datediff(day,order_date,ship_date)

select * from Sales_Data


/*
Data analysis 
*/
-- Checking different calculations 

select round(sum(sales),2) as 'Total Revenue' from sales_data

select count(order_id) from Sales_Data  -- NULL values rows are removed before

select round(sum(sales),0) as 'Total Revenue' , category from Sales_Data
group by Category
order by 'Total Revenue' DESC























