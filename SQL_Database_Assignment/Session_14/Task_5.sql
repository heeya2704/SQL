-- ============================================
-- Session 14
-- Task 05
-- Topic: Moving Window Frame Aggregations (Moving Average)
-- Objective: Calculate a 3-order moving average of order amounts per user
-- ============================================

-- Task Description:
-- Write a SQL query to calculate a 3-order moving average of total_amount for each user, 
-- showing order_id, order_date, total_amount, and moving_avg columns.
-- Constraint: Use AVG() OVER() with ROWS BETWEEN 2 PRECEDING AND CURRENT ROW to compute the moving average.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO Orders (order_id, user_id, order_date, total_amount) VALUES
(1001, 1, '2024-03-01', 350.00),
(1002, 1, '2024-03-04', 520.00),
(1003, 1, '2024-03-10', 280.00),
(1004, 1, '2024-03-15', 640.00),
(1005, 2, '2024-03-02', 890.00),
(1006, 2, '2024-03-08', 410.00),
(1007, 2, '2024-03-14', 950.00)
ON CONFLICT (order_id) DO NOTHING;

-- SQL Solution:
SELECT 
    order_id,
    user_id,
    order_date,
    total_amount,
    ROUND(
        AVG(total_amount) OVER (
            PARTITION BY user_id 
            ORDER BY order_date ASC 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_3_orders
FROM Orders
ORDER BY user_id ASC, order_date ASC;

-- Expected Result:
-- User 1:
--   Order 1 (350): avg(350) = 350.00
--   Order 2 (520): avg(350, 520) = 435.00
--   Order 3 (280): avg(350, 520, 280) = 383.33
--   Order 4 (640): avg(520, 280, 640) = 480.00
