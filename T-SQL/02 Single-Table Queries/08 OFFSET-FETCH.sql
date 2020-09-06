---------------------------------------------------------------------
-- OFFSET-FETCH

-- T-SQL also supports a standard, TOP-like filter, called OFFSET-FETCH
-- The OFFSET-FETCH filter is considered an extension to the ORDER BY clause
-- Note that a query that uses OFFSET-FETCH must have an ORDER BY clause

-- T-SQL doesn’t support the FETCH clause without the OFFSET clause.
-- However, OFFSET without FETCH is allowed.
---------------------------------------------------------------------
USE TSQLV4

SELECT orderid
     , orderdate
	 , custid
	 , empid
FROM Sales.Orders
ORDER BY orderid
OFFSET 50 ROWS FETCH NEXT 20 ROWS ONLY;

SELECT orderid
     , orderdate
	 , custid
	 , empid
FROM Sales.Orders
ORDER BY orderid
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY;

SELECT orderid
     , orderdate
	 , custid
	 , empid
FROM Sales.Orders
ORDER BY orderid
OFFSET 0 ROWS;