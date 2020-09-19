
---------------------------------------------------------------------
-- INTERSECT (DISTINCT)

-- The INTERSECT operator returns only the rows that are common to the results of the two input queries.-- As long as a row appears at least once in both query results, it’s returned only once in the operator’s result.

-- It returns a TRUE when comparing two NULLs

-- The order in which you specify the two input queries dosen't matters.

---------------------------------------------------------------------

USE TSQLV4

SELECT * FROM HR.Employees
SELECT * FROM Sales.Customers

SELECT country, region, city FROM HR.Employees
INTERSECT
SELECT country, region, city FROM Sales.Customers

-- Need special treatment for NULL if using INNER JOIN instead
SELECT DISTINCT E.country, E.region, E.city
FROM HR.Employees E
INNER JOIN Sales.Customers C ON C.country = E.country AND (C.region = E.region OR (C.region IS NULL AND E.region IS NULL)) AND C.city = E.city


---------------------------------------------------------------------
-- INTERSECT ALL

-- INTERSECT ALL returns the number of duplicate rows matching the lower of the counts in both input multisets.
---------------------------------------------------------------------

; WITH CTE_INTERSECTALL AS (
SELECT country, region, city
     , ROW_NUMBER() OVER(PARTITION BY country, region, city ORDER BY country) 'rownum'
FROM HR.Employees
INTERSECT
SELECT country, region, city 
     , ROW_NUMBER() OVER(PARTITION BY country, region, city ORDER BY country) 'rownum'
FROM Sales.Customers
)

SELECT country, region, city
FROM CTE_INTERSECTALL

