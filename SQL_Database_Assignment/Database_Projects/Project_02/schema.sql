-- ============================================
-- Project 02: Employee & Payroll Management System
-- File: schema.sql
-- ============================================

DROP TABLE IF EXISTS pay_payroll_history CASCADE;
DROP TABLE IF EXISTS pay_employees CASCADE;
DROP TABLE IF EXISTS pay_departments CASCADE;

CREATE TABLE pay_departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE,
    budget NUMERIC(14, 2) NOT NULL CHECK (budget >= 0)
);

CREATE TABLE pay_employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    dept_id INT REFERENCES pay_departments(dept_id) ON DELETE SET NULL,
    base_salary NUMERIC(12, 2) NOT NULL CHECK (base_salary >= 0),
    hire_date DATE NOT NULL
);

CREATE TABLE pay_payroll_history (
    payroll_id INT PRIMARY KEY,
    emp_id INT REFERENCES pay_employees(emp_id) ON DELETE CASCADE,
    payment_date DATE NOT NULL,
    gross_salary NUMERIC(12, 2) NOT NULL,
    deductions NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    net_salary NUMERIC(12, 2) GENERATED ALWAYS AS (gross_salary - deductions) STORED
);
