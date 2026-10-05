-- ============================================
-- Session 01
-- Task 05
-- Topic: SQL Conceptual Fundamentals
-- Objective: Table vs Row vs Column explanation with Zomato food delivery app example
-- ============================================

-- Task:
-- Open ChatGPT or Copilot and ask it to explain the difference between a table, a row, and a column in SQL 
-- using an example from a food delivery app like Zomato. Paste the explanation you receive into your assignment.

/*
================================================================================
AI ASSISTANT EXPLANATION (Zomato Food Delivery Analogy):
================================================================================

Imagine a Zomato food delivery application storing order records.

1. TABLE (The Entire Spreadsheet / Register):
   - Definition: A table is a structured collection of related data organized in rows and columns.
   - Zomato Example: The `FoodOrders` table contains all customer orders placed across the platform.

2. ROW / RECORD (A Single Order Entry):
   - Definition: A row (also known as a record or tuple) represents a single, individual data entity or transaction.
   - Zomato Example: Row #101 represents one specific order placed by "Rahul Sharma" for a "Butter Chicken" from "Punjab Grill".

3. COLUMN / FIELD (A Specific Attribute):
   - Definition: A column (also known as a field or attribute) defines a specific piece of information stored for every row.
   - Zomato Example: Columns in the `FoodOrders` table include:
     * `order_id` (Integer)
     * `customer_name` (Text)
     * `restaurant_name` (Text)
     * `total_amount` (Decimal)
     * `order_status` (Text)

Summary Table Visualization:
+----------+---------------+-----------------+--------------+--------------+  <-- COLUMNS (Attributes)
| order_id | customer_name | restaurant_name | total_amount | order_status |
+----------+---------------+-----------------+--------------+--------------+
| 1001     | Rahul Sharma  | Punjab Grill    | 450.00       | Delivered    |  <-- ROW 1 (Individual Record)
| 1002     | Ananya Sen    | Domino's Pizza  | 599.00       | In Transit   |  <-- ROW 2 (Individual Record)
+----------+---------------+-----------------+--------------+--------------+
================================================================================
*/

-- Executable SQL verification statement:
SELECT 'Table = FoodOrders collection, Row = Single order, Column = Specific attribute (e.g., total_amount)' AS conceptual_explanation;

-- Expected Result:
-- Returns the conceptual explanation string illustrating understanding of RDBMS core primitives.
