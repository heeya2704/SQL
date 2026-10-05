-- ============================================
-- Session 08
-- Task 05
-- Topic: WHERE vs HAVING Comparison
-- Objective: Demonstrate and explain difference between WHERE and HAVING filters
-- ============================================

-- Task:
-- Explain the difference between WHERE and HAVING by giving one example query for each, using the Orders table.
-- Your examples should show a scenario where WHERE and HAVING filter different things.

/*
================================================================================
CONCEPTUAL DIFFERENCE:
--------------------------------------------------------------------------------
1. WHERE Clause:
   - Filters individual raw records BEFORE any aggregation or GROUP BY takes place.
   - Cannot contain aggregate functions (e.g. WHERE SUM(amount) > 100 is INVALID).

2. HAVING Clause:
   - Filters aggregated group summaries AFTER GROUP BY has processed rows into groups.
   - Specifically designed to evaluate conditions on aggregate functions like SUM(), AVG(), COUNT().
================================================================================
*/

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL
);

INSERT INTO Orders (order_id, user_name, payment_method, amount) VALUES
(1, 101, 'UPI', 250.00),
(2, 102, 'Card', 1200.00),
(3, 101, 'UPI', 450.00),
(4, 103, 'COD', 180.00),
(5, 104, 'Wallet', 350.00)
ON CONFLICT (order_id) DO NOTHING;

-- Example 1: WHERE Clause (Filters raw individual orders where amount > 200 BEFORE grouping)
SELECT payment_method, COUNT(*) AS qualifying_orders
FROM Orders
WHERE amount > 200 -- Filters raw rows
GROUP BY payment_method;

-- Example 2: HAVING Clause (Groups all orders, then filters aggregated groups where total sales > 500)
SELECT payment_method, SUM(amount) AS total_sales
FROM Orders
GROUP BY payment_method
HAVING SUM(amount) > 500; -- Filters aggregated groups

-- Expected Result:
-- Demonstrates row-level pre-filter (WHERE) vs group summary post-filter (HAVING).
