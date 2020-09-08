
---------------------------------------------------------------------
-- OUTER APPLY

-- 1. Apply right Table Expression to Left Table Rows
-- 2. Add OUTER Rows
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Customers --91
SELECT * FROM Sales.Orders    --830

--In this case OUTER APPLY and CROSS JOIN are similar
SELECT * 
FROM Sales.Customers
OUTER APPLY Sales.Orders

--In this case OUTER APPLY and LEFT JOIN are similar
SELECT * 
FROM Sales.Customers C
OUTER APPLY (
	SELECT O.orderid 
	FROM Sales.Orders O
	where O.custid = C.custid
) A

---------------------------------------------------------------------
-- Query: Three most recent orders for each customer, including customers that made no orders

---------------------------------------------------------------------
SELECT * 
FROM Sales.Customers C
OUTER APPLY (
	SELECT TOP(3) O.orderid 
	FROM Sales.Orders O
	where O.custid = C.custid
	ORDER BY O.orderdate DESC, O.orderid DESC
) A

SELECT * 
FROM Sales.Customers C
OUTER APPLY (
	SELECT O.orderid 
	FROM Sales.Orders O
	where O.custid = C.custid
	ORDER BY O.orderdate DESC, O.orderid DESC
	OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) A

---------------------------------------------------------------------
-- Query: more convenient to work with inline TVFs instead of derived tables.

---------------------------------------------------------------------
DROP FUNCTION IF EXISTS dbo.fnGetTopOrders
GO

CREATE FUNCTION dbo.fnGetTopOrders
(@custid INT)
RETURNS TABLE
AS
RETURN

SELECT *
FROM Sales.Orders
WHERE custid = @custid
ORDER BY orderdate DESC, orderid DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY

GO

SELECT *
FROM dbo.fnGetTopOrders(1)

SELECT * 
FROM Sales.Customers C
OUTER APPLY (
	SELECT * 
	FROM dbo.fnGetTopOrders(C.custid)
) A