-- ============================================
-- Session 16
-- Task 03
-- Topic: Customer Spend Analytics
-- Objective: Find the top 3 highest spending customers from FoodOrders
-- ============================================

-- Task Description:
-- Write an SQL query to find the top 3 customers who ordered the most 
-- from the FoodOrders table based on total order_amount, and display their names and total spent.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS FoodOrders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    order_amount DECIMAL(10, 2) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO FoodOrders (order_id, restaurant_name, customer_name, order_amount, order_date) VALUES
(1001, 'Truffles', 'Aarav Sharma', 450.00, '2024-03-01'),
(1002, 'Empire Restaurant', 'Ananya Patel', 780.00, '2024-03-01'),
(1003, 'Meghana Foods', 'Aarav Sharma', 620.00, '2024-03-02'),
(1004, 'Truffles', 'Rohan Mehta', 350.00, '2024-03-03'),
(1005, 'Corner House', 'Ananya Patel', 290.00, '2024-03-04'),
(1006, 'Meghana Foods', 'Priya Singh', 510.00, '2024-03-05'),
(1007, 'Empire Restaurant', 'Aarav Sharma', 890.00, '2024-03-06')
ON CONFLICT (order_id) DO NOTHING;

-- SQL Solution:
SELECT 
    customer_name,
    COUNT(order_id) AS total_orders_placed,
    SUM(order_amount) AS total_amount_spent
FROM FoodOrders
GROUP BY customer_name
ORDER BY total_amount_spent DESC
LIMIT 3;

-- Expected Result:
-- 1. Aarav Sharma ($1960.00 total spent across 3 orders)
-- 2. Ananya Patel ($1070.00 total spent across 2 orders)
-- 3. Priya Singh ($510.00 total spent across 1 order)
