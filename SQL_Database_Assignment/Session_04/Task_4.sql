-- ============================================
-- Session 04
-- Task 04
-- Topic: Column Aliasing (AS)
-- Objective: Rename columns in output using AS keyword
-- ============================================

-- Task:
-- Write a SQL query on the FoodOrders table to select food_item as 'Dish' and order_date as 'Date Ordered',
-- displaying only these two columns with the column aliases in the output.

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

-- SQL Solution:
SELECT 
    food_item AS "Dish",
    order_date AS "Date Ordered"
FROM FoodOrders;

-- Expected Result:
-- Outputs 2 columns with headers "Dish" and "Date Ordered".
