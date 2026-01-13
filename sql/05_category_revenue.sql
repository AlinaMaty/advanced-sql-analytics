-- Выручка по категориям и месяцам
SELECT 
    category,
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
GROUP BY category, month
ORDER BY category, month;
