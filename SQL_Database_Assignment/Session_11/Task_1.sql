-- ============================================
-- Session 11
-- Task 01
-- Topic: Subqueries in WHERE Clause
-- Objective: Find all restaurants whose rating is above their city's average rating
-- ============================================

-- Task Description:
-- Create a SQL query using a subquery in the WHERE clause to find all restaurants 
-- from a 'Restaurants' table whose average rating is higher than the average rating 
-- of all restaurants in the city (Zomato-style restaurant filtering).

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    rating DECIMAL(3, 2) NOT NULL
);

INSERT INTO Restaurants (restaurant_id, name, city, rating) VALUES
(1, 'Truffles', 'Bengaluru', 4.6),
(2, 'Empire Restaurant', 'Bengaluru', 4.1),
(3, 'Corner House', 'Bengaluru', 4.7),
(4, 'Meghana Foods', 'Bengaluru', 4.5),
(5, 'Agashiye', 'Ahmedabad', 4.8),
(6, 'Manek Chowk Eatery', 'Ahmedabad', 4.2),
(7, 'Gordhan Thal', 'Ahmedabad', 4.4),
(8, 'Bukhara', 'Delhi', 4.9),
(9, 'Karim''s', 'Delhi', 4.3),
(10, 'Paranthe Wali Gali', 'Delhi', 4.0)
ON CONFLICT (restaurant_id) DO NOTHING;

-- SQL Solution:
SELECT 
    r.restaurant_id,
    r.name AS restaurant_name,
    r.city,
    r.rating,
    ROUND((SELECT AVG(rating) FROM Restaurants WHERE city = r.city), 2) AS city_avg_rating
FROM Restaurants r
WHERE r.rating > (
    SELECT AVG(rating) 
    FROM Restaurants 
    WHERE city = r.city
)
ORDER BY r.city ASC, r.rating DESC;

-- Expected Result:
-- Returns restaurants with rating strictly greater than their respective city's average rating:
-- e.g. Truffles (4.6 > 4.47 avg in Bengaluru), Corner House (4.7 > 4.47 avg in Bengaluru),
-- Agashiye (4.8 > 4.47 avg in Ahmedabad), Bukhara (4.9 > 4.40 avg in Delhi).
