
---------------------------------------------------------------------
-- CROSS APPLY

-- 1. Apply right Table Expression to Left Table Rows

---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Customers --92
SELECT * FROM Sales.Orders    --830

--In this case CROSS APPLY and CROSS JOIN are similar
SELECT * 
FROM Sales.Customers
CROSS APPLY Sales.Orders

--In this case CROSS APPLY and INNER JOIN are similar
SELECT * 
FROM Sales.Customers C
CROSS APPLY (
	SELECT O.orderid 
	FROM Sales.Orders O
	where O.custid = C.custid  --As soon as you start refering elements from other side it can not be JOIN, it has to be APPLY
) A

---------------------------------------------------------------------
-- Query: three most recent orders for each customer

---------------------------------------------------------------------
SELECT * 
FROM Sales.Customers C
CROSS APPLY (
	SELECT TOP(3) O.orderid 
	FROM Sales.Orders O
	where O.custid = C.custid
	ORDER BY O.orderdate DESC, O.orderid DESC
) A

SELECT * 
FROM Sales.Customers C
CROSS APPLY (
	SELECT O.orderid 
	FROM Sales.Orders O
	where O.custid = C.custid
	ORDER BY O.orderdate DESC, O.orderid DESC
	OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) A
