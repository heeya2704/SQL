-- ============================================
-- Session 19
-- Task 05
-- Topic: Top 10 Popular Restaurant Chains (AI-Assisted & Validated Query)
-- Objective: Rank top 10 restaurant chains by total outlet count in Zomato Bangalore dataset
-- ============================================

-- Task Description:
-- Use ChatGPT or Copilot to help you write an SQL query that lists the top 10 
-- most popular restaurant chains (by number of outlets) in the dataset, 
-- then run and validate the query yourself.
-- Hint: Search for 'SQL group by count example' if you get stuck.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Zomato_Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(50) NOT NULL,
    rating DECIMAL(3, 2) NOT NULL
);

INSERT INTO Zomato_Restaurants (restaurant_id, name, location, rating) VALUES
(1, 'Onesta', 'Koramangala', 4.4),
(2, 'Onesta', 'Indiranagar', 4.3),
(3, 'Onesta', 'Jayanagar', 4.5),
(4, 'Empire Restaurant', 'Indiranagar', 4.1),
(5, 'Empire Restaurant', 'Koramangala', 4.2),
(6, 'Empire Restaurant', 'Jayanagar', 4.0),
(7, 'Empire Restaurant', 'BTM', 4.1),
(8, 'Kanti Sweets', 'Malleshwaram', 4.3),
(9, 'Kanti Sweets', 'Rajajinagar', 4.2),
(10, 'Kanti Sweets', 'Jayanagar', 4.4),
(11, 'KFC', 'Koramangala', 4.0),
(12, 'KFC', 'Indiranagar', 4.1),
(13, 'McDonald''s', 'Koramangala', 4.2),
(14, 'McDonald''s', 'MG Road', 4.3),
(15, 'Domino''s Pizza', 'Koramangala', 4.2),
(16, 'Domino''s Pizza', 'HSR', 4.1)
ON CONFLICT (restaurant_id) DO NOTHING;

-- SQL Solution (Validated Query):
SELECT 
    name AS chain_name,
    COUNT(DISTINCT location) AS total_outlets,
    ROUND(AVG(rating), 2) AS average_chain_rating
FROM Zomato_Restaurants
GROUP BY name
HAVING COUNT(DISTINCT location) >= 1
ORDER BY total_outlets DESC, average_chain_rating DESC
LIMIT 10;

-- Expected Result:
-- 1. Empire Restaurant (4 outlets, 4.10 avg rating)
-- 2. Kanti Sweets (3 outlets, 4.30 avg rating)
-- 3. Onesta (3 outlets, 4.40 avg rating)
-- 4. McDonald's (2 outlets, 4.25 avg rating)
-- 5. Domino's Pizza (2 outlets, 4.15 avg rating)
-- 6. KFC (2 outlets, 4.05 avg rating)
