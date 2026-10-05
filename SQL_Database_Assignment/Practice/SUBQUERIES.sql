-- ============================================
-- Practice Module: SUBQUERIES
-- Topic: Scalar Subqueries, IN, EXISTS, & Correlated Subqueries
-- Engine: PostgreSQL Compatible
-- ============================================

-- 1. Scalar Subquery in WHERE Clause (Employees earning above average salary)
SELECT e.employee_id, e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.salary > (SELECT AVG(salary) FROM salaries);

-- 2. Subquery with IN Operator (Employees in departments with budget > 200,000)
SELECT employee_id, first_name, last_name, department_id
FROM employees
WHERE department_id IN (
    SELECT department_id 
    FROM projects 
    WHERE budget > 200000.00
);

-- 3. Correlated Subquery with EXISTS (Customers who have placed completed orders)
SELECT customer_id, customer_name, email
FROM customers c
WHERE EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.customer_id AND o.status = 'Completed'
);
