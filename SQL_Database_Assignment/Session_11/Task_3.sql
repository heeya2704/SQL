-- ============================================
-- Session 11
-- Task 03
-- Topic: Subqueries with IN Clause
-- Objective: List all movies having at least one 5-star review
-- ============================================

-- Task Description:
-- Given a 'Movies' table and a 'Reviews' table, write a SQL query using IN with a subquery 
-- to list all movies that have at least one review with a rating of 5 stars, 
-- as seen in BookMyShow's top-rated section.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    release_year INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT PRIMARY KEY,
    movie_id INT REFERENCES Movies(movie_id),
    reviewer_name VARCHAR(100) NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT
);

INSERT INTO Movies (movie_id, title, genre, release_year) VALUES
(1, 'Interstellar', 'Sci-Fi', 2014),
(2, 'The Dark Knight', 'Action', 2008),
(3, 'Inception', 'Sci-Fi', 2010),
(4, 'The Matrix Resurrections', 'Action', 2021),
(5, 'Oppenheimer', 'Biography', 2023)
ON CONFLICT (movie_id) DO NOTHING;

INSERT INTO Reviews (review_id, movie_id, reviewer_name, rating, comments) VALUES
(101, 1, 'Rahul', 5, 'Absolute masterpiece!'),
(102, 1, 'Sneha', 4, 'Great visuals and score.'),
(103, 2, 'Karan', 5, 'Best superhero movie ever made.'),
(104, 3, 'Amit', 4, 'Confusing but amazing.'),
(105, 4, 'Neha', 2, 'Disappointing sequel.'),
(106, 5, 'Vikram', 5, 'Flawless direction and acting.')
ON CONFLICT (review_id) DO NOTHING;

-- SQL Solution:
SELECT 
    m.movie_id,
    m.title,
    m.genre,
    m.release_year
FROM Movies m
WHERE m.movie_id IN (
    SELECT r.movie_id
    FROM Reviews r
    WHERE r.rating = 5
)
ORDER BY m.title ASC;

-- Expected Result:
-- Returns Interstellar, Oppenheimer, and The Dark Knight (movies having rating = 5).
