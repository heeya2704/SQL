-- ============================================
-- Session 09
-- Task 04
-- Topic: RIGHT JOIN Queries & Data Anomaly Handling
-- Objective: Display all dishes and restaurant names, including unlinked dishes
-- ============================================

-- Task:
-- Write an SQL RIGHT JOIN query to display all dishes and their restaurant names,
-- including any dishes that might not be linked to a restaurant (simulate a data error where a dish has a restaurant_id that doesn't match any restaurant).

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
(2, 'Swagat Restaurant', 'Ahmedabad')
ON CONFLICT (id) DO NOTHING;

INSERT INTO dishes (id, restaurant_id, dish_name, price) VALUES
(101, 1, 'Butter Chicken', 450.00),
(107, 999, 'Orphan Special Drink', 99.00) -- Invalid restaurant_id = 999
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT 
    d.id AS dish_id,
    d.dish_name,
    d.price,
    d.restaurant_id AS dish_restaurant_fk,
    r.name AS restaurant_name,
    r.city
FROM restaurants r
RIGHT JOIN dishes d ON r.id = d.restaurant_id;

-- Expected Result:
-- Displays 'Orphan Special Drink' with NULL for restaurant_name and city.
