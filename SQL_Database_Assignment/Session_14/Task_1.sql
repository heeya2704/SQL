-- ============================================
-- Session 14
-- Task 01
-- Topic: Table Creation & Seed Data Setup
-- Objective: Create Orders table and insert sample order data
-- ============================================

-- Task Description:
-- Create a table called Orders with columns: order_id, user_id, order_date, and total_amount. 
-- Insert at least 7 sample rows representing different users and dates, 
-- similar to how food orders appear in Zomato or Swiggy.

-- Table Definition:
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount > 0)
);

-- Seed Data (7+ Rows):
INSERT INTO Orders (order_id, user_id, order_date, total_amount) VALUES
(1001, 1, '2024-03-01', 350.00),
(1002, 1, '2024-03-04', 520.00),
(1003, 1, '2024-03-10', 280.00),
(1004, 1, '2024-03-15', 640.00),
(1005, 2, '2024-03-02', 890.00),
(1006, 2, '2024-03-08', 410.00),
(1007, 2, '2024-03-14', 950.00),
(1008, 3, '2024-03-05', 150.00)
ON CONFLICT (order_id) DO NOTHING;

-- Verification Query:
SELECT 
    order_id,
    user_id,
    order_date,
    total_amount
FROM Orders
ORDER BY user_id ASC, order_date ASC;
