-- ============================================
-- Database Setup: 04_constraints.sql
-- Topic: Advanced Constraints & Indexes
-- Objective: Add performance indexes, check constraints, and integrity rules
-- Engine: PostgreSQL Compatible
-- ============================================

-- 1. Add Index on frequently queried columns
CREATE INDEX IF NOT EXISTS idx_employees_department ON employees(department_id);
CREATE INDEX IF NOT EXISTS idx_employees_manager ON employees(manager_id);
CREATE INDEX IF NOT EXISTS idx_orders_customer ON orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_sales_order ON sales(order_id);
CREATE INDEX IF NOT EXISTS idx_sales_product ON sales(product_id);

-- 2. Add Composite Index for fast reporting queries
CREATE INDEX IF NOT EXISTS idx_sales_order_product ON sales(order_id, product_id);

-- 3. Verify Constraints Summary Comment
-- - PK constraints enforced on primary key columns across all tables.
-- - FK constraints enforced with CASCADE / RESTRICT rules.
-- - UNIQUE constraints on emails and department names.
-- - CHECK constraints on salary, bonus, unit_price, quantity, and status values.
