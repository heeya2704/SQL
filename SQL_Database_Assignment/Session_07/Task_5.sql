-- ============================================
-- Session 07
-- Task 05
-- Topic: Sum Aggregation & Explicit IS NOT NULL Filter
-- Objective: Calculate total sales for non-null orders
-- ============================================

-- Task:
-- Write a SQL query to calculate the total sales (SUM of total_amount) for all orders,
-- but only include orders where total_amount is not NULL.
-- Hint: Use a WHERE clause to filter out NULL values before applying the SUM function.

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
    SUM(total_amount) AS total_sales
FROM Orders
WHERE total_amount IS NOT NULL;

-- Expected Result:
-- Total sales sum = 4590.49.
