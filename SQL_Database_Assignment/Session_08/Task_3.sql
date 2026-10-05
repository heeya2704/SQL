-- ============================================
-- Session 08
-- Task 03
-- Topic: User Spend Aggregation
-- Objective: Calculate total spend for each user_id
-- ============================================

-- Task:
-- Write an SQL query to find the total amount spent by each user_id in the Orders table.
-- Display user_id and their total spend.

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
    user_id,
    SUM(amount) AS total_spend
FROM Orders
GROUP BY user_id
ORDER BY total_spend DESC;

-- Expected Result:
-- Displays User 102 (2050.00), User 101 (820.00), User 103 (680.00), User 104 (350.00).
