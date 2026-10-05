-- ============================================
-- Project 01: E-Commerce Database System
-- File: queries.sql
-- ============================================

-- Query 1: Total Revenue by Customer
SELECT 
    u.full_name,
    u.city,
    COUNT(o.order_id) AS total_orders,
    SUM(p.amount) AS total_spent
FROM ecom_users u
JOIN ecom_orders o ON u.user_id = o.user_id
JOIN ecom_payments p ON o.order_id = p.order_id
GROUP BY u.user_id, u.full_name, u.city
ORDER BY total_spent DESC;

-- Query 2: Best Selling Product by Quantity
SELECT 
    pr.product_name,
    c.category_name,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_product_revenue
FROM ecom_order_items oi
JOIN ecom_products pr ON oi.product_id = pr.product_id
JOIN ecom_categories c ON pr.category_id = c.category_id
GROUP BY pr.product_id, pr.product_name, c.category_name
ORDER BY total_units_sold DESC;
