-- ============================================
-- Session 02
-- Task 05
-- Topic: Debugging SQL Errors & Syntax Rules
-- Objective: Identify intentional syntax error, analyze error message, and execute fix
-- ============================================

-- Task:
-- Intentionally make a mistake in your CREATE TABLE statement (such as missing a comma or using an unsupported data type),
-- run it, and then fix the error based on the message you receive.

/*
================================================================================
INTENTIONAL INCORRECT SQL STATEMENT (Missing comma after email column & invalid data type 'NUMBER'):
--------------------------------------------------------------------------------
CREATE TABLE test_users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100)          <-- ERROR: Missing comma!
    phone_number NUMBER(10)     <-- ERROR: 'NUMBER' is invalid type in PostgreSQL (use INT/BIGINT/NUMERIC)
);

ERROR RETURNED BY POSTGRESQL ENGINE:
"ERROR: syntax error at or near "phone_number"
LINE 5:     phone_number NUMBER(10)
            ^"
================================================================================
*/

-- SQL Solution (Corrected & Executable):
CREATE TABLE IF NOT EXISTS test_users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL
);

-- Expected Result:
-- Syntactically corrected table `test_users` compiles and creates successfully.
