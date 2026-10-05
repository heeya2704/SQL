-- ============================================
-- Database Setup: 03_insert_sample_data.sql
-- Topic: Data Population
-- Objective: Populate company_db with realistic seed data
-- Engine: PostgreSQL Compatible
-- ============================================

-- Clear existing data
TRUNCATE TABLE sales, orders, products, customers, projects, salaries, employees, departments RESTART IDENTITY CASCADE;

-- 1. Insert Departments
INSERT INTO departments (department_id, department_name, location) VALUES
(1, 'Engineering', 'New York'),
(2, 'Human Resources', 'Chicago'),
(3, 'Sales & Marketing', 'San Francisco'),
(4, 'Finance', 'Boston'),
(5, 'Operations', 'Austin');

-- 2. Insert Employees (Managers inserted first, then staff)
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_title, department_id, manager_id) VALUES
(101, 'Eleanor', 'Vane', 'eleanor.vane@company.com', '2018-03-15', 'VP of Engineering', 1, NULL),
(102, 'Marcus', 'Brooke', 'marcus.brooke@company.com', '2019-06-01', 'HR Director', 2, NULL),
(103, 'Sophia', 'Chen', 'sophia.chen@company.com', '2017-11-20', 'Sales Director', 3, NULL),
(104, 'Julian', 'Ross', 'julian.ross@company.com', '2020-01-10', 'Engineering Lead', 1, 101),
(105, 'Amara', 'Patel', 'amara.patel@company.com', '2021-04-12', 'Senior Software Engineer', 1, 104),
(106, 'Liam', 'O''Connor', 'liam.oconnor@company.com', '2022-08-01', 'Software Engineer', 1, 104),
(107, 'Zoe', 'Kovacs', 'zoe.kovacs@company.com', '2021-09-15', 'HR Executive', 2, 102),
(108, 'Ethan', 'Wright', 'ethan.wright@company.com', '2019-02-28', 'Sales Executive', 3, 103),
(109, 'Maya', 'Lin', 'maya.lin@company.com', '2022-03-14', 'Marketing Specialist', 3, 103),
(110, 'David', 'Miller', 'david.miller@company.com', '2016-05-04', 'Finance Lead', 4, NULL);

-- 3. Insert Salaries
INSERT INTO salaries (salary_id, employee_id, salary, bonus, effective_date) VALUES
(1, 101, 160000.00, 25000.00, '2024-01-01'),
(2, 102, 110000.00, 12000.00, '2024-01-01'),
(3, 103, 135000.00, 30000.00, '2024-01-01'),
(4, 104, 125000.00, 15000.00, '2024-01-01'),
(5, 105, 95000.00, 8000.00, '2024-01-01'),
(6, 106, 75000.00, 5000.00, '2024-01-01'),
(7, 107, 62000.00, 4000.00, '2024-01-01'),
(8, 108, 70000.00, 18000.00, '2024-01-01'),
(9, 109, 58000.00, 6000.00, '2024-01-01'),
(10, 110, 115000.00, 14000.00, '2024-01-01');

-- 4. Insert Projects
INSERT INTO projects (project_id, project_name, department_id, budget, start_date, end_date) VALUES
(201, 'Cloud Migration Phase 1', 1, 250000.00, '2024-01-15', '2024-06-30'),
(202, 'AI Customer Assistant', 1, 180000.00, '2024-03-01', '2024-11-30'),
(203, 'Global HR Portal', 2, 75000.00, '2024-02-01', '2024-07-31'),
(204, 'Q3 Digital Campaign', 3, 120000.00, '2024-05-01', '2024-09-30'),
(205, 'ERP System Upgrade', 4, 300000.00, '2024-01-01', '2024-12-31');

-- 5. Insert Customers
INSERT INTO customers (customer_id, customer_name, email, city, country) VALUES
(301, 'Acme Corporation', 'billing@acme.com', 'New York', 'USA'),
(302, 'TechNova Ltd', 'contact@technova.io', 'San Francisco', 'USA'),
(303, 'Global Logistics Inc', 'info@globallogistics.com', 'Chicago', 'USA'),
(304, 'Apex Innovations', 'orders@apexinno.com', 'Austin', 'USA'),
(305, 'Zenith Retail Solutions', 'support@zenithretail.com', 'London', 'UK');

-- 6. Insert Products
INSERT INTO products (product_id, product_name, category, unit_price) VALUES
(401, 'Enterprise Cloud Suite', 'Software', 1200.00),
(402, 'Database License Pro', 'Software', 850.00),
(403, 'Analytics Dashboard Addon', 'Software', 450.00),
(404, '24/7 Premium Support Tier', 'Services', 2000.00),
(405, 'Consulting Onboarding Package', 'Services', 3500.00);

-- 7. Insert Orders
INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(501, 301, '2024-01-10 10:30:00', 'Completed'),
(502, 302, '2024-01-14 14:15:00', 'Completed'),
(503, 303, '2024-02-01 09:00:00', 'Completed'),
(504, 301, '2024-02-20 16:45:00', 'Completed'),
(505, 304, '2024-03-05 11:20:00', 'Processing'),
(506, 305, '2024-03-12 15:10:00', 'Cancelled');

-- 8. Insert Sales
INSERT INTO sales (sale_id, order_id, product_id, quantity, sale_amount) VALUES
(601, 501, 401, 5, 6000.00),
(602, 501, 404, 1, 2000.00),
(603, 502, 402, 3, 2550.00),
(604, 503, 405, 1, 3500.00),
(605, 504, 403, 10, 4500.00),
(606, 505, 401, 2, 2400.00);
