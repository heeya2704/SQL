-- ============================================
-- Session 18
-- Task 01
-- Topic: Group Aggregations & HAVING Filtering
-- Objective: Find artists who have uploaded more than 3 songs
-- ============================================

-- Task Description:
-- Write an SQL query to display the total number of songs uploaded by each artist 
-- from a table 'songs' (columns: song_id, artist_name, title) and show only those 
-- artists who have uploaded more than 3 songs.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS songs (
    song_id INT PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL,
    title VARCHAR(150) NOT NULL
);

INSERT INTO songs (song_id, artist_name, title) VALUES
(1, 'Arijit Singh', 'Tum Hi Ho'),
(2, 'Arijit Singh', 'Channa Mereya'),
(3, 'Arijit Singh', 'Kesariya'),
(4, 'Arijit Singh', 'Apna Bana Le'),
(5, 'Arijit Singh', 'Agar Tum Saath Ho'), -- 5 songs for Arijit Singh
(6, 'Taylor Swift', 'Blank Space'),
(7, 'Taylor Swift', 'Anti-Hero'),
(8, 'Taylor Swift', 'Cruel Summer'),
(9, 'Taylor Swift', 'Shake It Off'), -- 4 songs for Taylor Swift
(10, 'ED Sheeran', 'Shape of You'),
(11, 'ED Sheeran', 'Perfect') -- 2 songs for ED Sheeran (filtered out by HAVING > 3)
ON CONFLICT (song_id) DO NOTHING;

-- SQL Solution:
SELECT 
    artist_name,
    COUNT(song_id) AS total_songs_uploaded
FROM songs
GROUP BY artist_name
HAVING COUNT(song_id) > 3
ORDER BY total_songs_uploaded DESC;

-- Expected Result:
-- Arijit Singh (5 songs)
-- Taylor Swift (4 songs)
