-- ============================================
-- Project 02: Employee & Payroll Management System
-- File: queries.sql
-- ============================================

-- Query 1: Department wise Payroll Expense Summary
SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS total_employees,
    SUM(e.base_salary) AS total_base_payroll,
    ROUND(AVG(e.base_salary), 2) AS average_salary
FROM pay_departments d
JOIN pay_employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY total_base_payroll DESC;

-- Query 2: Monthly Net Payout per Employee
SELECT 
    e.emp_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    p.payment_date,
    p.gross_salary,
    p.deductions,
    p.net_salary
FROM pay_employees e
JOIN pay_payroll_history p ON e.emp_id = p.emp_id
ORDER BY p.payment_date DESC, p.net_salary DESC;
