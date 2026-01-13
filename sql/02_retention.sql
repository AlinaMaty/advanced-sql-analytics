-- Retention пользователей по месяцам
WITH cohorts AS (
    SELECT user_id, DATE_TRUNC('month', signup_date) AS cohort_month
    FROM users
),
orders_month AS (
    SELECT user_id, DATE_TRUNC('month', order_date) AS order_month
    FROM orders
)
SELECT c.cohort_month,
       o.order_month,
       COUNT(DISTINCT o.user_id) AS active_users,
       COUNT(DISTINCT c.user_id) AS total_users,
       ROUND(COUNT(DISTINCT o.user_id)::decimal / COUNT(DISTINCT c.user_id), 2) AS retention_rate
FROM cohorts c
LEFT JOIN orders_month o ON c.user_id = o.user_id
GROUP BY c.cohort_month, o.order_month
ORDER BY c.cohort_month, o.order_month;