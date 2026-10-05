-- ============================================
-- Session 11
-- Task 04
-- Topic: Nested Subqueries (Relational Division)
-- Objective: Find sellers who have sold products across all available categories
-- ============================================

-- Task Description:
-- Write a nested SQL query to find the names of all sellers from a 'Sellers' table 
-- on a Flipkart-style platform who have sold products in every category listed in a 'Categories' table.
-- Hint: Use nested subqueries to compare seller's categories with the complete list of categories.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Sellers (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT REFERENCES Categories(category_id)
);

CREATE TABLE IF NOT EXISTS Sales (
    sale_id INT PRIMARY KEY,
    seller_id INT REFERENCES Sellers(seller_id),
    product_id INT REFERENCES Products(product_id),
    sale_date DATE NOT NULL
);

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Fashion'),
(3, 'Home & Kitchen')
ON CONFLICT (category_id) DO NOTHING;

INSERT INTO Sellers (seller_id, seller_name) VALUES
(101, 'OmniRetail Ltd'),   -- Sells in all 3 categories
(102, 'FashionHub Inc'),   -- Sells only in Fashion
(103, 'GlobalTraders Co') -- Sells in Electronics & Home, missing Fashion
ON CONFLICT (seller_id) DO NOTHING;

INSERT INTO Products (product_id, product_name, category_id) VALUES
(1, 'Smartphone X', 1),
(2, 'Designer Jacket', 2),
(3, 'Air Fryer', 3)
ON CONFLICT (product_id) DO NOTHING;

INSERT INTO Sales (sale_id, seller_id, product_id, sale_date) VALUES
-- OmniRetail Ltd (101) sold in all 3 categories
(1, 101, 1, '2024-01-10'),
(2, 101, 2, '2024-01-12'),
(3, 101, 3, '2024-01-15'),
-- FashionHub Inc (102)
(4, 102, 2, '2024-02-01'),
-- GlobalTraders Co (103)
(5, 103, 1, '2024-02-10'),
(6, 103, 3, '2024-02-11')
ON CONFLICT (sale_id) DO NOTHING;

-- SQL Solution (Nested NOT EXISTS Subqueries):
SELECT 
    s.seller_id,
    s.seller_name
FROM Sellers s
WHERE NOT EXISTS (
    SELECT c.category_id
    FROM Categories c
    WHERE NOT EXISTS (
        SELECT 1
        FROM Sales sa
        JOIN Products p ON sa.product_id = p.product_id
        WHERE sa.seller_id = s.seller_id 
          AND p.category_id = c.category_id
    )
)
ORDER BY s.seller_id ASC;

-- Expected Result:
-- Only 'OmniRetail Ltd' is returned because it is the only seller with sales in all categories (Electronics, Fashion, Home & Kitchen).
