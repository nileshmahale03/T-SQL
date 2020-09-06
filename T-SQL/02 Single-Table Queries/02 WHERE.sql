---------------------------------------------------------------------
-- WHERE

-- In the WHERE clause, you specify a predicate or logical expression to filter the rows returned by the FROM phase.
-- Only rows for which the logical expression evaluates to TRUE are returned by the WHERE phase to the subsequent logical query processing phase.

-- The WHERE phase returns rows for which the logical expression evaluates to TRUE, 
-- and it doesn’t return rows for which the logical expression evaluates to FALSE or UNKNOWN.
---------------------------------------------------------------------

USE TSQLV4

SELECT *
FROM Sales.Orders                   
WHERE custid = 71                   
