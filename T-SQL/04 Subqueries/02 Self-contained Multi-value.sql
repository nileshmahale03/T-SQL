
---------------------------------------------------------------------
-- Self-conatined Multi-value subqueries

-- Self-conatined subqueries are subqueries that are independent of the tables in the outer query. 
-- Self-conatined subqueries are convenient to debug, because you can always highlight the inner query, run it, and ensure that it does what it's supposed to do.

-- Self-conatined Multi-value subquery (IN)
-- Self-conatined Multi-value subquery returns multiple value and it can appear on WHERE 
-- Scalar value uses =, MultiValue uses IN
-- As with any other predicate, you can negate the IN predicate with the NOT operator.
-- It is recommended to not to use NOT IN, instead use NOT EXISTS

-- IN JOIN, columns from 2nd tables are available to you in select list wheras in subquery they're not
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Orders WHERE orderid = 10248

SELECT * FROM HR.Employees WHERE empid = 5

SELECT * FROM Sales.Customers WHERE custid = 85

---------------------------------------------------------------------
-- Query: Return orders placed by employees whose last name starts with the letter D

---------------------------------------------------------------------

SET STATISTICS IO ON
SET STATISTICS TIME ON

SELECT * FROM Sales.Orders WHERE orderid = 10248 

SELECT * FROM HR.Employees WHERE empid = 5

--1. Using variable to store temporary resulset
DECLARE @empid TABLE (
	empid INT
)

INSERT INTO @empid(empid)
SELECT empid 
FROM HR.Employees
WHERE lastname LIKE 'D%'

--SELECT * FROM @empid

SELECT *
FROM Sales.Orders 
WHERE empid IN (
	SELECT empid
	FROM @empid
)

--2. Using JOIN
SELECT O.*, E.lastname
FROM Sales.Orders O
JOIN HR.Employees E ON E.empid = O.empid
WHERE E.lastname LIKE 'D%'

--2. Using Self-conatained scalar subquery
SELECT *
FROM Sales.Orders
WHERE empid IN (
	SELECT empid
	FROM HR.Employees
	WHERE lastname LIKE 'D%'
)

---------------------------------------------------------------------
-- Query: Write a query that returns orders placed by customers from a USA

---------------------------------------------------------------------
SELECT * 
FROM Sales.Orders
WHERE custid IN (
	SELECT custid 
	FROM Sales.Customers
	WHERE country = 'USA'
)

---------------------------------------------------------------------
-- Query: Write a query that returns customers who did not put any orders

---------------------------------------------------------------------
SELECT * FROM Sales.Customers --91

SELECT DISTINCT custid FROM Sales.Orders --89

--1
SELECT *
FROM Sales.Customers 
WHERE custid NOT IN (
	SELECT custid         --No need to mention DISTINCT, database engine is smart enough to do it
	FROM Sales.Orders 
)

--2
SELECT C.*
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON C.custid = O.custid
WHERE O.orderid IS NULL

---------------------------------------------------------------------
-- Query: Exmaple showing we can not use multi-value subquery in SELECT clause

---------------------------------------------------------------------

SELECT orderid
     , custid
	 , empid
	 , orderdate
	 , (SELECT custid FROM Sales.Customers WHERE country = 'USA') 'USACustID'
FROM Sales.Orders