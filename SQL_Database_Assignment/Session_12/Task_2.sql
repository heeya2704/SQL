-- ============================================
-- Session 12
-- Task 02
-- Topic: CTE vs Subquery Readability Comparison
-- Objective: Filter Ahmedabad restaurants with low delivery charges using both subquery and CTE
-- ============================================

-- Task Description:
-- Rewrite a query that finds all restaurants in 'Ahmedabad' with delivery charges under 50 
-- from a 'Restaurants' table, first using a subquery and then using a CTE. 
-- Compare both queries for readability.
-- Hint: Focus on making the CTE version cleaner and easier to understand.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    delivery_charge DECIMAL(6, 2) NOT NULL,
    rating DECIMAL(3, 2) NOT NULL
);

INSERT INTO Restaurants (restaurant_id, name, city, delivery_charge, rating) VALUES
(1, 'Agashiye', 'Ahmedabad', 40.00, 4.8),
(2, 'Manek Chowk Eatery', 'Ahmedabad', 30.00, 4.2),
(3, 'Gordhan Thal', 'Ahmedabad', 60.00, 4.4),
(4, 'Havmor Restaurant', 'Ahmedabad', 45.00, 4.5),
(5, 'Truffles', 'Bengaluru', 35.00, 4.6)
ON CONFLICT (restaurant_id) DO NOTHING;

-- --------------------------------------------
-- Approach 1: Subquery Approach
-- --------------------------------------------
SELECT 
    sub.restaurant_id,
    sub.name AS restaurant_name,
    sub.city,
    sub.delivery_charge,
    sub.rating
FROM (
    SELECT restaurant_id, name, city, delivery_charge, rating
    FROM Restaurants
    WHERE city = 'Ahmedabad'
) AS sub
WHERE sub.delivery_charge < 50.00;

-- --------------------------------------------
-- Approach 2: CTE Approach (Clean & Readable)
-- --------------------------------------------
WITH AhmedabadRestaurants AS (
    SELECT 
        restaurant_id,
        name AS restaurant_name,
        city,
        delivery_charge,
        rating
    FROM Restaurants
    WHERE city = 'Ahmedabad'
)
SELECT 
    restaurant_id,
    restaurant_name,
    city,
    delivery_charge,
    rating
FROM AhmedabadRestaurants
WHERE delivery_charge < 50.00
ORDER BY delivery_charge ASC;

-- Comparison & Analysis:
-- The CTE version decouples the filtering logic into named logical blocks,
-- eliminating deeply nested parentheses and making the main SELECT statement simple and intuitive to read.
