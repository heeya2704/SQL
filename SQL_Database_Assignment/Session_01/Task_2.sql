-- ============================================
-- Session 01
-- Task 02
-- Topic: Table Creation
-- Objective: Create the 'playlists' table inside 'music_streaming_app'
-- ============================================

-- Task:
-- Inside the 'music_streaming_app' database, create a table called 'playlists' with columns:
-- playlist_id (integer, primary key), name (varchar), and created_by (varchar).

-- SQL Solution:
CREATE TABLE IF NOT EXISTS playlists (
    playlist_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_by VARCHAR(100) NOT NULL
);

-- Expected Result:
-- The 'playlists' table is defined with playlist_id as primary key and name/created_by as string attributes.
