
---------------------------------------------------------------------
-- Common Table Expressions (CTEs)

-- The benefits of using table expressions are typically related to logical aspects of your code and not to performance.
-- Table expressions also help you circumvent certain restrictions in the language

-- Rule 1: Order is not guaranteed
-- Rule 2: All columns must have names
-- Rule 3: All column names must be unique

-- CTEs           : Single-statement scope, not reusable
--                : Assigning column aliases
--                : Using arguments e.g. variables
--                : Defining multiple CTEs
--						The fact that you first name and define a CTE and then use it gives it several important advantages over derived tables. 
--	                    One advantage is that if you need to refer to one CTE from another, you don’t nest them; rather, you separate them by commas.
--                : Multiple references  
--                      The fact that a CTE is named and defined first and then queried has another advantage: 
--                      as far as the FROM clause of the outer query is concerned, the CTE already exists; 
--                      therefore, you can refer to multiple instances of the same CTE in table operators like joins.

-- The WITH clause is used in T-SQL for several purposes. For example, it’s used to defin a table hint in a query to force a certain optimization option or isolation level.
-- To avoid ambiguity, when the WITH clause is used to define a CTE, the preceding statement in the same batch—if one exists—must be terminated with a semicolon.
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM Sales.Customers 

SELECT * FROM Sales.Orders

---------------------------------------------------------------------
-- Query: write a query against the Sales.Orders table and return the number of distinct customers handled in each order year.

---------------------------------------------------------------------
; WITH CTE AS (
	SELECT custid, YEAR(orderdate) 'OrderYear'
	FROM Sales.Orders
)
SELECT OrderYear, COUNT(DISTINCT custid) 'NoOfCust'
FROM CTE
GROUP BY OrderYear

---------------------------------------------------------------------
-- Query: order years and the number of customers handled in each year only for years in which more than 70 customers were handled.

---------------------------------------------------------------------
; WITH CTE1 AS (
	SELECT custid, YEAR(orderdate) 'OrderYear'
	FROM Sales.Orders
), CTE2 AS (
	SELECT OrderYear, COUNT(DISTINCT custid) 'NoOfCust'
	FROM CTE1
	GROUP BY OrderYear
)
SELECT * 
FROM CTE2
WHERE NoOfCust > 70

---------------------------------------------------------------------
-- Query: Multiple references

---------------------------------------------------------------------
; WITH CTE AS (
SELECT YEAR(orderdate) 'OrderYear'
     , COUNT(DISTINCT custid) 'NoOfCust'
FROM Sales.Orders
GROUP BY YEAR(orderdate)
)
SELECT * 
FROM CTE C1
LEFT OUTER JOIN CTE C2 ON C2.OrderYear < C1.OrderYear