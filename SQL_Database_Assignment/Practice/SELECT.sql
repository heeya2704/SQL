-- ============================================
-- Practice Module: SELECT Queries
-- Topic: Basic & Advanced SELECT Statement Patterns
-- Engine: PostgreSQL Compatible
-- ============================================

-- 1. Simple Projection
SELECT employee_id, first_name, last_name, job_title
FROM employees;

-- 2. Filtering with Comparison & Logical Operators
SELECT *
FROM employees
WHERE department_id = 1 AND job_title LIKE '%Engineer%';

-- 3. Expression Evaluation & Aliases
SELECT 
    first_name || ' ' || last_name AS full_name,
    salary,
    bonus,
    (salary + bonus) AS total_compensation
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id;
