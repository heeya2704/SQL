-- ============================================
-- Session 03
-- Task 01
-- Topic: Table Creation & Initial Row Insertion
-- Objective: Create 'Playlist' table and insert favorite song
-- ============================================

-- Task:
-- Create a table called Playlist with columns: id (INT, primary key), song_name (VARCHAR), artist (VARCHAR), and duration (INT, seconds).
-- Insert a single row for your current favorite song.

-- SQL Solution:
CREATE TABLE IF NOT EXISTS Playlist (
    id INT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    duration INT NOT NULL CHECK (duration > 0)
);

INSERT INTO Playlist (id, song_name, artist, duration) VALUES
(1, 'Kesariya', 'Arjit Singh', 268)
ON CONFLICT (id) DO NOTHING;

-- Verification SELECT:
SELECT * FROM Playlist;

-- Expected Result:
-- Playlist table created and 1 row inserted (id = 1, song_name = 'Kesariya', artist = 'Arjit Singh', duration = 268).
