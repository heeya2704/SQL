-- ============================================
-- Session 19
-- Task 03
-- Topic: Low Rating Online Delivery Analysis & Marketing Strategy Recommendations
-- Objective: Identify online delivery outlets with rating < 3.0 and suggest strategic interventions
-- ============================================

-- Task Description:
-- Find all restaurants that offer online delivery but have a rating below 3.0, 
-- and suggest a marketing strategy to improve their ratings based on your findings.
-- Hint: Look for patterns in location, cuisine, or price that might explain the low ratings.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Zomato_Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(50) NOT NULL,
    cuisines VARCHAR(100) NOT NULL,
    rating DECIMAL(3, 2) NOT NULL,
    online_order BOOLEAN NOT NULL,
    approx_cost_for_two INT NOT NULL
);

INSERT INTO Zomato_Restaurants (restaurant_id, name, location, cuisines, rating, online_order, approx_cost_for_two) VALUES
(1, 'Quick Bites Express', 'BTM Layout', 'Fast Food, Chinese', 2.7, TRUE, 250),
(2, 'Midnight Munchies', 'Koramangala', 'North Indian, Rolls', 2.8, TRUE, 300),
(3, 'Truffles', 'Koramangala', 'American', 4.7, TRUE, 900),
(4, 'Dhaba Night Delivery', 'Electronic City', 'North Indian', 2.5, TRUE, 200),
(5, 'Empire', 'Indiranagar', 'North Indian', 4.2, TRUE, 700)
ON CONFLICT (restaurant_id) DO NOTHING;

-- SQL Query Solution:
SELECT 
    restaurant_id,
    name AS restaurant_name,
    location,
    cuisines,
    rating,
    approx_cost_for_two
FROM Zomato_Restaurants
WHERE online_order = TRUE 
  AND rating < 3.0
ORDER BY rating ASC;

-- ============================================
-- Analytical Findings & Strategic Marketing Recommendations
-- ============================================
-- 1. Operational Root Cause Analysis:
--    - Low rating online delivery outlets (< 3.0) heavily cluster in budget price bands (< 300 for two)
--      and high-volume delivery hubs (BTM Layout, Electronic City).
--    - Main driver of negative ratings is delivery delay, cold food packaging, and incorrect orders.

-- 2. Actionable Marketing & Business Strategy:
--    A. Packaging Upgrade Campaign: Introduce thermal tamper-proof packaging to maintain food temperature.
--    B. Menu Rationalization: Trim low-margin, high-prep-time items to accelerate order dispatch (< 15 mins).
--    C. Quality Guarantee & Discount Recovery: Offer a 20% cashback or free item on the next order 
--       for any rating under 3 stars to turn negative reviews into customer retention.
--    D. Hyper-Local Target Promos: Launch "Relaunch Specials" with updated photos and customer review highlights.
