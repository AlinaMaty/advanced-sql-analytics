-- LTV (Lifetime Value) пользователей по когорте и месяцу
WITH cohorts AS (
    SELECT 
        user_id, 
        DATE_TRUNC('month', signup_date) AS cohort_month
    FROM users
)
SELECT 
    c.cohort_month,
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(o.total_amount) AS revenue,
    COUNT(DISTINCT c.user_id) AS users_count,
    ROUND(SUM(o.total_amount)::decimal / COUNT(DISTINCT c.user_id), 2) AS ltv
FROM cohorts c
JOIN orders o ON c.user_id = o.user_id
GROUP BY c.cohort_month, month
ORDER BY c.cohort_month, month;
