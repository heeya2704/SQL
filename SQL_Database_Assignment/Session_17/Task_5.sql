-- ============================================
-- Session 17
-- Task 05
-- Topic: Partitioned Ranking Window Functions
-- Objective: Rank restaurants by average review rating within each cuisine type
-- ============================================

-- Task Description:
-- Use a window function to rank restaurants by their average review rating 
-- within each cuisine type, showing the restaurant name, cuisine, average rating, and rank.
-- Hint: Use the RANK() or DENSE_RANK() window function partitioned by cuisine.

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

-- SQL Solution (CTE + DENSE_RANK() PARTITION BY cuisine):
WITH RestaurantCalculatedRatings AS (
    SELECT 
        r.id AS restaurant_id,
        r.name AS restaurant_name,
        r.cuisine,
        ROUND(AVG(rev.rating), 2) AS avg_review_rating
    FROM Restaurant r
    INNER JOIN Review rev ON r.id = rev.restaurant_id
    GROUP BY r.id, r.name, r.cuisine
)
SELECT 
    restaurant_name,
    cuisine,
    avg_review_rating,
    DENSE_RANK() OVER (
        PARTITION BY cuisine 
        ORDER BY avg_review_rating DESC
    ) AS rank_in_cuisine
FROM RestaurantCalculatedRatings
ORDER BY cuisine ASC, rank_in_cuisine ASC;

-- Expected Result:
-- American: Truffles (4.67) -> Rank 1
-- Biryani: Meghana Foods (4.50) -> Rank 1
-- Desserts: Corner House (5.00) -> Rank 1, Glen's Bakehouse (4.00) -> Rank 2
-- North Indian: Empire Restaurant (3.50) -> Rank 1
