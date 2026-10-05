-- ============================================
-- Session 17
-- Task 03
-- Topic: Relational Table Linkage (Foreign Key)
-- Objective: Create Review table and populate 10 linked sample reviews
-- ============================================

-- Task Description:
-- Add a new table called Review with columns: id, restaurant_id, user_name, 
-- rating, and review_date. Insert at least 10 sample reviews, linking them to restaurants using restaurant_id.

-- Table Definitions:
CREATE TABLE IF NOT EXISTS Restaurant (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL,
    average_rating DECIMAL(3, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Review (
    id INT PRIMARY KEY,
    restaurant_id INT REFERENCES Restaurant(id) ON DELETE CASCADE,
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

-- Seed Data (10 Linked Reviews):
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

-- Verification Query:
SELECT * FROM Review ORDER BY id ASC;
