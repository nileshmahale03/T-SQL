
---------------------------------------------------------------------
-- EXISTS

-- T-SQL supports a predicate EXISTS, that accepts a subquery as input and returns TRUE if the subquery returns any rows and FALSE otherwise. 
-- IT dosen't returns UNKNOWN

-- IN uses, 3 valued predicate logic 
-- EXISTS uses, 2 valued predicate logic

-- Even though in most cases the use of star (*) is considered a bad practice, with EXISTS it isn’t.

-- When you use the NOT IN predicate against a subquery that returns at least one NULL, the query always returns an empty set.
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Orders WHERE orderid = 10248

SELECT * FROM HR.Employees WHERE empid = 5

SELECT * FROM Sales.Customers WHERE custid = 85

---------------------------------------------------------------------
-- Query: Return orders placed by employees whose last name starts with the letter D
---------------------------------------------------------------------

--1. Using IN
SELECT *
FROM Sales.Orders
WHERE empid IN (
	SELECT empid
	FROM HR.Employees
	WHERE lastname LIKE 'D%'
)

--2. Using EXISTS
SELECT *
FROM Sales.Orders O
WHERE EXISTS (
	SELECT *
	FROM HR.Employees E
	WHERE E.empid = O.empid AND E.lastname LIKE 'D%'
)

---------------------------------------------------------------------
-- Query: Return customers from spain who placed orders
---------------------------------------------------------------------
--1. Using IN
SELECT *
FROM Sales.Customers C
WHERE country = 'Spain' AND custid IN (
	SELECT custid
	FROM Sales.Orders O 
	WHERE O.custid = C.custid
)

--2. Using EXISTS
SELECT *
FROM Sales.Customers C
WHERE country = 'Spain' AND EXISTS (
	SELECT *
	FROM Sales.Orders O 
	WHERE O.custid = C.custid
)

---------------------------------------------------------------------
-- Query: Return customers from spain who DID NOT placed orders
---------------------------------------------------------------------
--1. Using IN
SELECT *
FROM Sales.Customers C
WHERE country = 'Spain' AND custid NOT IN (
	SELECT custid
	FROM Sales.Orders O 
	WHERE O.custid = C.custid
)

--2. Using EXISTS
SELECT *
FROM Sales.Customers C
WHERE country = 'Spain' AND NOT EXISTS (
	SELECT *
	FROM Sales.Orders O 
	WHERE O.custid = C.custid
)

---------------------------------------------------------------------
-- Query: Write a query that returns customers who did not put any orders

---------------------------------------------------------------------
SELECT * FROM Sales.Customers --91

SELECT * FROM Sales.Orders --89

SELECT DISTINCT custid FROM Sales.Orders --89

--1
SELECT *
FROM Sales.Customers 
WHERE custid NOT IN (
	SELECT custid 
	FROM Sales.Orders 
)

--2
SELECT C.*
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON C.custid = O.custid
WHERE O.orderid IS NULL

INSERT INTO Sales.Orders(custid, empid, orderdate, requireddate, shippeddate, shipperid, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry)
VALUES(NULL, 5, '20140704', '20140801', '20140716', 3, 32.38, N'Ship to 85-B', N'6789 rue de l''Abbaye', N'Reims', NULL, N'10345', N'France');

--1
SELECT *
FROM Sales.Customers 
WHERE custid NOT IN (
	SELECT custid 
	FROM Sales.Orders 
)

--2
SELECT C.*
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON C.custid = O.custid
WHERE O.orderid IS NULL

--3
SELECT *
FROM Sales.Customers 
WHERE custid NOT IN (
	SELECT custid 
	FROM Sales.Orders 
	WHERE custid IS NOT NULL
)

--4
SELECT *
FROM Sales.Customers C
WHERE NOT EXISTS (
	SELECT * 
	FROM Sales.Orders O
	WHERE O.custid = C.custid
)

DELETE FROM Sales.Orders WHERE custid IS NULL