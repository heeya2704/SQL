-- ============================================
-- Session 19
-- Task 01
-- Topic: Zomato Bangalore Dataset Analytics - Location & Cuisine Filtering
-- Objective: Find top 5 highest-rated North Indian restaurants in Koramangala
-- ============================================

-- Task Description:
-- Write an SQL query to find the top 5 highest-rated restaurants in Koramangala 
-- that serve North Indian cuisine, using the Zomato Bangalore dataset.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Zomato_Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(50) NOT NULL,
    cuisines VARCHAR(150) NOT NULL,
    rating DECIMAL(3, 2) NOT NULL,
    approx_cost_for_two INT NOT NULL
);

INSERT INTO Zomato_Restaurants (restaurant_id, name, location, cuisines, rating, approx_cost_for_two) VALUES
(1, 'Punjab Grill', 'Koramangala 5th Block', 'North Indian, Mughlai', 4.8, 1200),
(2, 'Kapoor''s Cafe', 'Koramangala 4th Block', 'North Indian, Punjabi', 4.6, 600),
(3, 'Truffles', 'Koramangala 5th Block', 'American, Burgers', 4.7, 900),
(4, 'Sultanate of Dhaba', 'Koramangala 5th Block', 'North Indian', 4.5, 800),
(5, 'Kundan', 'Koramangala 7th Block', 'North Indian, Chinese', 4.4, 500),
(6, 'Gramin', 'Koramangala 7th Block', 'North Indian, Rajasthani', 4.3, 600),
(7, 'Empire Restaurant', 'Indiranagar', 'North Indian, Kebabs', 4.2, 750)
ON CONFLICT (restaurant_id) DO NOTHING;

-- SQL Solution:
SELECT 
    name AS restaurant_name,
    location,
    cuisines,
    rating,
    approx_cost_for_two
FROM Zomato_Restaurants
WHERE location LIKE '%Koramangala%'
  AND cuisines LIKE '%North Indian%'
ORDER BY rating DESC, approx_cost_for_two ASC
LIMIT 5;

-- Expected Result:
-- 1. Punjab Grill (4.8 rating)
-- 2. Kapoor's Cafe (4.6 rating)
-- 3. Sultanate of Dhaba (4.5 rating)
-- 4. Kundan (4.4 rating)
-- 5. Gramin (4.3 rating)
