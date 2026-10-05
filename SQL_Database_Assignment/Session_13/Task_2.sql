-- ============================================
-- Session 13
-- Task 02
-- Topic: Window Functions - ROW_NUMBER()
-- Objective: Assign unique row numbers to playlists ordered by total likes
-- ============================================

-- Task Description:
-- Write a SQL query using ROW_NUMBER() and the OVER() clause to assign a unique 
-- row number to each playlist, ordered by total_likes in descending order.

-- Setup Table & Seed Data (Independent Execution):
CREATE TABLE IF NOT EXISTS Playlists (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    playlist_name VARCHAR(100) NOT NULL,
    total_likes INT NOT NULL
);

INSERT INTO Playlists (id, user_id, playlist_name, total_likes) VALUES
(1, 101, 'Bollywood Party Hits', 1540),
(2, 101, 'Chill Lo-Fi Beats', 890),
(3, 101, '90s Nostalgia', 2100),
(4, 102, 'Workout EDM Hype', 1540),
(5, 102, 'Acoustic Morning Coffee', 620),
(6, 103, 'Top Punjabi Bangers', 3450),
(7, 103, 'Deep Focus & Study', 1200),
(8, 103, 'Indie Pop Discoveries', 1540)
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT 
    ROW_NUMBER() OVER (ORDER BY total_likes DESC, id ASC) AS row_num,
    id AS playlist_id,
    playlist_name,
    user_id,
    total_likes
FROM Playlists
ORDER BY row_num ASC;

-- Expected Result:
-- Every playlist receives a unique sequential row number (1 to 8), 
-- even when total_likes are identical.
