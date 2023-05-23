select * from clean_data;

select year(order_date) as years, sum(order_quantity) as total_order, sum(sales) as total_sales
from clean_data
where order_status = "Order Finished"
group by years
order by years asc;

select year(order_date) as years, product_sub_category as category, sum(sales) as total_sales
from clean_data
where order_status = "Order Finished" and year(order_date) > 2010
group by year(order_date), product_sub_category
order by product_sub_category asc
limit 10;

select year(order_date) as years, count(distinct customer) as customer
from clean_data
where order_status = "Order Finished"
group by year(order_date)
order by year(order_date) asc;

select years, sales, promotion_value, round((promotion_value/sales)*100, 2) as burn_rate_percentage
from(select extract(year from order_date) as years, sum(sales) as sales, sum(discount_value) as promotion_value
from clean_data
where order_status = "Order Finished"
group by 1) a
order by 1;

select year(order_date) as years, product_category, product_sub_category, sum(sales) as sales, sum(discount_value) as promotion_value, round(sum(discount_value)/sum(sales)*100,2) as burn_rate_percentage
from clean_data
where order_status = "Order Finished" and year(order_date) = 2012
group by year(order_date), product_category, product_sub_category
order by years, sales desc
limit 5;

select year(first_date) as years, count(distinct customer) as new_customer
from (select customer, min(order_date) as first_date
from clean_data
where order_status = "Order Finished" 
group by customer) as a
group by years
order by years;

