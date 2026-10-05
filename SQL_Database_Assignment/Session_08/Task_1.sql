-- ============================================
-- Session 08
-- Task 01
-- Topic: Data Population for Analytics
-- Objective: Create 'Orders' table with payment_method and insert 8 records
-- ============================================

-- Task:
-- Create a table called Orders with columns: order_id, user_id, payment_method, and amount.
-- Insert at least 8 sample records representing different users and payment methods (like UPI, Card, Wallet, COD).

-- SQL Solution:
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL CHECK (payment_method IN ('UPI', 'Card', 'Wallet', 'COD')),
    amount NUMERIC(10, 2) NOT NULL CHECK (amount >= 0)
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

-- Retrieve setup data:
SELECT * FROM Orders;

-- Expected Result:
-- 8 order records inserted with varied payment methods and users.
