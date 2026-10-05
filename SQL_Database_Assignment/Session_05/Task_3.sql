-- ============================================
-- Session 05
-- Task 03
-- Topic: Pattern Matching with LIKE Operator
-- Objective: Query restaurants whose names start with 'Swa'
-- ============================================

-- Task:
-- Using the LIKE operator, write a query to select all restaurants whose names start with 'Swa'
-- (for example, 'Swagat', 'Swadisht') from the Restaurants table.
-- Hint: Use LIKE 'Swa%'.

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
(3, 'China Town', 'Chinese', 3.8, 'Ahmedabad')
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT id, name, cuisine, rating, city
FROM Restaurants
WHERE name LIKE 'Swa%';

-- Expected Result:
-- Displays 'Swagat Restaurant' and 'Swadisht Thali'.
