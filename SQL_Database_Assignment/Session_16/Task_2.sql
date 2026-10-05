-- ============================================
-- Session 16
-- Task 02
-- Topic: Spotify Streaming Data Table Setup
-- Objective: Create TopSongs table and insert 5 popular Spotify tracks
-- ============================================

-- Task Description:
-- Write SQL statements to create a table called TopSongs with columns: song_id, 
-- song_title, artist, streams, and release_date, then insert at least 5 records 
-- representing popular tracks from Spotify.

-- Table Definition:
CREATE TABLE IF NOT EXISTS TopSongs (
    song_id INT PRIMARY KEY,
    song_title VARCHAR(150) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    streams BIGINT NOT NULL CHECK (streams >= 0),
    release_date DATE NOT NULL
);

-- Seed Data (5 Popular Spotify Tracks):
INSERT INTO TopSongs (song_id, song_title, artist, streams, release_date) VALUES
(1, 'Blinding Lights', 'The Weeknd', 4100000000, '2019-11-29'),
(2, 'Shape of You', 'Ed Sheeran', 3800000000, '2017-01-06'),
(3, 'Starboy', 'The Weeknd ft. Daft Punk', 3200000000, '2016-09-22'),
(4, 'As It Was', 'Harry Styles', 3100000000, '2022-04-01'),
(5, 'Flowers', 'Miley Cyrus', 2200000000, '2023-01-13')
ON CONFLICT (song_id) DO NOTHING;

-- Verification Query:
SELECT 
    song_id,
    song_title,
    artist,
    streams,
    release_date
FROM TopSongs
ORDER BY streams DESC;
