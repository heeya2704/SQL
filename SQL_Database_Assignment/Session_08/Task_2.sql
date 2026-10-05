-- ============================================
-- Session 08
-- Task 02
-- Topic: Grouped Aggregations for Analytics
-- Objective: Count order breakdown by payment_method (Zomato payment analytics)
-- ============================================

-- Task:
-- Write an SQL query to count how many orders were placed using each payment_method in the Orders table,
-- similar to how Zomato shows payment breakdown in analytics.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL
);

INSERT INTO Orders (order_id, user_id, payment_method, amount) VALUES
(1, 101, 'UPI', 250.00),
(2, 102, 'Card', 1200.00),
(3, 101, 'UPI', 450.00),
(4, 103, 'COD', 180.00),
(5, 104, 'Wallet', 350.00),
(6, 102, 'Card', 850.00),
(7, 103, 'UPI', 500.00),
(8, 101, 'COD', 120.00)
ON CONFLICT (order_id) DO NOTHING;

-- SQL Solution:
SELECT 
    payment_method,
    COUNT(order_id) AS total_orders
FROM Orders
GROUP BY payment_method
ORDER BY total_orders DESC;

-- Expected Result:
-- Displays UPI (3), Card (2), COD (2), Wallet (1).
