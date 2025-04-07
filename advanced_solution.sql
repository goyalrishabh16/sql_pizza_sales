-- 1. Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pt.category,
    pt.name AS pizza_name,
    concat(ROUND((SUM(od.quantity * p.price) / (SELECT 
                    ROUND(SUM(od.quantity * p.price), 2) AS Total_Revenue
                FROM
                    order_details od
                        JOIN
                    pizzas p ON od.pizza_id = p.pizza_id)) * 100,
            2),'%') AS revenue_contribution_in_perc
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1 , 2
ORDER BY 1 , 3 DESC;

-- 2. Analyze the cumulative revenue generated over time.

SELECT order_date, ROUND(revenue, 0) AS revenue,Round(sum(revenue) over(order by order_date),0) as cumulative_revenue
from (select o.order_date, sum(od.quantity * p.price) as revenue
from orders o
join order_details od
on o.order_id = od.order_id
join pizzas p
on p.pizza_id = od.pizza_id
group by 1) as daily_sales;

-- 3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select category, name , revenue, rn as top_3
from (select category,name, revenue, rank() over(partition by category order by revenue desc) as rn
from
(select pt.category, pt.name, Round(sum(od.quantity*p.price),0) as revenue
from pizza_types pt
JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
    group by 1,2
    order by 1,3 desc) as cat_revenue
) as ranking
where rn <=3
