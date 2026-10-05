# Project 02: Employee & Payroll Management System

## Overview
This project delivers a corporate Employee and Payroll database system designed to track organizational hierarchy, department budgets, salary history, performance bonuses, and monthly payroll disbursemens.

## System Components
1. **`schema.sql`**: Relational tables for employees, departments, job titles, and payroll logs.
2. **`data.sql`**: Realistic employee roster, departmental assignments, and salary records.
3. **`queries.sql`**: Analytical queries calculating department payroll expenses, highest paid employees per department, and manager-to-employee structures.

## Execution Instructions
```bash
psql -U postgres -d company_db -f schema.sql
psql -U postgres -d company_db -f data.sql
psql -U postgres -d company_db -f queries.sql
```
