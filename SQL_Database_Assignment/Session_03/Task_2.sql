-- ============================================
-- Session 03
-- Task 02
-- Topic: Multi-Row Data Insertion
-- Objective: Insert 3 additional Spotify songs into Playlist
-- ============================================

-- Task:
-- Insert 3 new rows into the Playlist table for songs you recently listened to on Spotify, including their song_name, artist, and duration.

-- Setup Table structure & Initial row if running independently:
CREATE TABLE IF NOT EXISTS Playlist (
    id INT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    duration INT NOT NULL CHECK (duration > 0)
);

INSERT INTO Playlist (id, song_name, artist, duration) VALUES
(1, 'Kesariya', 'Arjit Singh', 268)
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
INSERT INTO Playlist (id, song_name, artist, duration) VALUES
(2, 'Brown Munde', 'AP Dhillon', 241),
(3, 'Excuses', 'AP Dhillon', 175),
(4, 'Short Intro Track', 'Unknown Artist', 95)
ON CONFLICT (id) DO NOTHING;

-- Verification SELECT:
SELECT * FROM Playlist;

-- Expected Result:
-- Total 4 rows now present in the Playlist table.
