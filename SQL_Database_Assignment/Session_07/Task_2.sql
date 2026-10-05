-- ============================================
-- Session 07
-- Task 02
-- Topic: Grouped Count Aggregation (COUNT & GROUP BY)
-- Objective: Count how many orders were placed by each user
-- ============================================

-- Task:
-- Write a SQL query to count how many orders were placed by each user in the Orders table,
-- displaying user_name and the number of orders as order_count.

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
    user_name,
    COUNT(order_id) AS order_count
FROM Orders
GROUP BY user_name
ORDER BY order_count DESC;

-- Expected Result:
-- Displays Aarav Sharma (2), Priya Patel (2), Rohan Verma (1).
