-- ============================================
-- Session 16
-- Task 05
-- Topic: Dashboard KPI Aggregation
-- Objective: Calculate average order amount and total unique customer count for dashboards
-- ============================================

-- Task Description:
-- Create an SQL query that calculates two KPIs for the FoodOrders table: 
-- (1) average order_amount and (2) total number of unique customers, 
-- and format the output for dashboard display (two columns: kpi_name, kpi_value).

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

-- SQL Solution (Formatted Dashboard KPIs via UNION ALL):
SELECT 
    'Average Order Amount' AS kpi_name,
    TO_CHAR(AVG(order_amount), 'FM$999,999.00') AS kpi_value
FROM FoodOrders

UNION ALL

SELECT 
    'Total Unique Customers' AS kpi_name,
    COUNT(DISTINCT customer_name)::TEXT AS kpi_value
FROM FoodOrders;

-- Expected Result:
-- kpi_name                | kpi_value
-- ------------------------+-----------
-- Average Order Amount    | $555.71
-- Total Unique Customers  | 4
