-- ============================================
-- Session 14
-- Task 04
-- Topic: Cumulative Window Frame Aggregations (Running Total)
-- Objective: Calculate cumulative sum of order amounts per user over time
-- ============================================

-- Task Description:
-- Write a SQL query to calculate the running total of total_amount for each user, 
-- showing order_id, order_date, total_amount, and a column running_total 
-- that accumulates the sum as you move through each user's orders.
-- Hint: Use SUM(total_amount) OVER (PARTITION BY user_id ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW).

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
    SUM(total_amount) OVER (
        PARTITION BY user_id 
        ORDER BY order_date ASC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM Orders
ORDER BY user_id ASC, order_date ASC;

-- Expected Result:
-- User 1: 350 -> 870 -> 1150 -> 1790
-- User 2: 890 -> 1300 -> 2250
