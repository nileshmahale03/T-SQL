
---------------------------------------------------------------------
-- EXCEPT (DISTINCT)

-- The EXCEPT operator (implied DISTINCT) returns only distinct rows that appear in the first set but not the second.-- Note that unlike UNION and INTERSECT, EXCEPT is noncummutative; that is, the order in which you specify the two input queries matters.

--
---------------------------------------------------------------------

USE TSQLV4

SELECT * FROM HR.Employees
SELECT * FROM Sales.Customers

SELECT country, region, city FROM HR.Employees
EXCEPT
SELECT country, region, city FROM Sales.Customers

SELECT country, region, city FROM Sales.Customers
EXCEPT
SELECT country, region, city FROM HR.Employees

-- Alternatives

-- OUTER JOIN

-- NOT EXISTS

---------------------------------------------------------------------
-- EXCEPT ALL

-- The EXCEPT ALL operator is similar to the EXCEPT operator, but it also takes into account the number of occurrences of each row. 
-- If a row R appears x times in the first multiset and y times in the second, and x > y, R will appear x – y times in Query1 EXCEPT ALL Query2. 
-- In other words, EXCEPT ALL returns only occurrences of a row from the first multiset that do not have a corresponding occurrence in the second.

---------------------------------------------------------------------

; WITH CTE_EXCEPTALL AS (
SELECT country, region, city
     , ROW_NUMBER() OVER(PARTITION BY country, region, city ORDER BY country) 'rownum'
FROM HR.Employees
EXCEPT
SELECT country, region, city 
     , ROW_NUMBER() OVER(PARTITION BY country, region, city ORDER BY country) 'rownum'
FROM Sales.Customers
)

SELECT country, region, city
FROM CTE_EXCEPTALL

