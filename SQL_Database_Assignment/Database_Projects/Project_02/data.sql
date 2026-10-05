-- ============================================
-- Project 02: Employee & Payroll Management System
-- File: data.sql
-- ============================================

INSERT INTO pay_departments (dept_id, dept_name, budget) VALUES
(10, 'Engineering', 500000.00),
(20, 'Human Resources', 150000.00),
(30, 'Finance', 250000.00)
ON CONFLICT (dept_id) DO NOTHING;

INSERT INTO pay_employees (emp_id, first_name, last_name, email, dept_id, base_salary, hire_date) VALUES
(1001, 'Karan', 'Mehta', 'karan@company.com', 10, 120000.00, '2020-01-15'),
(1002, 'Sneha', 'Kapoor', 'sneha@company.com', 10, 95000.00, '2021-06-01'),
(1003, 'Rohan', 'Gupta', 'rohan@company.com', 20, 65000.00, '2019-03-10'),
(1004, 'Neha', 'Sharma', 'neha@company.com', 30, 110000.00, '2018-11-20')
ON CONFLICT (emp_id) DO NOTHING;

INSERT INTO pay_payroll_history (payroll_id, emp_id, payment_date, gross_salary, deductions) VALUES
(501, 1001, '2024-02-28', 10000.00, 1500.00),
(502, 1002, '2024-02-28', 7916.67, 1100.00),
(503, 1003, '2024-02-28', 5416.67, 600.00),
(504, 1004, '2024-02-28', 9166.67, 1300.00)
ON CONFLICT (payroll_id) DO NOTHING;
