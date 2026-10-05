-- ============================================
-- Session 12
-- Task 01
-- Topic: Common Table Expressions (CTE) - Basics
-- Objective: Filter top-rated products using WITH clause
-- ============================================

-- Task Description:
-- Create a CTE using the WITH clause to select all products with a rating above 4.5 
-- from a 'Products' table, similar to how Flipkart or Myntra might highlight top-rated items.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    rating DECIMAL(3, 2) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

INSERT INTO Products (product_id, product_name, category, rating, price) VALUES
(1, 'Sony WH-1000XM5 Headphones', 'Electronics', 4.8, 29990.00),
(2, 'Levis Slim Fit Jeans', 'Fashion', 4.3, 2499.00),
(3, 'Apple MacBook Air M2', 'Electronics', 4.7, 99900.00),
(4, 'Nike Air Force 1', 'Footwear', 4.6, 8995.00),
(5, 'Samsung Galaxy S23', 'Electronics', 4.4, 74999.00)
ON CONFLICT (product_id) DO NOTHING;

-- SQL Solution (CTE Approach):
WITH TopRatedProducts AS (
    SELECT 
        product_id,
        product_name,
        category,
        rating,
        price
    FROM Products
    WHERE rating > 4.5
)
SELECT 
    product_id,
    product_name,
    category,
    rating,
    price
FROM TopRatedProducts
ORDER BY rating DESC;

-- Expected Result:
-- Returns Sony WH-1000XM5 (4.8), Apple MacBook Air M2 (4.7), and Nike Air Force 1 (4.6).
