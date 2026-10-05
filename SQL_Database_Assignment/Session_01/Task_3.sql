-- ============================================
-- Session 01
-- Task 03
-- Topic: Data Insertion
-- Objective: Insert sample playlist records
-- ============================================

-- Task:
-- Insert three sample rows into the 'playlists' table representing playlists like
-- 'Bollywood Hits', 'Chill Vibes', and 'Workout Mix', each created by a different user.

-- Setup Table structure if running independently:
CREATE TABLE IF NOT EXISTS playlists (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_by VARCHAR(100) NOT NULL
);

-- SQL Solution:
INSERT INTO playlists (playlist_id, name, created_by) VALUES
(1, 'Bollywood Hits', 'Amit'),
(2, 'Chill Vibes', 'Priya'),
(3, 'Workout Mix', 'Rahul');

-- Expected Result:
-- 3 rows inserted successfully into the 'playlists' table.
