-- ============================================
-- Session 18
-- Task 05
-- Topic: Database Performance Tuning & Query Optimization
-- Objective: Recommend and explain 2 optimizations for filtering products by category and price
-- ============================================

-- Task Description:
-- List two optimizations you would apply to speed up a query that filters Flipkart products 
-- by category and price, and briefly explain how each helps.
-- Hint: Think about indexes and query structure.

-- Sample Target Query:
-- SELECT product_id, product_name, category, price, rating 
-- FROM products 
-- WHERE category = 'Electronics' AND price BETWEEN 10000 AND 50000 
-- ORDER BY price ASC;

-- ============================================
-- Optimization 1: Composite B-Tree Index on (category, price)
-- ============================================
-- SQL Statement:
CREATE INDEX idx_products_category_price ON products (category, price);

-- Explanation:
-- A composite B-Tree index structured on `(category, price)` allows the database engine 
-- to immediately navigate to the 'Electronics' slice of the index and perform a range scan 
-- directly on `price`. This avoids costly Full Table Scans (Sequential Scans) over millions 
-- of unindexed product rows, reducing disk I/O from O(N) to O(log N).

-- ============================================
-- Optimization 2: Covering Index / Avoid SELECT *
-- ============================================
-- SQL Statement (Covering Index):
CREATE INDEX idx_products_category_price_covering 
ON products (category, price) 
INCLUDE (product_name, rating);

-- Explanation:
-- By explicit column selection (`SELECT product_id, product_name, price, rating`) 
-- combined with an INCLUDE clause in PostgreSQL, the database engine executes an 
-- Index-Only Scan. All required query fields exist inside the index pages, completely 
-- skipping heap page lookups (table data access) for maximum speed.
