
---------------------------------------------------------------------
-- CUBE

-- T-SQL supports standard features you can use to define multiple grouping sets in the same query.

-- Those are the 
-- 2. CUBE subclauses of the GROUP BY clause

-- The CUBE subclause of the GROUP BY clause provides an abbreviated way to define multiple grouping sets.
-- You get all possible grouping sets that can be defined based on the input members
-- For example, CUBE(a, b, c) is equivalent to GROUPING SETS( (a, b, c), (a, b), (a, c), (b, c), (a), (b), (c), () ).

-- The main use cases are reporting and data analysis
-- SQL Server typically needs fewer scans of the data than the number of grouping sets because it can roll up aggregates internally.
---------------------------------------------------------------------

USE TSQLV4
GO


SELECT empid, custid, SUM(qty) 'SumQty'
FROM dbo.Orders
GROUP BY CUBE(empid, custid)