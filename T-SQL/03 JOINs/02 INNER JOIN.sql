
---------------------------------------------------------------------
-- INNER JOIN

-- An inner join applies two logical query processing phases

-- 1. Apply Cartesian Product - m*n ROWS
-- 2. Apply ON Predicate      - Only rows where ON Predicate is TRUE are returned; it does not return rows for which the predicate evaluates to FALSE or UNKNOWN

-- Note: 1. ON Predicate serves as a matching purpose
--       2. WHERE serves as filtering purpose
--       2. For INNER JOIN there is no logical difference between ON and WHERE clauses
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Customers             --91
SELECT DISTINCT custid FROM Sales.Orders  --89

--Following quey retuns customers and their orders, since its a inner join, the query does not returns customers who did not place any orders
SELECT DISTINCT C.custid, O.custid
FROM Sales.Customers C
INNER JOIN Sales.Orders O ON O.custid = C.custid
--89

---------------------------------------------------------------------

SELECT * FROM dbo.Customers
SELECT * FROM dbo.Orders

SELECT * 
FROM dbo.Customers C
INNER JOIN dbo.Orders O ON O.CustID = C.CustID

SELECT * 
FROM dbo.Customers C
INNER JOIN dbo.Orders O ON O.CustID = C.CustID
WHERE C.City = 'Madrid'

SELECT * 
FROM dbo.Customers C
INNER JOIN dbo.Orders O ON O.CustID = C.CustID AND C.City = 'Madrid'

