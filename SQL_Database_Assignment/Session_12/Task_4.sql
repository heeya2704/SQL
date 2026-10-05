-- ============================================
-- Session 12
-- Task 04
-- Topic: Recursive CTEs
-- Objective: Generate a sequence of booking dates for the next 7 days
-- ============================================

-- Task Description:
-- Write a recursive CTE that generates a list of dates for the next 7 days starting from today, 
-- similar to how BookMyShow shows available dates for movie bookings.
-- Hint: Use a base case for today and recursion to add one day at a time.

-- SQL Solution (Recursive CTE):
WITH RECURSIVE BookingCalendar AS (
    -- Anchor Member (Base Case): Today's date
    SELECT 
        CURRENT_DATE AS booking_date,
        1 AS day_sequence
    
    UNION ALL
    
    -- Recursive Member: Add 1 day per iteration up to 7 days total
    SELECT 
        (booking_date + INTERVAL '1 day')::DATE,
        day_sequence + 1
    FROM BookingCalendar
    WHERE day_sequence < 7
)
SELECT 
    day_sequence,
    booking_date,
    TO_CHAR(booking_date, 'FMDay, DD Month YYYY') AS formatted_date
FROM BookingCalendar;

-- Expected Result:
-- Returns 7 consecutive date rows starting from today's date (Day 1 through Day 7).
