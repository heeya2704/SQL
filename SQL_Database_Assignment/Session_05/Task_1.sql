-- ============================================
-- Session 05
-- Task 01
-- Topic: Data Setup for Filtering
-- Objective: Create 'Restaurants' table and populate with 5+ Zomato sample records
-- ============================================

-- Task:
-- Create a table called Restaurants with columns: id, name, cuisine, rating, and city.
-- Insert at least 5 sample records representing real or fictional restaurants you might find on Zomato.

-- SQL Solution:
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

-- Retrieve setup data:
SELECT * FROM Restaurants;

-- Expected Result:
-- 'Restaurants' table created and populated with 6 records across various cuisines and cities.
