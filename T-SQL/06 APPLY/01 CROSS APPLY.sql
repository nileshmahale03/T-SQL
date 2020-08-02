
---------------------------------------------------------------------
-- CROSS APPLY

-- 1. Apply right Table Expression to Left Table Rows

---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM dbo.Customers
SELECT * FROM dbo.Orders

--In this case CROSS APPLY and CROSS JOIN are similar
SELECT * 
FROM dbo.Customers
CROSS APPLY dbo.Orders

--In this case CROSS APPLY and INNER JOIN are similar
SELECT * 
FROM dbo.Customers C
CROSS APPLY (
	SELECT O.OrderID 
	FROM Orders O
	where O.CustID = C.CustID  --As soon as you start refering elements from other side it can not be JOIN, it has to be APPLY
) A

--Problem 1: Two most recent orders for each customer
SELECT * 
FROM dbo.Customers C
CROSS APPLY (
	SELECT TOP(2) O.OrderID 
	FROM Orders O
	where O.CustID = C.CustID
	ORDER BY O.OrderID DESC
) A
