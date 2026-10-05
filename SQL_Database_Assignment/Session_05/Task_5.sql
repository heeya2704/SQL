-- ============================================
-- Session 05
-- Task 05
-- Topic: List Filtering with IN Operator
-- Objective: Filter restaurants by multiple cuisines (Chinese, Italian, South Indian)
-- ============================================

-- Task:
-- Write a query to find all restaurants whose cuisine is either 'Chinese', 'Italian', or 'South Indian' using the IN operator.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating NUMERIC(3, 1) CHECK (rating >= 0.0 AND rating <= 5.0),
    city VARCHAR(50) NOT NULL
);

INSERT INTO Restaurants (id, name, cuisine, rating, city) VALUES
(1, 'Swagat Restaurant', 'South Indian', 4.5, 'Ahmedabad'),
(2, 'Swadisht Thali', 'Gujarati', 4.2, 'Surat'),
(3, 'China Town', 'Chinese', 3.8, 'Ahmedabad'),
(4, 'Little Italy', 'Italian', 4.6, 'Vadodara'),
(5, 'Saffron Spice', 'North Indian', 4.1, 'Surat'),
(6, 'Dosa Corner', 'South Indian', 3.6, 'Rajkot')
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE cuisine IN ('Chinese', 'Italian', 'South Indian')
ORDER BY cuisine ASC, name ASC;

-- Expected Result:
-- Displays restaurants serving 'Chinese', 'Italian', or 'South Indian' (excluding 'Gujarati' and 'North Indian').
