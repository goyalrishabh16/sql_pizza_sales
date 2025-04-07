-- 1. Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pt.category, SUM(od.quantity) AS Total_quantity
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY 1
ORDER BY 2 DESC;

-- 2. Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS Working_hour,
    COUNT(order_id) AS order_count
FROM
    orders
GROUP BY 1
ORDER BY 1;

-- 3. Join relevant tables to find the category-wise distribution of pizzas.
select category, count(pizza_type_id) as variants
from pizza_types
group by 1
order by 2 desc;

-- 4. Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) AS average_order_per_day
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS quantity
    FROM
        orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY 1) AS order_quantity;
    
-- 5. Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pt.name AS pizza_type,
    Round(SUM(od.quantity * p.price),0) AS total_revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3

