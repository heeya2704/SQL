-- ============================================
-- Session 12
-- Task 05
-- Topic: CTE Code Refactoring
-- Objective: Refactor messy subquery logic into a clean, maintainable CTE
-- ============================================

-- Task Description:
-- Given a messy SQL query that finds all users with more than 1000 followers 
-- from a 'Users' table, refactor it to use a CTE for better clarity and maintainability.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Social_Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    followers_count INT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    account_type VARCHAR(20) DEFAULT 'public'
);

INSERT INTO Social_Users (user_id, username, email, followers_count, is_active, account_type) VALUES
(1, 'alex_pro', 'alex@example.com', 1500, TRUE, 'public'),
(2, 'sarah_m', 'sarah@example.com', 450, TRUE, 'public'),
(3, 'dev_dave', 'dave@example.com', 8900, TRUE, 'public'),
(4, 'vip_bot', 'bot@example.com', 12000, FALSE, 'public'),
(5, 'private_jane', 'jane@example.com', 3400, TRUE, 'private')
ON CONFLICT (user_id) DO NOTHING;

-- --------------------------------------------
-- Original Messy Query (Unstructured Subquery):
-- --------------------------------------------
-- SELECT * FROM (SELECT user_id, username, email, followers_count FROM Social_Users WHERE is_active = TRUE AND account_type = 'public') u WHERE u.followers_count > 1000 ORDER BY u.followers_count DESC;

-- --------------------------------------------
-- Refactored SQL Solution (Clean CTE Architecture):
-- --------------------------------------------
WITH ActivePublicInfluencers AS (
    SELECT 
        user_id,
        username,
        email,
        followers_count
    FROM Social_Users
    WHERE is_active = TRUE 
      AND account_type = 'public'
      AND followers_count > 1000
)
SELECT 
    user_id,
    username,
    email,
    followers_count
FROM ActivePublicInfluencers
ORDER BY followers_count DESC;

-- Expected Result:
-- Returns dev_dave (8900 followers) and alex_pro (1500 followers).
-- Filters out inactive users (vip_bot) and private accounts (private_jane).
