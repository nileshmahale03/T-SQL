
---------------------------------------------------------------------
-- ROLLUP

-- T-SQL supports standard features you can use to define multiple grouping sets in the same query.

-- Those are the 
-- 2. ROLLUP subclauses of the GROUP BY clause

-- The ROLLUP subclause of the GROUP BY clause provides an abbreviated way to define multiple grouping sets.
-- Unlike the CUBE subclause, ROLLUP doesn’t produce all possible grouping sets.
-- ROLLUP assumes a hierarchy among the input members and produces only grouping sets that form leading combinations of the input members.
-- For example, whereas CUBE(a, b, c) produces all eight possible grouping sets, ROLLUP(a, b, c) produces only four based on the hierarchy a>b>c. 
-- It is the equivalent of specifying GROUPING SETS( (a, b, c), (a, b), (a), () ).
-- E.g. ROLLUP(YEAR(orderdate), MONTH(orderdate), DAY(orderdate)) is equivalent to specifying GROUPING SETS( YEAR(orderdate), MONTH(orderdate), DAY(orderdate), YEAR(orderdate), MONTH(orderdate), YEAR(orderdate), () )

-- The main use cases are reporting and data analysis
-- SQL Server typically needs fewer scans of the data than the number of grouping sets because it can roll up aggregates internally.
---------------------------------------------------------------------

USE TSQLV4
GO

SELECT empid, custid, SUM(qty) 'SumQty'
FROM dbo.Orders
GROUP BY ROLLUP(empid, custid)

----------------------------------------------------------------------
--Example 2
--------------------------------------------------------------------- 

SELECT SUM(qty)
FROM dbo.Orders

SELECT YEAR(orderdate), SUM(qty)
FROM dbo.Orders
GROUP BY YEAR(orderdate)
ORDER BY YEAR(orderdate)

SELECT YEAR(orderdate), MONTH(orderdate), SUM(qty)
FROM dbo.Orders
GROUP BY YEAR(orderdate), MONTH(orderdate)
ORDER BY YEAR(orderdate), MONTH(orderdate)

SELECT YEAR(orderdate), MONTH(orderdate), DAY(orderdate), SUM(qty)
FROM dbo.Orders
GROUP BY YEAR(orderdate), MONTH(orderdate), DAY(orderdate)
ORDER BY YEAR(orderdate), MONTH(orderdate), DAY(orderdate)

SELECT YEAR(orderdate), MONTH(orderdate), DAY(orderdate), SUM(qty)
FROM dbo.Orders
GROUP BY ROLLUP(YEAR(orderdate), MONTH(orderdate), DAY(orderdate))