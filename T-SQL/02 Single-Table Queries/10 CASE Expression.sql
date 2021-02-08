---------------------------------------------------------------------
-- CASE expression

-- A CASE expression is a scalar expression that returns a value based on conditional logic.
-- Because CASE is a scalar expression, it is allowed wherever scalar expressions are allowed, such as in the SELECT, WHERE,
-- HAVING, and ORDER BY clauses and in CHECK constraints.

--1.Simple  : The simple CASE form has a single test value or expression right after the CASE keyword that is
--            compared with a list of possible values in the WHEN clauses
--2.Searched: The searched CASE expression returns the value in the THEN clause that is associated with
--            the first WHEN predicate that evaluates to TRUE.

-- abbreviations of the CASE expression: ISNULL, COALESCE, IIF, and CHOOSE.
---------------------------------------------------------------------
USE TSQLV4
GO

--Simple
SELECT custid
     , contactname
	 , country
	 , CASE country WHEN 'USA' THEN 1
	                WHEN 'UK'  THEN 2
					ELSE 3
       END 'CountryCode'
FROM Sales.Customers


--Searched

SELECT orderid
     , custid
	 , val
	 , CASE
	   WHEN val < 1000.00                   THEN 'Less than 1000'
	   WHEN val BETWEEN 1000.00 AND 3000.00 THEN 'Between 1000 and 3000'
	   WHEN val > 3000.00                   THEN 'More than 3000'
	   ELSE 'Unknown' END 'valuecategory'
FROM Sales.OrderValues;