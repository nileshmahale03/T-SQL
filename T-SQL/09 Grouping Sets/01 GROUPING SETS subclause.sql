
---------------------------------------------------------------------
-- GROUPING SETS

-- T-SQL supports standard features you can use to define multiple grouping sets in the same query.

-- Those are the 
-- 1. GROUPING SETS subclauses of the GROUP BY clause

-- The GROUPING SETS subclause is a powerful enhancement to the GROUP BY clause.
-- You can use it to define multiple grouping sets in the same query
-- Simply list the grouping sets you want, separated by commas within the parentheses of the GROUPING SETS subclause, and for each grouping set list the members, separated by commas, within parentheses.

-- The main use cases are reporting and data analysis
-- SQL Server typically needs fewer scans of the data than the number of grouping sets because it can roll up aggregates internally.
---------------------------------------------------------------------

USE TSQLV4
GO

SELECT empid, custid, SUM(qty) 'SumQty'
FROM dbo.Orders
GROUP BY GROUPING SETS ((),(empid),(custid),(empid,custid))