-- ============================================
-- Session 02
-- Task 04
-- Topic: Table Design & Unique Constraints
-- Objective: Design 'users' table for Flipkart-style app
-- ============================================

-- Task:
-- Design and create a 'users' table for a Flipkart-style app with columns: user_id (primary key), 
-- username, email, phone_number, and created_at (date/time). Pick appropriate data types for each column.
-- Hint: Think about which columns should be unique and which data types best fit email and phone numbers.

-- SQL Solution:
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Expected Result:
-- 'users' table created with user_id as PK, email & phone_number as UNIQUE text columns, and created_at as TIMESTAMP.
