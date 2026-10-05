-- ============================================
-- Session 10
-- Task 05
-- Topic: Join Predicates & Performance Optimization
-- Objective: Compare ON predicate vs USING clause vs WHERE filter join conditions
-- ============================================

-- Task:
-- Write two different JOIN queries on a Products and Categories table (like Flipkart) to list all products
-- with their category names, but use different join conditions in each.
-- Briefly explain which join condition is more efficient and why.

/*
================================================================================
JOIN CONDITION EFFICIENCY COMPARISON:
--------------------------------------------------------------------------------
Approach 1: `INNER JOIN categories c ON p.category_id = c.category_id` (Explicit ON join condition)
Approach 2: `INNER JOIN categories USING (category_id)` (Standard ANSI USING syntactic sugar)
Approach 3: `FROM products p, categories c WHERE p.category_id = c.category_id` (Implicit Cartesian product filtered by WHERE)

Efficiency Evaluation:
- Approaches 1 (`ON`) and 2 (`USING`) compile to identical physical execution plans (Hash Join / Nested Loop Join) inside modern query optimizers (PostgreSQL / MySQL / Oracle).
- Approach 3 (Implicit comma join in WHERE clause) is prone to developer mistakes (accidental missing filter = CROSS JOIN) and legacy syntax.
- Conclusion: The explicit `ON` / `USING` syntax is far more readable, maintainable, and guarantees the query engine applies join predicates during scan rather than post-filtering Cartesian products.
================================================================================
*/

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT REFERENCES categories(category_id),
    price NUMERIC(10, 2) NOT NULL
);

INSERT INTO categories (category_id, category_name) VALUES
(1, 'Electronics'),
(2, 'Fashion')
ON CONFLICT (category_id) DO NOTHING;

INSERT INTO products (product_id, product_name, category_id, price) VALUES
(101, 'Smartphone X', 1, 49999.00),
(102, 'Denim Jacket', 2, 2499.00)
ON CONFLICT (product_id) DO NOTHING;

-- Query 1: Explicit ON Join Condition (Recommended Production Standard)
SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    p.price
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id;

-- Query 2: USING Join Clause (Clean syntax for matching PK/FK column names)
SELECT 
    product_id,
    product_name,
    category_id,
    category_name,
    price
FROM products
INNER JOIN categories USING (category_id);

-- Expected Result:
-- Both queries yield identical result sets mapping products to categories efficiently.
