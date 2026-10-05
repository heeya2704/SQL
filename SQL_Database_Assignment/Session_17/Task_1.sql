-- ============================================
-- Session 17
-- Task 01
-- Topic: Table Creation & Seed Setup
-- Objective: Create Restaurant table with columns (id, name, cuisine, location, average_rating)
-- ============================================

-- Task Description:
-- Create a SQL table called Restaurant with columns: id, name, cuisine, location, 
-- and average_rating. Insert at least 5 sample rows representing popular restaurants from Zomato.

-- Table Definition:
CREATE TABLE IF NOT EXISTS Restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    average_rating DECIMAL(3, 2) NOT NULL CHECK (average_rating BETWEEN 0.0 AND 5.0)
);

-- Seed Data (5 Popular Zomato Restaurants):
INSERT INTO Restaurant (id, name, cuisine, location, average_rating) VALUES
(1, 'Truffles', 'American', 'Koramangala', 4.6),
(2, 'Empire Restaurant', 'North Indian', 'Indiranagar', 4.1),
(3, 'Meghana Foods', 'Biryani', 'Jayanagar', 4.5),
(4, 'Corner House', 'Desserts', 'Koramangala', 4.7),
(5, 'Glen''s Bakehouse', 'Desserts', 'Indiranagar', 4.4)
ON CONFLICT (id) DO NOTHING;

-- Verification Query:
SELECT * FROM Restaurant ORDER BY id ASC;
