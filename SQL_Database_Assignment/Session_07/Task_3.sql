-- ============================================
-- Session 07
-- Task 03
-- Topic: Average Aggregation (AVG)
-- Objective: Calculate average total_amount ignoring NULL values
-- ============================================

-- Task:
-- Write a SQL query to calculate the average total_amount of all orders in the Orders table,
-- making sure to ignore any NULL values.

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
    ROUND(AVG(total_amount), 2) AS average_order_amount
FROM Orders;

-- Expected Result:
-- Calculates sum (1250 + 450.50 + 890 + 1999.99 = 4590.49) divided by 4 non-null orders = 1147.62.
