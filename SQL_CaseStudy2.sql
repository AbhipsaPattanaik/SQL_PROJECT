create database pizza_project;
use pizza_project;
drop database pizza_project;
select * from order_details limit 5;
select * from orders limit 5;
select * from pizza_type limit 5;
select * from pizzas limit 5;

-- Retrieve the total number of orders placed.
select count(*) as total_ordered_pizzas from pizzas;

-- Calculate the total revenue generated from pizza sales.
select sum(quantity * price) as revenue_generated from order_details left join pizzas using(pizza_id);

-- Identify the highest-priced pizza.
select max(price) as Highest_priced_pizza from pizzas;
select price from pizzas order by price desc limit 1;

-- Identify the most common pizza size ordered.
select max(size) as most_common_pizza from pizzas;

-- List the top 5 most ordered pizza types along with their quantities.
with ct1 as(
select * from pizza_types left join pizzas using (pizza_type_id)
left join order_details using(pizza_id)
)
select pizza_type_id, name from ct1 order by quantity desc limit 5 ;

-- join the necessary tables to find the total quantity of each pizza category ordered. 
with ct1 as(
select * from pizza_types left join pizzas using (pizza_type_id)
left join order_details using(pizza_id))
select category,sum(quantity) as total_quantity from ct1 group by category ;
select category from pizza_types where category <> "Chicken";
-- Determine the distribution of orders by hour of the day.
select sum(quantity), hour(time) as hours_of_day from orders left join order_details
using(order_id) group by hour(time);

-- Group the orders by date and calculate the average number of pizzas ordered per day.
with ct1 as(
select * from orders left join order_details using (order_id)),ct2 as(
select date,sum(quantity) as no_of_pizzas from ct1 group by date )
select avg(no_of_pizzas) as average_ from ct2;
