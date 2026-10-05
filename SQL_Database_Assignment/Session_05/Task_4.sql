-- ============================================
-- Session 05
-- Task 04
-- Topic: Range Filtering with BETWEEN Operator
-- Objective: Find restaurants with rating between 3.5 and 4.5 inclusive
-- ============================================

-- Task:
-- Write a SQL query using the BETWEEN keyword to find all restaurants in the Restaurants table
-- with a rating between 3.5 and 4.5 (inclusive).

-- Setup Table & Data:
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
(6, 'Dosa Corner', 'South Indian', 3.6, 'Rajkot')
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE rating BETWEEN 3.5 AND 4.5
ORDER BY rating DESC;

-- Expected Result:
-- Displays restaurants with rating 4.5, 4.2, 3.8, and 3.6 (excluding 4.6).
