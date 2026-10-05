-- ============================================
-- Session 19
-- Task 02
-- Topic: Zomato Bangalore Dataset Analytics - Cost & Cuisine Aggregation
-- Objective: Calculate average cost for two per cuisine and list 3 most expensive cuisines
-- ============================================

-- Task Description:
-- Using SQL, calculate the average cost for two people for each cuisine type 
-- and list the 3 most expensive cuisines to eat in Bangalore.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Zomato_Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    primary_cuisine VARCHAR(50) NOT NULL,
    approx_cost_for_two INT NOT NULL
);

INSERT INTO Zomato_Restaurants (restaurant_id, name, primary_cuisine, approx_cost_for_two) VALUES
(1, 'Le Cirque Signature', 'Fine Dining French', 5000),
(2, 'L''Open', 'Fine Dining French', 4500),
(3, 'Edo Restaurant', 'Japanese', 3500),
(4, 'Harima', 'Japanese', 2500),
(5, 'Karavalli', 'Coastal Seafood', 3000),
(6, 'Rim Naam', 'Thai', 2800),
(7, 'Truffles', 'American', 800),
(8, 'Empire', 'North Indian', 600)
ON CONFLICT (restaurant_id) DO NOTHING;

-- SQL Solution:
SELECT 
    primary_cuisine,
    COUNT(restaurant_id) AS total_restaurants,
    ROUND(AVG(approx_cost_for_two), 2) AS avg_cost_for_two
FROM Zomato_Restaurants
GROUP BY primary_cuisine
ORDER BY avg_cost_for_two DESC
LIMIT 3;

-- Expected Result:
-- 1. Fine Dining French ($4750.00 avg cost)
-- 2. Japanese ($3000.00 avg cost)
-- 3. Coastal Seafood ($3000.00 avg cost)
