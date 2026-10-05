# Project 01: E-Commerce Database System

## Overview
This project simulates an end-to-end relational database for an E-Commerce application (similar to Amazon or Flipkart).

## System Components
1. **`schema.sql`**: Table creation script defining users, product catalog, shopping carts, orders, order items, and payment transactions with full foreign key cascades and constraints.
2. **`data.sql`**: Production-like mock dataset initializing users, products, categories, orders, and payments.
3. **`queries.sql`**: Analytical and operational SQL queries covering customer order histories, top-selling products, revenue calculations, and pending order tracking.

## Execution Instructions
```bash
psql -U postgres -d company_db -f schema.sql
psql -U postgres -d company_db -f data.sql
psql -U postgres -d company_db -f queries.sql
```
