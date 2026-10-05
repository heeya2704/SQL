-- ============================================
-- Practice Module: GROUP_BY & HAVING
-- Topic: Aggregation, Multi-Column Grouping, HAVING Filter
-- Engine: PostgreSQL Compatible
-- ============================================

-- 1. Single Column Aggregation (Department Headcount & Average Salary)
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    ROUND(AVG(s.salary), 2) AS average_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN salaries s ON e.employee_id = s.employee_id
GROUP BY d.department_id, d.department_name;

-- 2. Multi-Column Aggregation (Sales by Category & City)
SELECT 
    p.category,
    c.city,
    SUM(s.quantity) AS total_units_sold,
    SUM(s.sale_amount) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN orders o ON s.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY p.category, c.city;

-- 3. HAVING Clause (Departments with total salary expenditure > 150,000)
SELECT 
    d.department_name,
    SUM(s.salary) AS total_payroll
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN salaries s ON e.employee_id = s.employee_id
GROUP BY d.department_id, d.department_name
HAVING SUM(s.salary) > 150000.00;
