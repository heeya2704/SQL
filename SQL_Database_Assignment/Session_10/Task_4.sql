-- ============================================
-- Session 10
-- Task 04
-- Topic: Deduplication in Joins (DISTINCT / GROUP BY)
-- Objective: Eliminate duplicate rows in 1-to-many relationship join (Zomato Restaurants & Reviews)
-- ============================================

-- Task:
-- You notice that your JOIN query between Zomato's Restaurants and Reviews tables is returning duplicate rows for some restaurants.
-- Modify your query to eliminate duplicates and explain in one line why the duplicates were happening.
-- Hint: Use DISTINCT or GROUP BY and consider the relationship between restaurants and reviews.

/*
================================================================================
ONE-LINE DUPLICATION EXPLANATION:
--------------------------------------------------------------------------------
Duplicates occur because the 1-to-many relationship between a restaurant and multiple reviews causes the restaurant row to multiply for every matching review entry.
================================================================================
*/

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Reviews (
    id INT PRIMARY KEY,
    restaurant_id INT REFERENCES Restaurants(id),
    rating NUMERIC(3, 1) NOT NULL,
    comment TEXT
);

INSERT INTO Restaurants (id, name, city) VALUES
(1, 'Punjab Grill', 'Delhi'),
(2, 'Swagat Restaurant', 'Ahmedabad')
ON CONFLICT (id) DO NOTHING;

INSERT INTO Reviews (id, restaurant_id, rating, comment) VALUES
(101, 1, 4.5, 'Great food!'),
(102, 1, 4.8, 'Excellent service!'),
(103, 1, 4.2, 'Loved the dal makhani.'),
(104, 2, 4.0, 'Nice ambience.')
ON CONFLICT (id) DO NOTHING;

-- Problematic Query (Produces 3 rows for Punjab Grill):
-- SELECT r.id, r.name, r.city FROM Restaurants r INNER JOIN Reviews rev ON r.id = rev.restaurant_id;

-- SQL Solution 1: Using DISTINCT
SELECT DISTINCT 
    r.id AS restaurant_id,
    r.name AS restaurant_name,
    r.city
FROM Restaurants r
INNER JOIN Reviews rev ON r.id = rev.restaurant_id
ORDER BY r.id ASC;

-- SQL Solution 2: Using GROUP BY with Aggregated Summary
SELECT 
    r.id AS restaurant_id,
    r.name AS restaurant_name,
    r.city,
    COUNT(rev.id) AS total_reviews,
    ROUND(AVG(rev.rating), 2) AS average_rating
FROM Restaurants r
INNER JOIN Reviews rev ON r.id = rev.restaurant_id
GROUP BY r.id, r.name, r.city
ORDER BY r.id ASC;

-- Expected Result:
-- Returns exactly 1 deduplicated row per restaurant.
