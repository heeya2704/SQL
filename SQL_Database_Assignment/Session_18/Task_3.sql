-- ============================================
-- Session 18
-- Task 03
-- Topic: Scalar Subqueries in WHERE Clause
-- Objective: Find restaurants with a rating higher than global average rating
-- ============================================

-- Task Description:
-- Write a SQL subquery to find the names of all restaurants from a 'restaurants' table 
-- (id, name, rating) whose rating is higher than the average rating of all restaurants.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    rating DECIMAL(3, 2) NOT NULL
);

INSERT INTO restaurants (id, name, rating) VALUES
(1, 'Truffles', 4.6),
(2, 'Empire Restaurant', 4.1),
(3, 'Corner House', 4.7),
(4, 'Local Food Stall', 3.2),
(5, 'Glen''s Bakehouse', 4.4)
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT 
    r.id AS restaurant_id,
    r.name AS restaurant_name,
    r.rating,
    ROUND((SELECT AVG(rating) FROM restaurants), 2) AS overall_avg_rating
FROM restaurants r
WHERE r.rating > (
    SELECT AVG(rating) 
    FROM restaurants
)
ORDER BY r.rating DESC;

-- Expected Result:
-- Global average rating = 4.20
-- Corner House (4.7), Truffles (4.6), Glen's Bakehouse (4.4)
