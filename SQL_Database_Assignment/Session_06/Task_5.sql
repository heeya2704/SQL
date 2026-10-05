-- ============================================
-- Session 06
-- Task 05
-- Topic: Multi-Criteria Tie-Breaking Sort
-- Objective: Retrieve top 3 trending songs by play_count DESC, breaking ties with added_date DESC
-- ============================================

-- Task:
-- Suppose you want to display the top 3 trending songs from a 'songs' table based on play_count,
-- but if two songs have the same play_count, the more recently added song should come first.
-- Write the SQL query to achieve this.
-- Hint: Use ORDER BY with multiple columns.

-- Setup Table & Seed Data:
CREATE TABLE IF NOT EXISTS songs (
    song_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    play_count INT NOT NULL DEFAULT 0,
    added_date DATE NOT NULL
);

INSERT INTO songs (song_id, title, artist, play_count, added_date) VALUES
(1, 'Song A', 'Artist 1', 15000, '2024-01-10'),
(2, 'Song B', 'Artist 2', 25000, '2024-02-01'),
(3, 'Song C', 'Artist 3', 25000, '2024-03-15'),  -- Same play_count as Song B, but newer added_date!
(4, 'Song D', 'Artist 4', 30000, '2024-01-05'),
(5, 'Song E', 'Artist 5', 12000, '2024-03-01')
ON CONFLICT (song_id) DO NOTHING;

-- SQL Solution:
SELECT song_id, title, artist, play_count, added_date
FROM songs
ORDER BY play_count DESC, added_date DESC
LIMIT 3;

-- Expected Result:
-- 1st: Song D (30000, 2024-01-05)
-- 2nd: Song C (25000, 2024-03-15) -> Chosen over Song B due to newer added_date
-- 3rd: Song B (25000, 2024-02-01)
