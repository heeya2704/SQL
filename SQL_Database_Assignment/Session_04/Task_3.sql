-- ============================================
-- Session 04
-- Task 03
-- Topic: DISTINCT Operator
-- Objective: Retrieve unique restaurant names from FoodOrders
-- ============================================

-- Task:
-- Suppose you have a table named FoodOrders with columns: id, restaurant, food_item, and order_date.
-- Write a SQL query to list all unique restaurant names where you have placed orders, using the DISTINCT keyword.

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
(3, 'Punjab Grill', 'Dal Makhani', '2024-03-05'),
(4, 'Subway', 'Paneer Tikka Sub', '2024-03-08'),
(5, 'Domino''s Pizza', 'Garlic Bread', '2024-03-10')
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT DISTINCT restaurant
FROM FoodOrders
ORDER BY restaurant ASC;

-- Expected Result:
-- Displays unique restaurant names: 'Domino's Pizza', 'Punjab Grill', 'Subway'.
