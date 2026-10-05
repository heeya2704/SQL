-- ============================================
-- Database Setup: 02_create_tables.sql
-- Topic: Relational Schema Definition
-- Objective: Define tables with PK/FK constraints in correct dependency order
-- Engine: PostgreSQL Compatible
-- ============================================

-- Drop existing tables in reverse dependency order
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS salaries CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS departments CASCADE;

-- 1. Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL
);

-- 2. Employees Table (Self-referencing FK manager_id)
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    hire_date DATE NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    department_id INT REFERENCES departments(department_id) ON DELETE SET NULL,
    manager_id INT REFERENCES employees(employee_id) ON DELETE SET NULL
);

-- 3. Salaries Table
CREATE TABLE salaries (
    salary_id INT PRIMARY KEY,
    employee_id INT NOT NULL REFERENCES employees(employee_id) ON DELETE CASCADE,
    salary NUMERIC(12, 2) NOT NULL CHECK (salary >= 0),
    bonus NUMERIC(10, 2) DEFAULT 0.00 CHECK (bonus >= 0),
    effective_date DATE NOT NULL
);

-- 4. Projects Table
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    department_id INT REFERENCES departments(department_id) ON DELETE CASCADE,
    budget NUMERIC(14, 2) CHECK (budget >= 0),
    start_date DATE NOT NULL,
    end_date DATE
);

-- 5. Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) DEFAULT 'USA'
);

-- 6. Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0)
);

-- 7. Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id) ON DELETE CASCADE,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Completed' CHECK (status IN ('Pending', 'Processing', 'Completed', 'Cancelled'))
);

-- 8. Sales Table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT NOT NULL REFERENCES products(product_id) ON DELETE RESTRICT,
    quantity INT NOT NULL CHECK (quantity > 0),
    sale_amount NUMERIC(12, 2) NOT NULL CHECK (sale_amount >= 0)
);
