
---------------------------------------------------------------------
-- UNION ALL

-- The UNION ALL operator unifies the two input query results without attempting to remove duplicates from the result.-- Assuming that Query1 returns m rows and Query2 returns n rows, Query1 UNION ALL Query2 returns m + n rows.

-- Because UNION ALL doesn’t eliminate duplicates, the result is a multiset and not a set

-- The order in which you specify the two input queries dosen't matters.
---------------------------------------------------------------------

USE TSQLV4

SELECT * FROM HR.Employees
SELECT * FROM Sales.Customers

SELECT country, region, city FROM HR.Employees
UNION ALL
SELECT country, region, city FROM Sales.Customers


SELECT country, region, city FROM HR.Employees
UNION ALL
SELECT country, region, city FROM Sales.Customers
ORDER BY country, region, city