
---------------------------------------------------------------------
-- Circumventing unsupported logical phases

-- 1. ORDER BY is not allowed in individual query 
-- 2. ONLY ORDER BY is allowed on the result of the operators

-- Circumvent this using table expressions

---------------------------------------------------------------------

---------------------------------------------------------------------
-- 1. How to use ORDER BY in UNION query 
---------------------------------------------------------------------
USE TSQLV4
GO

SELECT TOP (2) empid, orderid, orderdate
FROM Sales.Orders
WHERE empid = 3
ORDER BY orderdate DESC, orderid DESC

UNION ALL

SELECT TOP (2) empid, orderid, orderdate
FROM Sales.Orders
WHERE empid = 5
ORDER BY orderdate DESC, orderid DESC

SELECT empid, orderid, orderdate
FROM (
	SELECT TOP (2) empid, orderid, orderdate
	FROM Sales.Orders
	WHERE empid = 3
	ORDER BY orderdate DESC, orderid DESC
) D1
UNION ALL
SELECT empid, orderid, orderdate
FROM (
	SELECT TOP (2) empid, orderid, orderdate
	FROM Sales.Orders
	WHERE empid = 5
	ORDER BY orderdate DESC, orderid DESC
) D2

---------------------------------------------------------------------
-- 2. How to use GROUP BY on the resultset of the UNION query
---------------------------------------------------------------------

SELECT country, region, city FROM HR.Employees
UNION 
SELECT country, region, city FROM Sales.Customers
GROUP BY country


SELECT country, COUNT(*) 'NumOfLoc'
FROM (
	SELECT country, region, city FROM HR.Employees
	UNION 
	SELECT country, region, city FROM Sales.Customers
) D1
GROUP BY country