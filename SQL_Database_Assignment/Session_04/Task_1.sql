-- ============================================
-- Session 04
-- Task 01
-- Topic: SELECT All Columns
-- Objective: Create 'MusicPlaylist' table, insert 5 records, and SELECT *
-- ============================================

-- Task:
-- Create a table named MusicPlaylist with columns: id, song_name, artist, genre, and duration.
-- Insert at least 5 records representing songs from your favorite Spotify playlist, then write a SELECT statement to retrieve all columns for all songs.

-- SQL Solution:
CREATE TABLE IF NOT EXISTS MusicPlaylist (
    id INT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    duration INT NOT NULL
);

INSERT INTO MusicPlaylist (id, song_name, artist, genre, duration) VALUES
(1, 'Starboy', 'The Weeknd', 'Pop', 230),
(2, 'Blinding Lights', 'The Weeknd', 'Synthwave', 200),
(3, 'Levitating', 'Dua Lipa', 'Pop', 203),
(4, 'Shape of You', 'Ed Sheeran', 'Pop', 233),
(5, 'Stay', 'Kid LAROI & Justin Bieber', 'Pop', 141)
ON CONFLICT (id) DO NOTHING;

-- Retrieve all columns for all songs:
SELECT id, song_name, artist, genre, duration
FROM MusicPlaylist;

-- Expected Result:
-- Displays all 5 rows and 5 columns from MusicPlaylist.
