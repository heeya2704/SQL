-- ============================================
-- Session 05
-- Task 02
-- Topic: Compound Filtering (AND + OR)
-- Objective: Find restaurants with rating > 4.0 in Ahmedabad or Surat
-- ============================================

-- Task:
-- Write a SQL query to find all restaurants in the Restaurants table that have a rating greater than 4.0
-- and are located in either 'Ahmedabad' or 'Surat'.

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
(5, 'Saffron Spice', 'North Indian', 4.1, 'Surat')
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE rating > 4.0 
  AND city IN ('Ahmedabad', 'Surat');

-- Expected Result:
-- Displays 'Swagat Restaurant' (4.5, Ahmedabad), 'Swadisht Thali' (4.2, Surat), and 'Saffron Spice' (4.1, Surat).
