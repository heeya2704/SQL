-- ============================================
-- Session 18
-- Task 04
-- Topic: Running Total Window Aggregations
-- Objective: Compute user's transaction amount and cumulative running sum
-- ============================================

-- Task Description:
-- Using a 'transactions' table (id, user_id, amount, transaction_date), 
-- write a SQL query with a window function to display each user's transaction amount 
-- and their running total (cumulative sum) ordered by transaction_date.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS transactions (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_date DATE NOT NULL
);

INSERT INTO transactions (id, user_id, amount, transaction_date) VALUES
(1, 101, 500.00, '2024-03-01'),
(2, 101, 250.00, '2024-03-03'),
(3, 101, 1000.00, '2024-03-07'),
(4, 102, 1200.00, '2024-03-02'),
(5, 102, 400.00, '2024-03-05')
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT 
    id AS transaction_id,
    user_id,
    transaction_date,
    amount AS transaction_amount,
    SUM(amount) OVER (
        PARTITION BY user_id 
        ORDER BY transaction_date ASC 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS user_running_total
FROM transactions
ORDER BY user_id ASC, transaction_date ASC;

-- Expected Result:
-- User 101: $500.00 -> $750.00 -> $1750.00
-- User 102: $1200.00 -> $1600.00
