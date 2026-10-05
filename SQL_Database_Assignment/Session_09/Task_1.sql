-- ============================================
-- Session 09
-- Task 01
-- Topic: Relational Tables & Foreign Keys Setup
-- Objective: Create 'restaurants' and 'dishes' tables with relational sample data
-- ============================================

-- Task:
-- Create two tables in your database: 'restaurants' (id, name, city) and 'dishes' (id, restaurant_id, dish_name, price).
-- Insert at least 3 restaurants and 2-3 dishes for each restaurant.

-- SQL Solution:
CREATE TABLE IF NOT EXISTS restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS dishes (
    id INT PRIMARY KEY,
    restaurant_id INT REFERENCES restaurants(id) ON DELETE CASCADE,
    dish_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0)
);

INSERT INTO restaurants (id, name, city) VALUES
(1, 'Punjab Grill', 'Delhi'),
(2, 'Swagat Restaurant', 'Ahmedabad'),
(3, 'Little Italy', 'Mumbai'),
(4, 'New Unlisted Cafe', 'Surat') -- Restaurant with no dishes (for LEFT JOIN testing)
ON CONFLICT (id) DO NOTHING;

INSERT INTO dishes (id, restaurant_id, dish_name, price) VALUES
(101, 1, 'Butter Chicken', 450.00),
(102, 1, 'Dal Makhani', 320.00),
(103, 2, 'Masala Dosa', 180.00),
(104, 2, 'Idli Sambhar', 120.00),
(105, 3, 'Margherita Pizza', 499.00),
(106, 3, 'Pasta Alfredo', 420.00),
(107, 999, 'Orphan Special Drink', 99.00) -- Dish with unlisted restaurant_id (for RIGHT JOIN testing)
ON CONFLICT (id) DO NOTHING;

-- Retrieve setup data:
SELECT * FROM restaurants;
SELECT * FROM dishes;

-- Expected Result:
-- 4 restaurants and 7 dishes created to support all join scenarios.
