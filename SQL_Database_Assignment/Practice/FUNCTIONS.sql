-- ============================================
-- Practice Module: FUNCTIONS
-- Topic: Scalar String, Numeric, & Date Functions
-- Engine: PostgreSQL Compatible
-- ============================================

-- 1. String Manipulation Functions
SELECT 
    employee_id,
    UPPER(last_name) || ', ' || INITCAP(first_name) AS formatted_name,
    LENGTH(email) AS email_length,
    SUBSTRING(email FROM '@(.*)$') AS email_domain
FROM employees;

-- 2. Date & Time Functions
SELECT 
    employee_id,
    first_name,
    hire_date,
    CURRENT_DATE AS today,
    AGE(CURRENT_DATE, hire_date) AS tenure,
    EXTRACT(YEAR FROM hire_date) AS hire_year
FROM employees;

-- 3. Conditional COALESCE & NULLIF
SELECT 
    p.project_name,
    COALESCE(p.end_date, CURRENT_DATE) AS effective_end_date,
    COALESCE(CAST(p.budget AS VARCHAR), 'Unassigned Budget') AS budget_status
FROM projects p;
