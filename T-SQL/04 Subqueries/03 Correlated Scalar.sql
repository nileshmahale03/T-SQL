
---------------------------------------------------------------------
-- Correlated subqueries

-- Correlated subqueries refer to attributes from the tables that appear in the outer query.  
-- Correlated subqueries are dependent on the outer query and can not be invoked independently.
-- Logically, the subquery is evaluated seperately for each outer row. 
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Orders ORDER BY custid

SELECT * FROM Sales.Customers WHERE custid = 85

---------------------------------------------------------------------
-- Query: Write a query that returns orders with a maximum order ID for each customer

---------------------------------------------------------------------

--1. Using Window Functions
;WITH CTE AS(
	SELECT *
		 , ROW_NUMBER() OVER(PARTITION BY custid ORDER BY orderid DESC) 'ROWNUM'
	FROM Sales.Orders
)
SELECT *
FROM CTE
WHERE ROWNUM = 1
ORDER BY custid

--2. Using Temporary Resultset and JOIN
DROP TABLE IF EXISTS #TMP
SELECT custid, MAX(orderid) 'MAXorderid'
INTO #TMP
FROM Sales.Orders
GROUP BY custid

--SELECT * FROM #TMP

SELECT O.*
FROM Sales.Orders O
JOIN #TMP T on T.custid = O.custid AND T.MAXorderid = O.orderid
ORDER BY O.custid

--3. Using Correlated scalar subqueries
SELECT *
FROM Sales.Orders O1
WHERE orderid = (
	SELECT MAX(orderid)
	FROM Sales.Orders O2
	WHERE O2.custid = O1.custid
)
ORDER BY O1.custid

---------------------------------------------------------------------
-- Query: Write a query that queries Sales.OrderValues view and return for each order the percentage of the current order value out of the customer total.

---------------------------------------------------------------------

SELECT * FROM Sales.OrderValues ORDER BY custid

--1. Using Window Functions
;WITH CTECustomerTotal AS (
	SELECT * 
		 , SUM(val) OVER(PARTITION BY custid) 'CustomerTotal'
	FROM Sales.OrderValues
)
SELECT *
     , CAST(val*100/CustomerTotal AS NUMERIC(5,2)) 'PCTOrderValue'
FROM CTECustomerTotal 

--2. Using Temporary Resultset and JOIN
DROP TABLE IF EXISTS #TMPCustomerTotal
SELECT custid 
     , SUM(val) 'CustomerTotal'
INTO #TMPCustomerTotal
FROM Sales.OrderValues
GROUP BY custid

--SELECT * FROM #TMPCustomerTotal

SELECT *
     , CAST(O.val*100/T.CustomerTotal AS NUMERIC(5,2)) 'PCTOrderValue'
FROM Sales.OrderValues O
JOIN #TMPCustomerTotal T ON T.custid = O.custid
ORDER BY O.custid, o.orderid

--3. Using Correlated scalar subqueries
SELECT *
     , (SELECT SUM(val) FROM Sales.OrderValues O2 WHERE O2.custid = o1.custid) 'CustomerTotal'
	 , CAST(val*100/(SELECT SUM(val) FROM Sales.OrderValues O2 WHERE O2.custid = o1.custid) AS NUMERIC(5,2)) 'PCTOrderValue'
FROM Sales.OrderValues O1
ORDER BY O1.custid