-- ============================================
-- Session 07
-- Task 01
-- Topic: Aggregations Setup & NULL Handling
-- Objective: Create 'Orders' table with sample data containing NULL total_amount
-- ============================================

-- Task:
-- Create a table called Orders with columns: order_id, user_name, total_amount, and order_date.
-- Insert 5 sample rows with different users and order amounts, including at least one NULL value for total_amount.

-- SQL Solution:
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    total_amount NUMERIC(10, 2), -- Allowed NULL for pending/unbilled orders
    order_date DATE NOT NULL
);

INSERT INTO Orders (order_id, user_name, total_amount, order_date) VALUES
(101, 'Aarav Sharma', 1250.00, '2024-03-01'),
(102, 'Priya Patel', 450.50, '2024-03-02'),
(103, 'Aarav Sharma', 890.00, '2024-03-05'),
(104, 'Rohan Verma', NULL, '2024-03-06'), -- Pending order with NULL amount
(105, 'Priya Patel', 1999.99, '2024-03-10')
ON CONFLICT (order_id) DO NOTHING;

-- Retrieve setup data:
SELECT * FROM Orders;

-- Expected Result:
-- 'Orders' table populated with 5 records, including order_id 104 with total_amount = NULL.
