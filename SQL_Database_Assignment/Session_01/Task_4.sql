-- ============================================
-- Session 01
-- Task 04
-- Topic: Basic SELECT & Filtering
-- Objective: Query playlists created by a specific user ('Amit')
-- ============================================

-- Task:
-- Write an SQL SELECT query to display all playlists created by the user 'Amit' from the 'playlists' table.
-- Hint: Use the WHERE clause to filter by the 'created_by' column.

-- Setup Table structure & Data if running independently:
CREATE TABLE IF NOT EXISTS playlists (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_by VARCHAR(100) NOT NULL
);

INSERT INTO playlists (playlist_id, name, created_by) VALUES
(1, 'Bollywood Hits', 'Amit'),
(2, 'Chill Vibes', 'Priya'),
(3, 'Workout Mix', 'Rahul')
ON CONFLICT (playlist_id) DO NOTHING;

-- SQL Solution:
SELECT playlist_id, name, created_by
FROM playlists
WHERE created_by = 'Amit';

-- Expected Result:
-- Displays playlist_id = 1, name = 'Bollywood Hits', created_by = 'Amit'.
