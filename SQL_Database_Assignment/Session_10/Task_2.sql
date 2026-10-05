-- ============================================
-- Session 10
-- Task 02
-- Topic: SELF JOIN Queries (Hierarchical Data)
-- Objective: Display playlist alongside its parent playlist name (Spotify nested playlists)
-- ============================================

-- Task:
-- Using a SELF JOIN, write a query on a table called Playlists (id, user_id, playlist_name, parent_playlist_id)
-- to display each playlist alongside its parent playlist name, similar to how Spotify shows nested playlists.
-- Hint: Join Playlists with itself on parent_playlist_id = id.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS Playlists (
    id INT PRIMARY KEY,
    user_id INT NOT NULL,
    playlist_name VARCHAR(100) NOT NULL,
    parent_playlist_id INT REFERENCES Playlists(id)
);

INSERT INTO Playlists (id, user_id, playlist_name, parent_playlist_id) VALUES
(1, 501, 'My Music Vault', NULL),            -- Root Folder
(2, 501, 'Hindi Classics', 1),              -- Sub-folder of 1
(3, 501, '90s Romantic Hits', 2),           -- Nested under 2
(4, 501, 'Workout Beats', NULL)             -- Standalone Root
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT 
    p.id AS playlist_id,
    p.playlist_name,
    parent.playlist_name AS parent_playlist_name
FROM Playlists p
LEFT JOIN Playlists parent ON p.parent_playlist_id = parent.id
ORDER BY p.id ASC;

-- Expected Result:
-- Displays:
-- 1: My Music Vault (parent: NULL)
-- 2: Hindi Classics (parent: My Music Vault)
-- 3: 90s Romantic Hits (parent: Hindi Classics)
-- 4: Workout Beats (parent: NULL)
