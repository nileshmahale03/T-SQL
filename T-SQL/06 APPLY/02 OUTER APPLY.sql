
---------------------------------------------------------------------
-- OUTER APPLY

-- 1. Apply right Table Expression to Left Table Rows
-- 2. Add OUTER Rows
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM dbo.Customers
SELECT * FROM dbo.Orders

--In this case OUTER APPLY and CROSS JOIN are similar
SELECT * 
FROM dbo.Customers
OUTER APPLY dbo.Orders

--In this case OUTER APPLY and LEFT JOIN are similar
SELECT * 
FROM dbo.Customers C
OUTER APPLY (
	SELECT O.OrderID 
	FROM Orders O
	where O.CustID = C.CustID
) A

--Problem 2: Two most recent orders for each customer,
--           including customers that made no orders
SELECT * 
FROM dbo.Customers C
OUTER APPLY (
	SELECT TOP(2) O.OrderID 
	FROM Orders O
	where O.CustID = C.CustID
	ORDER BY O.OrderID
) A