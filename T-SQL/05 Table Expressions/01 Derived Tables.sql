
---------------------------------------------------------------------
-- Derived Tables (Table subqueries)

-- Derived tables (also known as table subqueries) are defined in the FROM clause of an outer query.
-- You specify the query that defines the derived table within parentheses, followed by the AS clause and the derived table name.
-- The benefits of using table expressions are typically related to logical aspects of your code and not to performance.
-- Table expressions also help you circumvent certain restrictions in the language

-- Rule 1: Order is not guaranteed
-- Rule 2: All columns must have names
-- Rule 3: All column names must be unique

-- Derived Tables : Single-statement scope, not reusable
--                : Assigning column aliases
--                : Using arguments e.g. variables
--                : Nesting
--	                    If you need to define a derived table based on a query that itself is based on a derived table, you can nest those.
--	                    Nesting tends to complicate the code and reduces its readability.
--                : Multiple references
--                      The fact that you cannot refer to multiple instances of the same derived table in the same join forces
--                      you to maintain multiple copies of the same query definition. This leads to lengthy code that is hard to
--                      maintain and prone to errors.
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Customers 

SELECT * FROM Sales.Orders

---------------------------------------------------------------------
-- Query: query that returns all customers from the United States

---------------------------------------------------------------------
SELECT * 
FROM (
	SELECT custid, companyname 
	FROM Sales.Customers 
	WHERE country = 'USA'
) D

---------------------------------------------------------------------
-- Query: write a query against the Sales.Orders table and return the number of distinct customers handled in each order year.

---------------------------------------------------------------------
SELECT YEAR(orderdate) 'OrderYear'
     , COUNT(DISTINCT custid)
FROM Sales.Orders
GROUP BY OrderYear

SELECT YEAR(orderdate) 'OrderYear'
     , COUNT(DISTINCT custid) 'NoOfCust'
FROM Sales.Orders
GROUP BY YEAR(orderdate)

SELECT D.OrderYear
     , COUNT(DISTINCT D.custid) 'NoOfCust'
FROM (
	SELECT custid, YEAR(orderdate) 'OrderYear'
	FROM Sales.Orders
) D
GROUP BY D.OrderYear

---------------------------------------------------------------------
-- Query: order years and the number of customers handled in each year only for years in which more than 70 customers were handled.

---------------------------------------------------------------------
SELECT D2.OrderYear
     , D2.NoOfCust
FROM (
	SELECT D.OrderYear
		 , COUNT(DISTINCT D.custid) 'NoOfCust'
	FROM (
		SELECT custid, YEAR(orderdate) 'OrderYear'
		FROM Sales.Orders
	) D
	GROUP BY D.OrderYear
) D2
WHERE NoOfCust > 70
