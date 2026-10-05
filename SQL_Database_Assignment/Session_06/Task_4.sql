-- ============================================
-- Session 06
-- Task 04
-- Topic: Alphabetical Sorting & Pagination
-- Objective: Display first 10 restaurants sorted alphabetically (Zomato A-Z listing)
-- ============================================

-- Task:
-- Write an SQL query to display the first 10 restaurants from a 'restaurants' table, sorted alphabetically by name,
-- just like Zomato's A-Z listing.
-- Hint: Use ORDER BY with LIMIT.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);

INSERT INTO restaurants (id, name, cuisine, city) VALUES
(1, 'Swagat Restaurant', 'South Indian', 'Ahmedabad'),
(2, 'Barbeque Nation', 'Buffet', 'Surat'),
(3, 'Absolute Barbecues', 'Buffet', 'Ahmedabad'),
(4, 'Dominos Pizza', 'Fast Food', 'Mumbai'),
(5, 'Chai Point', 'Beverages', 'Bangalore'),
(6, 'Haldirams', 'North Indian', 'Delhi'),
(7, 'Bikanervala', 'Sweets', 'Delhi'),
(8, 'KFC', 'Fast Food', 'Pune'),
(9, 'McDonalds', 'Fast Food', 'Chennai'),
(10, 'Subway', 'Healthy', 'Kolkata'),
(11, 'Zaffran', 'Mughlai', 'Hyderabad')
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT id, name, cuisine, city
FROM restaurants
ORDER BY name ASC
LIMIT 10;

-- Expected Result:
-- Displays top 10 restaurants alphabetically starting from 'Absolute Barbecues' to 'Subway'.
