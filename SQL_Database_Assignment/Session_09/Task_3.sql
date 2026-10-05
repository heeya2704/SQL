-- ============================================
-- Session 09
-- Task 03
-- Topic: LEFT JOIN Queries
-- Objective: List all restaurants and dishes, including restaurants with no dishes
-- ============================================

-- Task:
-- Write an SQL LEFT JOIN query to list all restaurants and their dishes,
-- showing restaurants even if they currently have no dishes on the menu.
-- Hint: Use LEFT JOIN so restaurants without dishes still appear in the results with NULL for dish columns.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS dishes (
    id INT PRIMARY KEY,
    restaurant_id INT,
    dish_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL
);

INSERT INTO restaurants (id, name, city) VALUES
(1, 'Punjab Grill', 'Delhi'),
(2, 'Swagat Restaurant', 'Ahmedabad'),
(4, 'New Unlisted Cafe', 'Surat') -- No dishes attached
ON CONFLICT (id) DO NOTHING;

INSERT INTO dishes (id, restaurant_id, dish_name, price) VALUES
(101, 1, 'Butter Chicken', 450.00),
(103, 2, 'Masala Dosa', 180.00)
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT 
    r.id AS restaurant_id,
    r.name AS restaurant_name,
    r.city,
    d.dish_name,
    d.price
FROM restaurants r
LEFT JOIN dishes d ON r.id = d.restaurant_id
ORDER BY r.name ASC;

-- Expected Result:
-- 'New Unlisted Cafe' is included in output with NULL for dish_name and price.
