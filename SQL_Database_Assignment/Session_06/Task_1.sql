-- ============================================
-- Session 06
-- Task 01
-- Topic: Sorting Data with ORDER BY (ASC)
-- Objective: List products sorted by price from lowest to highest (Flipkart style)
-- ============================================

-- Task:
-- Write an SQL query to display all products from a 'products' table and sort them by price in ascending order,
-- similar to how Flipkart lists items from lowest to highest price.

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
(6, 'Smart Watch', 'Electronics', 4999.00)
ON CONFLICT (product_id) DO NOTHING;

-- SQL Solution:
SELECT product_id, product_name, category, price
FROM products
ORDER BY price ASC;

-- Expected Result:
-- Displays products starting from USB-C Cable (199.00) up to Smart Watch (4999.00).
