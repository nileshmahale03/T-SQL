
---------------------------------------------------------------------
-- Window Functions

-- Window functions, which you can use to apply data-analysis calculations in a flexible and efficient manner.

-- A window function is a function that, for each row, computes a scalar result value based on a calculation against a subset of the rows from the underlying query.
-- The subset of rows is known as a window
-- The syntax for window functions uses a clause called OVER, in which you provide the window specification

-- Unlike grouped functions, window functions don’t cause you to lose the detail.
-- one of the great advantages of window functions is that they don’t hide the detail. This means you can write expressions that mix detail and aggregates.

-- Note that because the starting point of a window function is the underlying query’s result set, and the underlying query’s result set is generated only when you reach the SELECT phase, 
-- window functions are allowed only in the SELECT and ORDER BY clauses of a query.
-- Window functions are logically evaluated as part of the SELECT list, before the DISTINCT clause is evaluated.

-- The window-partition clause (PARTITION BY)
-- The window-order clause (ORDER BY)
-- A window-frame clause (ROWS BETWEEN <top delimiter> AND <bottom delimiter>)
---------------------------------------------------------------------

USE TSQLV4

SELECT * 
FROM Sales.EmpOrders
ORDER BY empid, ordermonth

