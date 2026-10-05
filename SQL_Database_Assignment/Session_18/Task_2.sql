-- ============================================
-- Session 18
-- Task 02
-- Topic: Multi-Table JOIN Aggregation with Handling NULL Users
-- Objective: Display usernames along with their total order amount
-- ============================================

-- Task Description:
-- Given two tables, 'orders' (order_id, user_id, amount) and 'users' (user_id, username), 
-- write a SQL JOIN query to display each username along with their total order amount.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO users (user_id, username) VALUES
(1, 'aarav_s'),
(2, 'ananya_p'),
(3, 'rohan_m'),
(4, 'priya_k') -- User with no orders yet
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO orders (order_id, user_id, amount) VALUES
(101, 1, 450.00),
(102, 1, 620.00),
(103, 2, 890.00),
(104, 3, 350.00)
ON CONFLICT (order_id) DO NOTHING;

-- SQL Solution (LEFT JOIN + COALESCE for NULL handling):
SELECT 
    u.user_id,
    u.username,
    COALESCE(SUM(o.amount), 0.00) AS total_order_amount
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY total_order_amount DESC;

-- Expected Result:
-- aarav_s ($1070.00)
-- ananya_p ($890.00)
-- rohan_m ($350.00)
-- priya_k ($0.00)
