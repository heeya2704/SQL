-- ============================================
-- Session 13
-- Task 03
-- Topic: Window Functions - RANK()
-- Objective: Rank all playlists globally by total likes handling ties with rank gaps
-- ============================================

-- Task Description:
-- Use the RANK() function with the OVER() clause to rank all playlists by total_likes, 
-- and display the playlist_name, user_id, total_likes, and their rank.

-- Setup Table & Seed Data:
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
    playlist_name,
    user_id,
    total_likes,
    RANK() OVER (ORDER BY total_likes DESC) AS global_rank
FROM Playlists
ORDER BY global_rank ASC, playlist_name ASC;

-- Expected Result:
-- Top Punjabi Bangers (3450) -> Rank 1
-- 90s Nostalgia (2100) -> Rank 2
-- Bollywood Party Hits, Workout EDM Hype, Indie Pop Discoveries (1540) -> Tied for Rank 3
-- Deep Focus & Study (1200) -> Rank 6 (Skips 4 & 5 due to 3-way tie)
