-- ============================================
-- Session 13
-- Task 01
-- Topic: Table Creation & Seed Data Setup
-- Objective: Create Playlists table and insert at least 8 sample rows
-- ============================================

-- Task Description:
-- Create a table named Playlists with columns: id, user_id, playlist_name, and total_likes. 
-- Insert at least 8 sample rows with different users and playlists, 
-- making sure some playlists have the same user_id.

-- Table Definition:
CREATE TABLE IF NOT EXISTS Playlists (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    playlist_name VARCHAR(100) NOT NULL,
    total_likes INT NOT NULL CHECK (total_likes >= 0)
);

-- Seed Data (8 Rows):
INSERT INTO Playlists (id, user_id, playlist_name, total_likes) VALUES
(1, 101, 'Bollywood Party Hits', 1540),
(2, 101, 'Chill Lo-Fi Beats', 890),
(3, 101, '90s Nostalgia', 2100),
(4, 102, 'Workout EDM Hype', 1540),  -- Same likes as ID 1 to test ties
(5, 102, 'Acoustic Morning Coffee', 620),
(6, 103, 'Top Punjabi Bangers', 3450),
(7, 103, 'Deep Focus & Study', 1200),
(8, 103, 'Indie Pop Discoveries', 1540) -- Tie with ID 1 & 4
ON CONFLICT (id) DO NOTHING;

-- Verification Query:
SELECT 
    id,
    user_id,
    playlist_name,
    total_likes
FROM Playlists
ORDER BY id ASC;
