-- ============================================
-- Session 03
-- Task 04
-- Topic: Data Manipulation - DELETE Statement
-- Objective: Delete song with duration less than 120 seconds safely
-- ============================================

-- Task:
-- Delete a song from the Playlist table where the duration is less than 120 seconds using the DELETE statement and a WHERE clause.
-- Hint: Make sure your WHERE clause is specific so you don't accidentally delete all rows.

-- Setup Table & Data:
CREATE TABLE IF NOT EXISTS Playlist (
    id INT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    duration INT NOT NULL CHECK (duration > 0)
);

INSERT INTO Playlist (id, song_name, artist, duration) VALUES
(4, 'Short Intro Track', 'Unknown Artist', 95)
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
DELETE FROM Playlist
WHERE duration < 120;

-- Verification SELECT:
SELECT * FROM Playlist WHERE duration < 120;

-- Expected Result:
-- Songs with duration < 120 seconds (e.g., id = 4, 95 seconds) are deleted. Query returns 0 rows.
