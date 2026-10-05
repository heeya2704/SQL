-- ============================================
-- Session 06
-- Task 03
-- Topic: Multi-Column Sorting
-- Objective: Sort movies first by release_year DESC, then by rating DESC
-- ============================================

-- Task:
-- Given a 'movies' table with columns 'title', 'release_year', and 'rating', write an SQL query to list all movies
-- sorted first by release_year in descending order (latest first), then by rating in descending order (highest rated first).

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT NOT NULL,
    rating NUMERIC(3, 1) CHECK (rating >= 0.0 AND rating <= 10.0)
);

INSERT INTO movies (movie_id, title, release_year, rating) VALUES
(1, 'Oppenheimer', 2023, 8.9),
(2, 'Barbie', 2023, 7.3),
(3, 'Dune: Part Two', 2024, 8.6),
(4, 'Godzilla x Kong', 2024, 6.5),
(5, 'Interstellar', 2014, 8.7),
(6, 'Inception', 2010, 8.8)
ON CONFLICT (movie_id) DO NOTHING;

-- SQL Solution:
SELECT title, release_year, rating
FROM movies
ORDER BY release_year DESC, rating DESC;

-- Expected Result:
-- Displays 2024 movies first ('Dune: Part Two' (8.6) then 'Godzilla x Kong' (6.5)), followed by 2023 movies, etc.
