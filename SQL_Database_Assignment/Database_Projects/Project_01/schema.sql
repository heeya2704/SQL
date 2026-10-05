-- ============================================
-- Project 01: E-Commerce Database System
-- File: schema.sql
-- ============================================

DROP TABLE IF EXISTS ecom_payments CASCADE;
DROP TABLE IF EXISTS ecom_order_items CASCADE;
DROP TABLE IF EXISTS ecom_orders CASCADE;
DROP TABLE IF EXISTS ecom_products CASCADE;
DROP TABLE IF EXISTS ecom_categories CASCADE;
DROP TABLE IF EXISTS ecom_users CASCADE;

CREATE TABLE ecom_users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ecom_categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE ecom_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT REFERENCES ecom_categories(category_id),
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0)
);

CREATE TABLE ecom_orders (
    order_id INT PRIMARY KEY,
    user_id INT REFERENCES ecom_users(user_id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE ecom_order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT REFERENCES ecom_orders(order_id) ON DELETE CASCADE,
    product_id INT REFERENCES ecom_products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL
);

CREATE TABLE ecom_payments (
    payment_id INT PRIMARY KEY,
    order_id INT UNIQUE REFERENCES ecom_orders(order_id) ON DELETE CASCADE,
    payment_method VARCHAR(30) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'Completed'
);
