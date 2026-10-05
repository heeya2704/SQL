-- ============================================
-- Session 14
-- Task 02
-- Topic: Value Window Functions - LAG()
-- Objective: Access previous order total amount for each user
-- ============================================

-- Task Description:
-- Write a SQL query using the LAG() function to show each user's order_id, order_date, 
-- and the total_amount of their previous order (if any), ordered by user and date.
-- Hint: Use PARTITION BY user_id and ORDER BY order_date in your window function.

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
    LAG(total_amount, 1) OVER (
        PARTITION BY user_id 
        ORDER BY order_date ASC
    ) AS previous_order_amount
FROM Orders
ORDER BY user_id ASC, order_date ASC;

-- Expected Result:
-- First order per user shows NULL for previous_order_amount.
-- Subsequent orders display the total_amount of the user's prior order.
