-- ============================================
-- Session 17
-- Task 02
-- Topic: Cuisine Distribution Report
-- Objective: Group restaurants by cuisine type and count occurrences descending
-- ============================================

-- Task Description:
-- Write a SQL query to generate a report showing the number of restaurants for 
-- each cuisine type from your Restaurant table, ordered by the count in descending order.
-- Hint: Use GROUP BY and ORDER BY.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    average_rating DECIMAL(3, 2) NOT NULL
);

INSERT INTO Restaurant (id, name, cuisine, location, average_rating) VALUES
(1, 'Truffles', 'American', 'Koramangala', 4.6),
(2, 'Empire Restaurant', 'North Indian', 'Indiranagar', 4.1),
(3, 'Meghana Foods', 'Biryani', 'Jayanagar', 4.5),
(4, 'Corner House', 'Desserts', 'Koramangala', 4.7),
(5, 'Glen''s Bakehouse', 'Desserts', 'Indiranagar', 4.4)
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT 
    cuisine,
    COUNT(*) AS restaurant_count
FROM Restaurant
GROUP BY cuisine
ORDER BY restaurant_count DESC, cuisine ASC;

-- Expected Result:
-- Desserts: 2 restaurants
-- American: 1 restaurant
-- Biryani: 1 restaurant
-- North Indian: 1 restaurant
