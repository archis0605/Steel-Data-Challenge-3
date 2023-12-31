/* 1. What are the names of all the countries in the country table? */
select country_name
from country;

/* 2. What is the total number of customers in the customers table? */
select count(*) as total_customers
from customers;

/* 3. What is the average age of customers who can receive marketing emails (can_email is set to 'yes')? */
select round(avg(age)) as average_age
from customers
where can_email = "yes";

/* 4. How many orders were made by customers aged 30 or older? */
select count(*) as total_orders
from orders o
inner join customers c using(customer_id)
where c.age >= 30;

/* 5. What is the total revenue generated by each product category? */
select p.category, concat("$ ",sum(p.price)) as total_revenue
from baskets b
left join products p using(product_id)
group by 1;

/* 6. What is the average price of products in the 'food' category? */
select round(avg(price),2) as avg_price
from products p
where category = "food";

/* 7. How many orders were made in each sales channel (sales_channel column) in the orders table? */
select sales_channel, count(*) as total_orders
from orders
group by 1;

/* 8. What is the date of the latest order made by a customer who can receive marketing emails? */
select o.date_shop
from customers c
inner join orders o using(customer_id)
where c.can_email = "yes"
order by o.date_shop desc limit 1;

/* 9. What is the name of the country with the highest number of orders? */
with country_details as (
	select c.country_name, count(*) as total_orders
	from orders o
	inner join country c using(country_id)
	group by 1)
select country_name
from country_details
where total_orders = (select max(total_orders) from country_details);

/* 10. What is the average age of customers who made orders in the 'vitamins' product category? */
select round(avg(age)) as average_age
from orders o
inner join customers c using(customer_id)
inner join baskets b using(order_id)
inner join products p using(product_id)
where p.category = "vitamins";
