-- ============================================
-- Session 06
-- Task 02
-- Topic: Sorting (DESC) & Limiting Results
-- Objective: Find top 5 most expensive products using ORDER BY DESC and LIMIT
-- ============================================

-- Task:
-- Modify your previous query to show the top 5 most expensive products using ORDER BY with DESC and LIMIT.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0)
);

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Wireless Mouse', 'Electronics', 499.00),
(2, 'Gaming Headset', 'Electronics', 2499.00),
(3, 'Mechanical Keyboard', 'Electronics', 3999.00),
(4, 'USB-C Cable', 'Accessories', 199.00),
(5, 'Laptop Stand', 'Accessories', 899.00),
(6, 'Smart Watch', 'Electronics', 4999.00),
(7, 'UltraHD Monitor', 'Electronics', 18999.00)
ON CONFLICT (product_id) DO NOTHING;

-- SQL Solution:
SELECT product_id, product_name, category, price
FROM products
ORDER BY price DESC
LIMIT 5;

-- Expected Result:
-- Displays top 5 highest priced products starting with UltraHD Monitor (18999.00).
