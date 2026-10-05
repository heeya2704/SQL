-- ============================================
-- Session 08
-- Task 04
-- Topic: Group Filtering with HAVING
-- Objective: Show payment methods where average order amount > 300
-- ============================================

-- Task:
-- Write an SQL query to show only those payment methods where the average order amount is greater than 300,
-- using GROUP BY and HAVING.
-- Hint: Use AVG(amount) in your HAVING clause.

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
    ROUND(AVG(amount), 2) AS avg_order_amount
FROM Orders
GROUP BY payment_method
HAVING AVG(amount) > 300
ORDER BY avg_order_amount DESC;

-- Expected Result:
-- Card (1025.00), UPI (400.00), Wallet (350.00) are displayed. COD (150.00) is filtered out by HAVING clause.
