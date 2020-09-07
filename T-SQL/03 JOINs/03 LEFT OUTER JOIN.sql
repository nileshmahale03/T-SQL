
---------------------------------------------------------------------
-- LEFT OUTER JOIN

-- 1. Apply Cartesian Product - m*n ROWS
-- 2. Apply ON Predicate      - Only rows where ON Predicate is TRUE are returned
-- 3. Add OUTER Rows          - Preserve LEFT side Table

-- Note: 1. ON Predicate serves as a matching purpose, non final
--       2. WHERE Predicate serves as filtering purpose, final
--       2. For OUTER JOIN there is logical difference between ON and WHERE clauses

-- You can use outer joins to identify and include missing values when querying data.
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Customers             --91
SELECT DISTINCT custid FROM Sales.Orders  --89

--Following quey retuns customers and their orders, since its a left join, the query also returns customers who did not place any orders
SELECT C.custid, O.custid
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON O.custid = C.custid
--91

--Following quey retuns customers who did not place any orders
SELECT DISTINCT C.custid, O.custid
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON O.custid = C.custid
WHERE O.custid IS NULL

SELECT C.custid
     , COUNT(*)
	 , COUNT(O.orderid)
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON O.custid = C.custid
GROUP BY C.custid
---------------------------------------------------------------------
--Query: you need to query all orders from the Orders table in the TSQLV4 database. You need to ensure that you get at least one row in the output for each date in the range January 1, 2014 through
--       December 31, 2016. 
--       You don’t want to do anything special with dates within the range that have orders, but you do want the output to include the dates with no orders, with NULLs as placeholders in the
--       attributes of the order.
---------------------------------------------------------------------
;WITH CTE AS(
	SELECT n
		 , DATEADD(DAY, n-1, '2014-01-01') 'orderdate'
	FROM dbo.Nums
	WHERE DATEADD(DAY, n-1, '2014-01-01') <= '2016-12-31'
)
SELECT *
FROM CTE C
LEFT JOIN Sales.Orders O ON O.orderdate = CAST(C.orderdate AS DATE)
ORDER BY C.orderdate
---------------------------------------------------------------------

USE TSQLV4

SELECT * FROM dbo.Customers
SELECT * FROM dbo.Orders

SELECT * 
FROM dbo.Customers C
LEFT JOIN dbo.Orders O ON O.CustID = C.CustID

SELECT * 
FROM dbo.Customers C
LEFT JOIN dbo.Orders O ON O.CustID = C.CustID
WHERE C.City = 'Madrid'

SELECT * 
FROM dbo.Customers C
LEFT JOIN dbo.Orders O ON O.CustID = C.CustID AND C.City = 'Madrid'