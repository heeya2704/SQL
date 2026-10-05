-- ============================================
-- Project 01: E-Commerce Database System
-- File: data.sql
-- ============================================

INSERT INTO ecom_users (user_id, full_name, email, city) VALUES
(1, 'Rahul Verma', 'rahul@example.com', 'Delhi'),
(2, 'Ananya Sharma', 'ananya@example.com', 'Mumbai'),
(3, 'Vikram Singh', 'vikram@example.com', 'Bangalore')
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO ecom_categories (category_id, category_name) VALUES
(10, 'Electronics'),
(20, 'Footwear'),
(30, 'Home Appliances')
ON CONFLICT (category_id) DO NOTHING;

INSERT INTO ecom_products (product_id, product_name, category_id, price, stock_quantity) VALUES
(101, 'Smartphone Pro', 10, 49999.00, 50),
(102, 'Wireless Earbuds', 10, 2999.00, 150),
(103, 'Running Shoes', 20, 3499.00, 80),
(104, 'Air Fryer 4L', 30, 6999.00, 30)
ON CONFLICT (product_id) DO NOTHING;

INSERT INTO ecom_orders (order_id, user_id, order_date, status) VALUES
(5001, 1, '2024-03-01 10:00:00', 'Delivered'),
(5002, 2, '2024-03-05 14:30:00', 'Shipped'),
(5003, 1, '2024-03-10 11:15:00', 'Processing')
ON CONFLICT (order_id) DO NOTHING;

INSERT INTO ecom_order_items (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 5001, 101, 1, 49999.00),
(2, 5001, 102, 2, 2999.00),
(3, 5002, 103, 1, 3499.00),
(4, 5003, 104, 1, 6999.00)
ON CONFLICT (order_item_id) DO NOTHING;

INSERT INTO ecom_payments (payment_id, order_id, payment_method, amount, payment_status) VALUES
(901, 5001, 'Credit Card', 55997.00, 'Completed'),
(902, 5002, 'UPI', 3499.00, 'Completed'),
(903, 5003, 'Net Banking', 6999.00, 'Completed')
ON CONFLICT (payment_id) DO NOTHING;
