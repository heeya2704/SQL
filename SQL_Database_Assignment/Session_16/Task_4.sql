-- ============================================
-- Session 16
-- Task 04
-- Topic: Restaurant Product Performance Report
-- Objective: Calculate total order count and total revenue per restaurant
-- ============================================

-- Task Description:
-- Generate a product performance report by writing an SQL query that lists each 
-- restaurant_name from FoodOrders, the number of orders, and the total order_amount, 
-- ordered by total order_amount descending.
-- Hint: Use GROUP BY and ORDER BY clauses.

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
    restaurant_name,
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_revenue
FROM FoodOrders
GROUP BY restaurant_name
ORDER BY total_revenue DESC;

-- Expected Result:
-- 1. Empire Restaurant: 2 orders, $1670.00 total revenue
-- 2. Meghana Foods: 2 orders, $1130.00 total revenue
-- 3. Truffles: 2 orders, $800.00 total revenue
-- 4. Corner House: 1 order, $290.00 total revenue
