-- ============================================
-- Session 11
-- Task 02
-- Topic: Subqueries in SELECT Statement
-- Objective: Display each user's profile summary along with their total order count
-- ============================================

-- Task Description:
-- Write a SQL query that uses a subquery in the SELECT statement to display 
-- each user's name from a 'Users' table along with the total number of orders 
-- they have placed from an 'Orders' table, like a summary you might see in a Zomato profile.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    order_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO Users (user_id, name, email) VALUES
(101, 'Aarav Sharma', 'aarav@example.com'),
(102, 'Ananya Patel', 'ananya@example.com'),
(103, 'Rohan Mehta', 'rohan@example.com'),
(104, 'Priya Singh', 'priya@example.com')
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO Orders (order_id, user_id, order_date, amount) VALUES
(1, 101, '2024-03-01', 350.00),
(2, 101, '2024-03-05', 450.50),
(3, 101, '2024-03-12', 200.00),
(4, 102, '2024-03-02', 890.00),
(5, 102, '2024-03-10', 120.00),
(6, 103, '2024-03-15', 550.00)
ON CONFLICT (order_id) DO NOTHING;

-- SQL Solution:
SELECT 
    u.user_id,
    u.name AS user_name,
    u.email,
    (
        SELECT COUNT(*) 
        FROM Orders o 
        WHERE o.user_id = u.user_id
    ) AS total_orders_placed
FROM Users u
ORDER BY u.user_id ASC;

-- Expected Result:
-- Displays all users including Priya Singh (0 orders), Aarav Sharma (3 orders), 
-- Ananya Patel (2 orders), and Rohan Mehta (1 order).
