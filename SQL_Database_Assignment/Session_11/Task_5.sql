-- ============================================
-- Session 11
-- Task 05
-- Topic: Correlated Subqueries with EXISTS
-- Objective: Find customers who have made orders above $500 using EXISTS
-- ============================================

-- Task Description:
-- Write a SQL query using a correlated subquery with the EXISTS operator 
-- to identify all customers from a 'Customers' table who have placed at least 
-- one order with an amount greater than 500 in an 'Orders' table.

-- Setup Tables & Seed Data:
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Customer_Orders (
    order_id INT PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id),
    order_amount DECIMAL(10, 2) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO Customers (customer_id, customer_name, city) VALUES
(1, 'Rohan Verma', 'Mumbai'),
(2, 'Ishita Roy', 'Delhi'),
(3, 'Kabir Kapoor', 'Bengaluru'),
(4, 'Tanya Das', 'Kolkata')
ON CONFLICT (customer_id) DO NOTHING;

INSERT INTO Customer_Orders (order_id, customer_id, order_amount, order_date) VALUES
(101, 1, 650.00, '2024-02-01'),
(102, 1, 200.00, '2024-02-05'),
(103, 2, 450.00, '2024-02-03'),
(104, 3, 1200.00, '2024-02-10')
ON CONFLICT (order_id) DO NOTHING;

-- SQL Solution:
SELECT 
    c.customer_id,
    c.customer_name,
    c.city
FROM Customers c
WHERE EXISTS (
    SELECT 1 
    FROM Customer_Orders co 
    WHERE co.customer_id = c.customer_id 
      AND co.order_amount > 500.00
)
ORDER BY c.customer_id ASC;

-- Expected Result:
-- Returns Rohan Verma ($650 order) and Kabir Kapoor ($1200 order).
