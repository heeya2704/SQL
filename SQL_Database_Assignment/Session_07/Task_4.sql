-- ============================================
-- Session 07
-- Task 04
-- Topic: Min & Max Aggregations (MIN/MAX)
-- Objective: Find highest and lowest order amounts in a single result row
-- ============================================

-- Task:
-- Suppose you are building a Flipkart-style dashboard: Write a SQL query to find the highest and lowest order amounts
-- (MAX and MIN) from the Orders table, and display both values in a single result row.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    total_amount NUMERIC(10, 2),
    order_date DATE NOT NULL
);

INSERT INTO Orders (order_id, user_name, total_amount, order_date) VALUES
(101, 'Aarav Sharma', 1250.00, '2024-03-01'),
(102, 'Priya Patel', 450.50, '2024-03-02'),
(103, 'Aarav Sharma', 890.00, '2024-03-05'),
(104, 'Rohan Verma', NULL, '2024-03-06'),
(105, 'Priya Patel', 1999.99, '2024-03-10')
ON CONFLICT (order_id) DO NOTHING;

-- SQL Solution:
SELECT 
    MAX(total_amount) AS highest_order_amount,
    MIN(total_amount) AS lowest_order_amount
FROM Orders;

-- Expected Result:
-- Displays highest_order_amount = 1999.99 and lowest_order_amount = 450.50 in 1 row.
