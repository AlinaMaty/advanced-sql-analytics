-- Топ-продукты по продажам с ранжированием в каждой категории
SELECT 
    product_id,
    category,
    SUM(quantity) AS total_quantity,
    SUM(quantity * price) AS revenue,
    RANK() OVER (PARTITION BY category ORDER BY SUM(quantity * price) DESC) AS category_rank
FROM order_items
GROUP BY product_id, category
ORDER BY category, category_rank;
