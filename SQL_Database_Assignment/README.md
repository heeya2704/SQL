# SQL Database Assignment Project Architecture

Welcome to the **SQL Database Assignment** repository. This project is structured as a comprehensive hands-on learning environment for SQL and Relational Database Management Systems (RDBMS) using **PostgreSQL** syntax standards.

---

## 📁 Repository Structure

```text
SQL_Database_Assignment/
│
├── README.md                          # Project Documentation & Guide
│
├── Session_01/                        # Session 01: Fundamentals (CREATE DB, Table, INSERT, SELECT)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_02/                        # Session 02: Filtering & Sorting (WHERE, ORDER BY, LIMIT, LIKE)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_03/                        # Session 03: Data Manipulation & Aggregations (DML, Aggregate Functions)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_04/                        # Session 04: Queries & Joins (DISTINCT, Aliases, INNER/LEFT/RIGHT/SELF JOIN)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_05/                        # Session 05: Filtering Expressions & Subqueries (IN, BETWEEN, Subqueries)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_06/                        # Session 06: Conditional Logic & Scalar Functions (CASE, COALESCE, Dates)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_07/                        # Session 07: Common Table Expressions (CTE & Recursive CTE)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_08/                        # Session 08: Window Functions (ROW_NUMBER, RANK, LEAD, LAG)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_09/                        # Session 09: Database Objects (Views, Indexes, Constraints)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_10/                        # Session 10: Advanced Objects (Stored Procedures, Triggers, Transactions)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_11/                        # Session 11: Advanced Subqueries (WHERE, SELECT, IN, Relational Division)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_12/                        # Session 12: CTEs & Recursive Queries (WITH, Multi-CTE, Recursive CTE)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_13/                        # Session 13: Ranking Window Functions (ROW_NUMBER, RANK, DENSE_RANK)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Session_14/                        # Session 14: Value & Frame Window Functions (LAG, LEAD, Running Total, Moving Avg)
│   ├── Task_1.sql
│   ├── Task_2.sql
│   ├── Task_3.sql
│   ├── Task_4.sql
│   └── Task_5.sql
│
├── Database_Setup/                    # Core Database Setup & Seed Scripts
│   ├── 01_create_database.sql         # Database creation script
│   ├── 02_create_tables.sql           # Schema definition (Tables, PK, FK)
│   ├── 03_insert_sample_data.sql      # Seed data populating all tables
│   └── 04_constraints.sql             # Additional constraints, alter statements & validation
│
├── Database_Projects/                 # End-to-End Database Case Studies
│   ├── Project_01/                    # E-Commerce Database System
│   │   ├── schema.sql
│   │   ├── data.sql
│   │   ├── queries.sql
│   │   └── README.md
│   │
│   └── Project_02/                    # Employee & Payroll Management System
│       ├── schema.sql
│       ├── data.sql
│       ├── queries.sql
│       └── README.md
│
└── Practice/                          # Topic-Wise Query Cheat Sheets & Practice Scripts
    ├── SELECT.sql
    ├── JOINS.sql
    ├── SUBQUERIES.sql
    ├── FUNCTIONS.sql
    ├── GROUP_BY.sql
    ├── WINDOW_FUNCTIONS.sql
    ├── CTE.sql
    └── ADVANCED_SQL.sql
```

---

## 🗄️ Standard Sample Database: `company_db`

To ensure consistency across Sessions 06 through 14 and Practice modules, a production-grade relational database named `company_db` is defined inside `Database_Setup/`.

### Entity Relationship & Tables
- **`departments`**: `department_id` (PK), `department_name`, `location`
- **`employees`**: `employee_id` (PK), `first_name`, `last_name`, `email`, `hire_date`, `job_title`, `department_id` (FK), `manager_id` (FK to employees)
- **`salaries`**: `salary_id` (PK), `employee_id` (FK), `salary`, `bonus`, `effective_date`
- **`projects`**: `project_id` (PK), `project_name`, `department_id` (FK), `budget`, `start_date`, `end_date`
- **`customers`**: `customer_id` (PK), `customer_name`, `email`, `city`, `country`
- **`products`**: `product_id` (PK), `product_name`, `category`, `unit_price`
- **`orders`**: `order_id` (PK), `customer_id` (FK), `order_date`, `status`
- **`sales`**: `sale_id` (PK), `order_id` (FK), `product_id` (FK), `quantity`, `sale_amount`

---

## 🚀 How to Set Up & Run

### 1. Prerequisites
- PostgreSQL 12+ (or compatible SQL engine like MySQL / SQLite for standard syntax)
- `psql` command line tool or GUI client (pgAdmin / DBeaver / VS Code SQL Tools)

### 2. Database Initialization
Run the initialization scripts in sequence:

```bash
# 1. Create the Database
psql -U postgres -f Database_Setup/01_create_database.sql

# 2. Create Schema & Tables
psql -U postgres -d company_db -f Database_Setup/02_create_tables.sql

# 3. Insert Sample Data
psql -U postgres -d company_db -f Database_Setup/03_insert_sample_data.sql

# 4. Apply Additional Constraints & Indexes
psql -U postgres -d company_db -f Database_Setup/04_constraints.sql
```

### 3. Running Individual Tasks
Each task script is self-contained. You can execute any file directly in `psql` or your preferred SQL tool:

```bash
psql -U postgres -d company_db -f Session_11/Task_1.sql
```

---

## 📚 Session Topics Summary

| Session | Topic | Key Concepts |
| :--- | :--- | :--- |
| **Session 01** | Database & Table Fundamentals | `CREATE DATABASE`, `CREATE TABLE`, `INSERT`, basic `SELECT` |
| **Session 02** | Filtering & Sorting | `WHERE`, `ORDER BY`, `DISTINCT`, `LIMIT`, `BETWEEN`, `IN`, `LIKE` |
| **Session 03** | Data Modification & Aggregations | `UPDATE`, `DELETE`, `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING` |
| **Session 04** | Aliasing & Joins | `AS`, `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN`, `SELF JOIN` |
| **Session 05** | Complex Filtering & Subqueries | Multi-condition filtering, Subqueries, Correlated Subqueries, `EXISTS`, `NOT EXISTS` |
| **Session 06** | Conditional Logic & Scalar Functions | `CASE`, `COALESCE`, `NULL` handling, `LENGTH`, `CONCAT`, `DATE_PART`, `AGE` |
| **Session 07** | Common Table Expressions (CTEs) | Single CTEs, Multiple CTEs, CTEs with Aggregation, Recursive CTEs |
| **Session 08** | Window Functions | `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LEAD`, `LAG`, Frame Clauses |
| **Session 09** | Database Objects | Materialized/Standard `VIEWS`, B-Tree `INDEXES`, Check & Unique `CONSTRAINTS` |
| **Session 10** | Advanced Database Programming | Stored Procedures (`PL/pgSQL`), Triggers, Audit Logging, `TRANSACTIONS` |
| **Session 11** | Advanced Subqueries & Division | Subquery in `WHERE`/`SELECT`/`IN`, Relational Division, Nested Subqueries |
| **Session 12** | Common Table Expressions (CTEs) | `WITH` clause, Subquery vs CTE readability, Multi-CTEs, Recursive CTEs |
| **Session 13** | Ranking Window Functions | `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, `PARTITION BY`, Top-N filtering |
| **Session 14** | Value & Frame Window Functions | `LAG()`, `LEAD()`, Running Total (`UNBOUNDED PRECEDING`), Moving Average |

---

## 📈 Scalability Note
This repository architecture is designed to scale seamlessly. Future sessions (`Session_15/`, `Session_16/`, etc.) can be appended directly following the standardized directory pattern.

