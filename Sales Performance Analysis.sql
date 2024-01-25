Use ETL1;
select*from clean_data;

/*                                                   Sales Performance Analysis                                                                   */

/* Objective:-
               The primary goal of this project is to gain valuable insights into the sales performance of the company over the specified time frame.
               Through comprehensive analysis and visualization, the project aims to identify patterns, trends, and key factors influencing sales. 
               This includes understanding the impact of discounts, examining the performance of different product categories and sub-categories, 
               and exploring customer behavior.                                                                                                   */

--  What is the total sales value?
select sum(sales) from clean_data as `Total Sales`;

-- Who are the top 5 customers by sales?
select customer,sales from clean_data order by sales desc limit 0,5;

-- What are the monthly sales Total? (sales Overtime)
SELECT DATE_FORMAT(order_date, '%Y-%m') AS Month, SUM(sales) AS MonthlySales FROM clean_data GROUP BY Month;

-- What is the total number of orders for each order status?	

select order_status,count(order_status) from clean_data group by order_status having count(distinct(order_status));


-- What is the average order quantity and average sales per customer?
select customer,order_quantity,sales from clean_data 
                  where customer in(select customer from clean_data group by customer having round(avg(order_quantity)) and round(avg(sales)));  
             
-- How many unique products are there in each category and sub-category?
select product_category,count(product_sub_category) as `count of the unique product` from clean_data 
                                                 group by product_category having count(distinct(product_sub_category));
                  
-- What are the top 3 product categories with the highest total sales?
select product_category,max(sales) from clean_data group by product_category having sum(sales);


-- What is the percentage of orders with and without discounts?

select (select count(*) from clean_data where discount_value > 0)*100.0/count(*) as `Percentage With Discount`,
(select count(*) from clean_data where discount_value = 0)*100.0/count(*) as `Percentage Without Discount` from clean_data;

-- What is the average discount value for each product category?
select round(avg(discount_value)) from clean_data as ` Avg Discount` 
                 where product_category in(select product_category from clean_data group by product_category having round(avg(discount_value)));
                 
-- Which product sub-categories within a category have the highest sales or profit margins?
select product_category,product_sub_category,sales from clean_data where sales in (select round(max(sales)) from clean_data);

-- List cusomter with a purcheses above the average purchase price of all customers
select customer,round(sales) from clean_data where sales > (select round(avg(sales)) from clean_data);

-- Disount Analysis 
-- What is the total discount given to customers?
select sum(discount_value) as discount_analysis from clean_data;

-- How does the discount impact sales?
select discount,round(avg(sales)) as AverageSales from clean_data group by discount;

-- How has the average discount value changed over time?
select round(avg(discount_value)) as `Avgerage Discount Vlaue`,date_format(order_date,'%Y,%M') 
                                                                as Month from clean_data group by Month order by Month;
-- Order Analysis							
-- What is the maximum, minimum, and average order quantity?
select round(max(order_quantity)) as `Maximum Order Quantity`,round(min(order_quantity)) as `Minmum Order Quantity`,
                                                              round(avg(order_quantity)) as ` Average Order Quantity` from clean_data;
                                                              
                              