-- ============================================
-- Session 19
-- Task 04
-- Topic: Market Segmentation Analysis
-- Objective: Segment restaurants into Budget, Mid-Range, and Premium categories
-- ============================================

-- Task Description:
-- Write an SQL query to segment restaurants into three market segments based on 
-- average cost for two: budget (below 400), mid-range (400-800), and premium (above 800). 
-- Count how many restaurants fall into each segment.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Zomato_Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(50) NOT NULL,
    approx_cost_for_two INT NOT NULL
);

INSERT INTO Zomato_Restaurants (restaurant_id, name, location, approx_cost_for_two) VALUES
(1, 'Street Food Stall', 'BTM', 150),
(2, 'Tea Point', 'HSR', 200),
(3, 'Fast Food Corner', 'Jayanagar', 350),  -- 3 Budget (< 400)
(4, 'Empire Restaurant', 'Indiranagar', 600),
(5, 'Kapoor''s Cafe', 'Koramangala', 500),
(6, 'Truffles', 'Koramangala', 800),        -- 3 Mid-Range (400 - 800)
(7, 'Punjab Grill', 'Koramangala', 1200),
(8, 'Le Cirque Signature', 'Leela Palace', 4500) -- 2 Premium (> 800)
ON CONFLICT (restaurant_id) DO NOTHING;

-- SQL Solution:
WITH SegmentedRestaurants AS (
    SELECT 
        restaurant_id,
        name,
        approx_cost_for_two,
        CASE 
            WHEN approx_cost_for_two < 400 THEN 'Budget (< 400)'
            WHEN approx_cost_for_two BETWEEN 400 AND 800 THEN 'Mid-Range (400-800)'
            WHEN approx_cost_for_two > 800 THEN 'Premium (> 800)'
        END AS market_segment
    FROM Zomato_Restaurants
)
SELECT 
    market_segment,
    COUNT(restaurant_id) AS total_restaurants,
    ROUND(AVG(approx_cost_for_two), 2) AS segment_avg_cost
FROM SegmentedRestaurants
GROUP BY market_segment
ORDER BY segment_avg_cost ASC;

-- Expected Result:
-- Budget (< 400): 3 restaurants
-- Mid-Range (400-800): 3 restaurants
-- Premium (> 800): 2 restaurants
