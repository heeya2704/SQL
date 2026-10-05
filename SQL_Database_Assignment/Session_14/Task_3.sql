-- ============================================
-- Session 14
-- Task 03
-- Topic: Value Window Functions - LEAD()
-- Objective: Access next order total amount for each user
-- ============================================

-- Task Description:
-- Using the same Orders table, write a SQL query with the LEAD() function 
-- to display each order_id, order_date, and the next order's total_amount for the same user.

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
    LEAD(total_amount, 1) OVER (
        PARTITION BY user_id 
        ORDER BY order_date ASC
    ) AS next_order_amount
FROM Orders
ORDER BY user_id ASC, order_date ASC;

-- Expected Result:
-- Displays the total_amount of the user's upcoming order.
-- The last order per user shows NULL for next_order_amount.
