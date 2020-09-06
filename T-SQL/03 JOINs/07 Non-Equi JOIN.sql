
---------------------------------------------------------------------
-- Non-equi JOIN

-- When a join condition involves any operator besides equality, the join is said to be non-equi join
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Query: Write a query to produce unique pairs of employees
-- Had a cross join been used, the result would have included self pairs (e.g. 1 with 1) and also mirrored pairs (e.g. 1 with 2 & 2 with 1) 

-- formula: n(n-1)/2
---------------------------------------------------------------------
USE TSQLV4

SELECT * FROM HR.Employees

SELECT * 
FROM HR.Employees E1
INNER JOIN HR.Employees E2 ON E2.empid > E1.empid
ORDER BY E1.empid