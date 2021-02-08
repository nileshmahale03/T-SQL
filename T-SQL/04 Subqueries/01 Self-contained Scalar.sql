
---------------------------------------------------------------------
-- Self-conatined subqueries

-- Self-conatined subqueries are subqueries that are independent of the tables in the outer query. 
-- Self-conatined subqueries are convenient to debug, because you can always highlight the inner query, run it, and ensure that it does what it's supposed to do.

-- Self-conatined scalar subquery (=)
-- Self-conatined scalar subquery returns single value and it can appear on WHERE or SELECT
-- Scalar value =, MultiValue IN

-- IN JOIN, columns from 2nd tables are available to you in select list wheras in subquery they're not
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Orders WHERE orderid = 10248

SELECT * FROM HR.Employees WHERE empid = 5

---------------------------------------------------------------------
-- Query: Query the Orders table and return information about the order that has the maximum orderid in the table

---------------------------------------------------------------------
--1. 
SELECT TOP(1) * 
FROM Sales.Orders
ORDER BY orderid DESC

--2. Using variable to store temporary resulset
DECLARE @maxorderid INT

SELECT @maxorderid = MAX(orderid) 
FROM Sales.Orders

--SELECT @maxorderid

SELECT * 
FROM Sales.Orders
WHERE orderid = @maxorderid

--3. Using Self-conatained scalar subquery
SELECT * 
FROM Sales.Orders
WHERE orderid = (
	SELECT MAX(orderid)
	FROM Sales.Orders
)

---------------------------------------------------------------------
-- Query: Return orders placed by employees whose last name starts with the letter C

---------------------------------------------------------------------

SET STATISTICS IO OFF
SET STATISTICS TIME OFF

SELECT * FROM Sales.Orders WHERE orderid = 10248 

SELECT * FROM HR.Employees WHERE empid = 5

--1. Using variable to store temporary resulset
DECLARE @empid INT

SELECT @empid = empid 
FROM HR.Employees
WHERE lastname LIKE 'C%'

SELECT *
FROM Sales.Orders 
WHERE empid = @empid

--2. Using JOIN
SELECT O.*, E.lastname
FROM Sales.Orders O
JOIN HR.Employees E ON E.empid = O.empid
WHERE E.lastname LIKE 'C%'

--2. Using Self-conatained scalar subquery
SELECT *
FROM Sales.Orders
WHERE empid = (
	SELECT empid
	FROM HR.Employees
	WHERE lastname LIKE 'C%'
)

---------------------------------------------------------------------
-- Query: Exmaple showing we can use scalar value subquery in SELECT as well

---------------------------------------------------------------------

SELECT orderid
     , custid
	 , empid
	 , orderdate
	 , (SELECT MAX(orderid) FROM Sales.Orders) 'MAXOrderID'
FROM Sales.Orders

---------------------------------------------------------------------
-- Things to remember: 
-- 1. If a scalar subquery returns more than 1 value then query will fail
-- 2. If a scalar subquery returns no value, the query returns an empty set
---------------------------------------------------------------------

--1. Subquery returned more than 1 value. This is not permitted when the subquery 
--   follows =, !=, <, <= , >, >= or when the subquery is used as an expression.
SELECT *
FROM Sales.Orders
WHERE empid = (
	SELECT empid
	FROM HR.Employees
	WHERE lastname LIKE 'D%'
)
--Subquery returned more than 1 value. This is not permitted when the subquery follows =, !=, <, <= , >, >= or when the subquery is used as an expression.

--2. 
SELECT *
FROM Sales.Orders
WHERE empid = (
	SELECT empid
	FROM HR.Employees
	WHERE lastname LIKE 'A%'
)