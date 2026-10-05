-- ============================================
-- Session 03
-- Task 03
-- Topic: Data Manipulation - UPDATE Statement
-- Objective: Fix spelling typo in artist name using UPDATE and WHERE
-- ============================================

-- Task:
-- Update the artist name for one of your Playlist entries to fix a typo (for example, change 'Arjit Singh' to 'Arijit Singh')
-- using the UPDATE statement with a WHERE clause.

-- Setup Table & Initial Data:
CREATE TABLE IF NOT EXISTS Playlist (
    id INT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    duration INT NOT NULL CHECK (duration > 0)
);

INSERT INTO Playlist (id, song_name, artist, duration) VALUES
(1, 'Kesariya', 'Arjit Singh', 268)
ON CONFLICT (id) DO UPDATE SET artist = 'Arjit Singh';

-- SQL Solution:
UPDATE Playlist
SET artist = 'Arijit Singh'
WHERE artist = 'Arjit Singh' AND id = 1;

-- Verification SELECT:
SELECT * FROM Playlist WHERE id = 1;

-- Expected Result:
-- Row with id = 1 updated artist from 'Arjit Singh' to 'Arijit Singh'.
