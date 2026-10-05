-- ============================================
-- Session 12
-- Task 03
-- Topic: Multiple CTEs in a Single Query
-- Objective: Retrieve Top 3 most-followed users and Top 3 most-liked posts in a unified result
-- ============================================

-- Task Description:
-- Using two CTEs in a single query, find the top 3 most-followed users and the top 3 
-- most-liked posts from a 'Users' and 'Posts' table (Instagram-style data). 
-- Output both lists in the same result set.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    followers_count INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Posts (
    post_id INT PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    caption TEXT NOT NULL,
    likes_count INT NOT NULL
);

INSERT INTO Users (user_id, username, followers_count) VALUES
(1, 'virat.kohli', 260000000),
(2, 'priyanka.chopra', 90000000),
(3, 'shradha.kapoor', 85000000),
(4, 'tech_guru', 150000)
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO Posts (post_id, user_id, caption, likes_count) VALUES
(101, 1, 'World Cup Victory Celebrations!', 12000000),
(102, 1, 'Training session grind', 4500000),
(103, 2, 'Met Gala Red Carpet Look', 8000000),
(104, 3, 'Sunday brunch vibe', 6200000),
(105, 4, 'Unboxing new gadget', 50000)
ON CONFLICT (post_id) DO NOTHING;

-- SQL Solution (Multiple CTEs with UNION ALL):
WITH TopUsers AS (
    SELECT 
        'Top User' AS category_type,
        username AS item_description,
        followers_count AS metric_score
    FROM Users
    ORDER BY followers_count DESC
    LIMIT 3
),
TopPosts AS (
    SELECT 
        'Top Post' AS category_type,
        caption AS item_description,
        likes_count AS metric_score
    FROM Posts
    ORDER BY likes_count DESC
    LIMIT 3
)
SELECT category_type, item_description, metric_score FROM TopUsers
UNION ALL
SELECT category_type, item_description, metric_score FROM TopPosts;

-- Expected Result:
-- Displays top 3 users (virat.kohli, priyanka.chopra, shradha.kapoor) followed by 
-- top 3 posts (World Cup Victory, Met Gala, Sunday brunch vibe).
