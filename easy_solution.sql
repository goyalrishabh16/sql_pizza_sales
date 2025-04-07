-- 1. Retrieve the total number of orders placed.

SELECT 
    COUNT(*) AS Total_orders
FROM
    orders;

-- 2. Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS Total_Revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id;

-- 3. Identify the highest-priced pizza
SELECT 
    pt.name, price
FROM
    pizzas p
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY 2 DESC
LIMIT 1;

-- 4.Identify the most common pizza size ordered.

SELECT 
    p.size, COUNT(od.order_details_id) AS Total_ordered
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY 1
ORDER BY 2 DESC;

-- 5.List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pt.name, SUM(od.quantity) AS Total_Quantity
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;