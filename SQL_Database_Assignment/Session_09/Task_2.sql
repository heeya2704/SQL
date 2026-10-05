-- ============================================
-- Session 09
-- Task 02
-- Topic: INNER JOIN Queries
-- Objective: Display dish details alongside restaurant name and city (Zomato dish listing)
-- ============================================

-- Task:
-- Write an SQL INNER JOIN query to display each dish along with its restaurant name and city,
-- similar to how Zomato shows dish details with the restaurant info.

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
(3, 'Little Italy', 'Mumbai')
ON CONFLICT (id) DO NOTHING;

INSERT INTO dishes (id, restaurant_id, dish_name, price) VALUES
(101, 1, 'Butter Chicken', 450.00),
(102, 1, 'Dal Makhani', 320.00),
(103, 2, 'Masala Dosa', 180.00),
(105, 3, 'Margherita Pizza', 499.00)
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT 
    d.id AS dish_id,
    d.dish_name,
    d.price,
    r.name AS restaurant_name,
    r.city
FROM dishes d
INNER JOIN restaurants r ON d.restaurant_id = r.id
ORDER BY r.name ASC, d.dish_name ASC;

-- Expected Result:
-- Displays matched records showing dish_name, price, restaurant_name, and city.
