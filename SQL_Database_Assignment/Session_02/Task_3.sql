-- ============================================
-- Session 02
-- Task 03
-- Topic: Table Creation with Data Types
-- Objective: Create 'restaurants' table in 'foodie_app'
-- ============================================

-- Task:
-- Write a CREATE TABLE statement to define a 'restaurants' table in the 'foodie_app' database with the following columns:
-- id (integer, primary key), name (varchar, max 100), cuisine (varchar, max 50), rating (decimal, e.g. 4.5), location (varchar, max 100).

-- SQL Solution:
CREATE TABLE IF NOT EXISTS restaurants (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    rating NUMERIC(3, 1) CHECK (rating >= 0.0 AND rating <= 5.0),
    location VARCHAR(100) NOT NULL
);

-- Expected Result:
-- 'restaurants' table created with appropriate column types and numeric constraint for rating.
