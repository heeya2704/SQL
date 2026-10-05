-- ============================================
-- Session 13
-- Task 04
-- Topic: Window Functions - DENSE_RANK() with PARTITION BY
-- Objective: Rank each user's playlists by total likes without rank gaps
-- ============================================

-- Task Description:
-- Write a SQL query using DENSE_RANK() and PARTITION BY user_id to rank each user's 
-- playlists by total_likes, showing playlist_name, user_id, total_likes, and dense rank.
-- Hint: Shows how popular each playlist is within each user's account (Spotify-style).

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
    user_id,
    playlist_name,
    total_likes,
    DENSE_RANK() OVER (
        PARTITION BY user_id 
        ORDER BY total_likes DESC
    ) AS user_dense_rank
FROM Playlists
ORDER BY user_id ASC, user_dense_rank ASC;

-- Expected Result:
-- For User 101: 90s Nostalgia (1), Bollywood Party Hits (2), Chill Lo-Fi Beats (3)
-- For User 102: Workout EDM Hype (1), Acoustic Morning Coffee (2)
-- For User 103: Top Punjabi Bangers (1), Indie Pop Discoveries (2), Deep Focus & Study (3)
