-- Кохортный анализ пользователей по дате регистрации
WITH first_order AS (
    SELECT user_id, MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY user_id
)
SELECT u.user_id,
       DATE_TRUNC('month', u.signup_date) AS signup_month,
       DATE_TRUNC('month', f.first_order_date) AS first_order_month
FROM users u
LEFT JOIN first_order f ON u.user_id = f.user_id
ORDER BY signup_month;