-- ============================================
-- Practice Module: JOINS
-- Topic: INNER, LEFT, RIGHT, FULL, and SELF JOINs
-- Engine: PostgreSQL Compatible
-- ============================================

-- 1. INNER JOIN (Employees & Departments)
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name,
    d.location
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- 2. LEFT JOIN (Departments & Projects)
SELECT 
    d.department_name,
    p.project_name,
    p.budget
FROM departments d
LEFT JOIN projects p ON d.department_id = p.department_id;

-- 3. SELF JOIN (Employees & Managers)
SELECT 
    emp.first_name || ' ' || emp.last_name AS employee_name,
    mgr.first_name || ' ' || mgr.last_name AS manager_name
FROM employees emp
LEFT JOIN employees mgr ON emp.manager_id = mgr.employee_id;
