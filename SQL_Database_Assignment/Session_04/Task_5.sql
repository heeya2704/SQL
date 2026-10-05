-- ============================================
-- Session 04
-- Task 05
-- Topic: SQL Syntax Debugging & Query Optimization
-- Objective: Fix mistake in DISTINCT + LIMIT query
-- ============================================

-- Task:
-- You tried running this query: SELECT DISTINCT food_item, restaurant FROM FoodOrders LIMIT 2, 
-- but it returns an error or doesn't work as expected. Identify and fix the mistake in the query.
-- Hint: Check the correct placement and usage of the LIMIT keyword in SQL syntax.

/*
================================================================================
EXPLANATION OF THE QUERY BEHAVIOR & SYNTAX VALIDATION:
--------------------------------------------------------------------------------
1. Standard SQL Syntax:
   SELECT DISTINCT food_item, restaurant 
   FROM FoodOrders 
   LIMIT 2;
   - In PostgreSQL / SQLite / MySQL, LIMIT 2 must come AFTER the FROM clause.
   - If MySQL syntax `LIMIT offset, count` (e.g. `LIMIT 2, 5`) was used without understanding offset, it could cause confusion.
   - Without an ORDER BY clause, LIMIT returns non-deterministic rows!

2. Correct Deterministic Query Pattern:
   Always pair LIMIT with ORDER BY so results are predictable.
================================================================================
*/

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS FoodOrders (
    id INT PRIMARY KEY,
    restaurant VARCHAR(100) NOT NULL,
    food_item VARCHAR(100) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO FoodOrders (id, restaurant, food_item, order_date) VALUES
(1, 'Punjab Grill', 'Butter Chicken', '2024-03-01'),
(2, 'Domino''s Pizza', 'Farmhouse Pizza', '2024-03-02'),
(3, 'Punjab Grill', 'Dal Makhani', '2024-03-05')
ON CONFLICT (id) DO NOTHING;

-- SQL Solution (Corrected & Standardized):
SELECT DISTINCT food_item, restaurant
FROM FoodOrders
ORDER BY food_item ASC
LIMIT 2;

-- Expected Result:
-- Returns top 2 distinct (food_item, restaurant) combinations deterministically ordered by food_item.
