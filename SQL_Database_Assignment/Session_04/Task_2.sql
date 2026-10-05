-- ============================================
-- Session 04
-- Task 02
-- Topic: Projection & Row Limiting (LIMIT)
-- Objective: Display song_name and artist for first 3 records
-- ============================================

-- Task:
-- Write a SQL query to display only the song_name and artist columns from the MusicPlaylist table,
-- showing just the first 3 records using the LIMIT keyword.

-- Setup Table & Seed Data:
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

-- SQL Solution:
SELECT song_name, artist
FROM MusicPlaylist
ORDER BY id ASC
LIMIT 3;

-- Expected Result:
-- Displays top 3 songs ('Starboy', 'Blinding Lights', 'Levitating') with song_name and artist columns.
