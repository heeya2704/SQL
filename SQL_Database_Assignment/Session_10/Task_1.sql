-- ============================================
-- Session 10
-- Task 01
-- Topic: FULL OUTER JOIN Queries
-- Objective: List all influencers and their collaboration partner names including uncollaborated entities
-- ============================================

-- Task:
-- Create two tables: Influencers (id, name) and Collaborations (id, influencer1_id, influencer2_id, collab_date).
-- Write a SQL FULL JOIN query to list all influencers and show their collaboration partner names if any,
-- including influencers with no collaborations.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Influencers (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Collaborations (
    id INT PRIMARY KEY,
    influencer1_id INT REFERENCES Influencers(id),
    influencer2_id INT REFERENCES Influencers(id),
    collab_date DATE NOT NULL
);

INSERT INTO Influencers (id, name) VALUES
(1, 'TechBurner'),
(2, 'CarryMinati'),
(3, 'TechnicalGuruji'),
(4, 'Solo Creator') -- No collaborations
ON CONFLICT (id) DO NOTHING;

INSERT INTO Collaborations (id, influencer1_id, influencer2_id, collab_date) VALUES
(101, 1, 2, '2024-01-15'),
(102, 1, 3, '2024-02-20')
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT 
    i.id AS influencer_id,
    i.name AS influencer_name,
    c.id AS collab_id,
    p.name AS partner_name,
    c.collab_date
FROM Influencers i
FULL JOIN Collaborations c ON i.id = c.influencer1_id
LEFT JOIN Influencers p ON c.influencer2_id = p.id
ORDER BY i.id ASC;

-- Expected Result:
-- Displays all influencers including 'Solo Creator' with NULL partner_name and collab_date.
