---------------------------------------------------------------------
-- Logical query-processing phases
---------------------------------------------------------------------

(5)SELECT
	(5-1)<select_list>
	(5-2)DISTINCT
	(7)TOP
(1)FROM
	(1-J)<left_table> JOIN  (CROSS(1-J1), INNER(1-J2), LEFT OUTER(1-J3), RIGHT OUTER(1-J3), FULL OUTER(1-J3))
		(1-J1) Cartesian Product (1-J2) ON Predicate (1-J3) Add Outer ROWS
	(1-A)<left_table> APPLY (CROSS(1-A1), OUTER(1-A2))
		(1-A1) Apply Table Expression (1-A2) Add Outer Rows
	(1-P)<left_table> PIVOT
		(1-P1) Group (1-P2) Spread (1-P3) Aggregate
	(1-U)<left_table> UNPIVOT
		(1-U1) Generate Copies (1-U2) Extract Element (1-U3) Remove NULLs
(2)WHERE
(3)GROUP BY
(4)HAVING
(6)ORDER BY
(7)OFFSET _ ROWS FETCH NEXT _ ROWS ONLY

---------------------------------------------------------------------
-- Sample Query
---------------------------------------------------------------------

USE TSQLV4

SELECT empid                        --5
     , YEAR(orderdate) 'OrderYear'
	 , COUNT(*) 'NumOfOrders'
FROM Sales.Orders                   --1
WHERE custid = 71                   --2
GROUP BY empid, YEAR(orderdate)     --3
HAVING COUNT(*) > 1                 --4
ORDER BY empid, OrderYear;          --6

---------------------------------------------------------------------
-- NULLs
---------------------------------------------------------------------
SELECT custid, country, region, city
FROM Sales.Customers;
--91

SELECT custid, country, region, city
FROM Sales.Customers
WHERE region = 'WA';
--3

SELECT custid, country, region, city
FROM Sales.Customers
WHERE region != 'WA';
--28

SELECT custid, country, region, city
FROM Sales.Customers
WHERE region != 'WA' OR region IS NULL;
--88


---------------------------------------------------------------------
-- All-at-once operations
---------------------------------------------------------------------

