-- ============================================
-- Session 10
-- Task 03
-- Topic: Multi-Table LEFT JOINs
-- Objective: Display username, order_date, and payment amount for all users (including inactive users)
-- ============================================

-- Task:
-- Given three tables: Users (id, username), Orders (id, user_id, order_date), and Payments (id, order_id, amount),
-- write a SQL query using multiple JOINs to display each username, their order date, and payment amount,
-- showing all users even if they have no orders or payments.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Users (
    id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Orders (
    id INT PRIMARY KEY,
    user_id INT REFERENCES Users(id),
    order_date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Payments (
    id INT PRIMARY KEY,
    order_id INT REFERENCES Orders(id),
    amount NUMERIC(10, 2) NOT NULL
);

INSERT INTO Users (id, username) VALUES
(1, 'amit_kumar'),
(2, 'priya_sharma'),
(3, 'inactive_user') -- User with no orders
ON CONFLICT (id) DO NOTHING;

INSERT INTO Orders (id, user_id, order_date) VALUES
(101, 1, '2024-03-01'),
(102, 2, '2024-03-05')
ON CONFLICT (id) DO NOTHING;

INSERT INTO Payments (id, order_id, amount) VALUES
(201, 101, 1250.00),
(202, 102, 450.00)
ON CONFLICT (id) DO NOTHING;

-- SQL Solution:
SELECT 
    u.id AS user_id,
    u.username,
    o.order_date,
    p.amount AS payment_amount
FROM Users u
LEFT JOIN Orders o ON u.id = o.user_id
LEFT JOIN Payments p ON o.id = p.order_id
ORDER BY u.id ASC;

-- Expected Result:
-- Displays all users including 'inactive_user' with NULL order_date and payment_amount.
