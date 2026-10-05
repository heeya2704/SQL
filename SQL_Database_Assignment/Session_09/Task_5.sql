-- ============================================
-- Session 09
-- Task 05
-- Topic: Join Type Decision & Scenario Application
-- Objective: Select appropriate JOIN for Spotify playlists & songs requirement
-- ============================================

-- Task:
-- Given this scenario: You want to show a list of all playlists and the songs inside them, like Spotify.
-- Explain which JOIN type (INNER, LEFT, or RIGHT) you would use to show all playlists, even if some are empty, and write the SQL query for it.

/*
================================================================================
JOIN SELECTION EXPLANATION:
--------------------------------------------------------------------------------
To display ALL playlists regardless of whether they contain songs or are completely empty,
we must use a **LEFT OUTER JOIN** (with `playlists` as the left table).

- An INNER JOIN would exclude empty playlists because there are no matching rows in the `playlist_songs` junction table.
- A RIGHT JOIN would prioritize songs, potentially omitting playlists that have 0 songs.
- A LEFT JOIN preserves every single playlist entry from the left table, populating song fields with NULL if empty.
================================================================================
*/

-- Setup Schema & Data:
CREATE TABLE IF NOT EXISTS playlists (
    playlist_id INT PRIMARY KEY,
    playlist_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS songs (
    song_id INT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS playlist_songs (
    playlist_id INT REFERENCES playlists(playlist_id),
    song_id INT REFERENCES songs(song_id),
    PRIMARY KEY (playlist_id, song_id)
);

INSERT INTO playlists (playlist_id, playlist_name) VALUES
(1, 'Workout Hits'),
(2, 'Study Beats'),
(3, 'Empty Chill List') -- Empty Playlist!
ON CONFLICT (playlist_id) DO NOTHING;

INSERT INTO songs (song_id, song_name, artist) VALUES
(10, 'Eye of the Tiger', 'Survivor'),
(20, 'Lofi Rain', 'ChilledCow')
ON CONFLICT (song_id) DO NOTHING;

INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(1, 10),
(2, 20)
ON CONFLICT DO NOTHING;

-- SQL Solution:
SELECT 
    p.playlist_id,
    p.playlist_name,
    s.song_id,
    s.song_name,
    s.artist
FROM playlists p
LEFT JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
LEFT JOIN songs s ON ps.song_id = s.song_id
ORDER BY p.playlist_name ASC;

-- Expected Result:
-- Outputs all playlists including 'Empty Chill List' (with NULL for song_id, song_name, artist).
