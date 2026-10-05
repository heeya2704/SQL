-- ============================================
-- Session 03
-- Task 05
-- Topic: Conditional UPDATE with Compound WHERE Clause
-- Objective: Append '(Remix)' to song_name for AP Dhillon songs with duration > 180s
-- ============================================

-- Task:
-- Write an SQL statement that would update the song_name for all songs by 'AP Dhillon' in your Playlist to add '(Remix)' at the end of the name,
-- but only if the duration is more than 180 seconds.
-- Constraint: Combine UPDATE with WHERE to target only the correct rows.

-- Setup Table & Data:
CREATE TABLE IF NOT EXISTS Playlist (
    id INT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    duration INT NOT NULL CHECK (duration > 0)
);

INSERT INTO Playlist (id, song_name, artist, duration) VALUES
(2, 'Brown Munde', 'AP Dhillon', 241),
(3, 'Excuses', 'AP Dhillon', 175)
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
UPDATE Playlist
SET song_name = song_name || ' (Remix)'
WHERE artist = 'AP Dhillon' AND duration > 180;

-- Verification SELECT:
SELECT id, song_name, artist, duration FROM Playlist WHERE artist = 'AP Dhillon';

-- Expected Result:
-- 'Brown Munde' (241s) is updated to 'Brown Munde (Remix)'.
-- 'Excuses' (175s) remains unchanged because duration <= 180s.
