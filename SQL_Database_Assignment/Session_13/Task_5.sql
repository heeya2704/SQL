-- ============================================
-- Session 13
-- Task 05
-- Topic: Top-N Per Group Filtering with Window Functions
-- Objective: Select the top 2 playlists per user based on total likes
-- ============================================

-- Task Description:
-- Imagine you want to show the top 2 playlists per user based on total_likes, 
-- like Spotify's 'Your Top Playlists' feature. Write a query using a window function 
-- to select only the top 2 playlists for each user.

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

-- SQL Solution (CTE + ROW_NUMBER / DENSE_RANK):
WITH RankedPlaylists AS (
    SELECT 
        id,
        user_id,
        playlist_name,
        total_likes,
        ROW_NUMBER() OVER (
            PARTITION BY user_id 
            ORDER BY total_likes DESC, id ASC
        ) AS top_rank
    FROM Playlists
)
SELECT 
    user_id,
    playlist_name,
    total_likes,
    top_rank AS user_playlist_rank
FROM RankedPlaylists
WHERE top_rank <= 2
ORDER BY user_id ASC, top_rank ASC;

-- Expected Result:
-- User 101: 90s Nostalgia (Rank 1), Bollywood Party Hits (Rank 2)
-- User 102: Workout EDM Hype (Rank 1), Acoustic Morning Coffee (Rank 2)
-- User 103: Top Punjabi Bangers (Rank 1), Indie Pop Discoveries (Rank 2)
