-- ============================================
-- Session 17
-- Task 04
-- Topic: Multi-Table JOIN Aggregation
-- Objective: Calculate average review rating per restaurant ordered descending
-- ============================================

-- Task Description:
-- Write a SQL query using a JOIN to display each restaurant's name, cuisine, 
-- and its average review rating (from the Review table), ordered by highest average rating first.
-- Hint: Use JOIN and GROUP BY with aggregate functions.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    average_rating DECIMAL(3, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Review (
    id INT PRIMARY KEY,
    restaurant_id INT REFERENCES Restaurant(id),
    user_name VARCHAR(100) NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_date DATE NOT NULL
);

INSERT INTO Restaurant (id, name, cuisine, location, average_rating) VALUES
(1, 'Truffles', 'American', 'Koramangala', 4.6),
(2, 'Empire Restaurant', 'North Indian', 'Indiranagar', 4.1),
(3, 'Meghana Foods', 'Biryani', 'Jayanagar', 4.5),
(4, 'Corner House', 'Desserts', 'Koramangala', 4.7),
(5, 'Glen''s Bakehouse', 'Desserts', 'Indiranagar', 4.4)
ON CONFLICT (id) DO NOTHING;

INSERT INTO Review (id, restaurant_id, user_name, rating, review_date) VALUES
(101, 1, 'Rahul', 5, '2024-02-01'),
(102, 1, 'Sneha', 4, '2024-02-05'),
(103, 1, 'Amit', 5, '2024-02-10'),
(104, 2, 'Karan', 4, '2024-02-03'),
(105, 2, 'Neha', 3, '2024-02-08'),
(106, 3, 'Vikram', 5, '2024-02-12'),
(107, 3, 'Pooja', 4, '2024-02-15'),
(108, 4, 'Deepak', 5, '2024-02-18'),
(109, 4, 'Ritu', 5, '2024-02-20'),
(110, 5, 'Sanjay', 4, '2024-02-22')
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT 
    r.id AS restaurant_id,
    r.name AS restaurant_name,
    r.cuisine,
    COUNT(rev.id) AS total_reviews_received,
    ROUND(AVG(rev.rating), 2) AS calculated_avg_review_rating
FROM Restaurant r
INNER JOIN Review rev ON r.id = rev.restaurant_id
GROUP BY r.id, r.name, r.cuisine
ORDER BY calculated_avg_review_rating DESC, total_reviews_received DESC;

-- Expected Result:
-- 1. Corner House (5.00 avg, 2 reviews)
-- 2. Truffles (4.67 avg, 3 reviews)
-- 3. Meghana Foods (4.50 avg, 2 reviews)
-- 4. Glen's Bakehouse (4.00 avg, 1 review)
-- 5. Empire Restaurant (3.50 avg, 2 reviews)
