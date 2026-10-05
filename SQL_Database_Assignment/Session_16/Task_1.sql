-- ============================================
-- Session 16
-- Task 01
-- Topic: CSV Data Import & Table Creation
-- Objective: Create FoodOrders table for imported food delivery orders
-- ============================================

-- Task Description:
-- Import a CSV file of food delivery orders (with columns like order_id, restaurant_name, 
-- customer_name, order_amount, order_date) into a new SQL table named FoodOrders.

-- Table Definition:
CREATE TABLE IF NOT EXISTS FoodOrders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    order_amount DECIMAL(10, 2) NOT NULL,
    order_date DATE NOT NULL
);

-- Seed Data (Simulating Imported CSV Records):
INSERT INTO FoodOrders (order_id, restaurant_name, customer_name, order_amount, order_date) VALUES
(1001, 'Truffles', 'Aarav Sharma', 450.00, '2024-03-01'),
(1002, 'Empire Restaurant', 'Ananya Patel', 780.00, '2024-03-01'),
(1003, 'Meghana Foods', 'Aarav Sharma', 620.00, '2024-03-02'),
(1004, 'Truffles', 'Rohan Mehta', 350.00, '2024-03-03'),
(1005, 'Corner House', 'Ananya Patel', 290.00, '2024-03-04'),
(1006, 'Meghana Foods', 'Priya Singh', 510.00, '2024-03-05'),
(1007, 'Empire Restaurant', 'Aarav Sharma', 890.00, '2024-03-06')
ON CONFLICT (order_id) DO NOTHING;

-- Verification Query:
SELECT * FROM FoodOrders ORDER BY order_id ASC;
