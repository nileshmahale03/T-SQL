
---------------------------------------------------------------------
-- UNION (DISTINCT)

-- The UNION (implicit DISTINCT) operator unifies the results of the two queries and eliminates duplicates.
-- Note that if a row appears in both input sets, it will appear only once in the result; in other words, the result is a set and not a multiset.

-- If duplicates are possible in the unified result and you do not need to return them, use UNION.

-- If duplicates cannot exist when unifying the inputs, UNION and UNION ALL will return the same result. However, in such a case I recommend you use UNION ALL
-- so that you don’t pay the unnecessary performance penalty related to checking for duplicates.

-- The order in which you specify the two input queries dosen't matters.
---------------------------------------------------------------------

USE TSQLV4

SELECT * FROM HR.Employees
SELECT * FROM Sales.Customers

SELECT country, region, city FROM HR.Employees
UNION 
SELECT country, region, city FROM Sales.Customers


SELECT country, region, city FROM HR.Employees
UNION 
SELECT country, region, city FROM Sales.Customers
ORDER BY country, region, city
