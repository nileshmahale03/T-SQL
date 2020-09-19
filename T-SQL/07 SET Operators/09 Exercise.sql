
---------------------------------------------------------------------
-- SET Operators Exercise

---------------------------------------------------------------------

USE TSQLV4

SELECT * FROM Sales.Orders WHERE orderid = 10248

SELECT * FROM Sales.OrderDetails WHERE orderid = 10248  

SELECT * FROM Sales.Customers WHERE custid = 85

SELECT * FROM HR.Employees WHERE empid = 5

SELECT * FROM Sales.Shippers WHERE shipperid = 3

SELECT * FROM Production.Products WHERE productid IN (11, 42, 72)

SELECT * FROM Production.Suppliers WHERE supplierid IN (5, 20, 14)

SELECT * FROM Production.Categories WHERE categoryid IN (4, 5)

/*---------------------------------------------------------------------
Exercise 1

Explain the difference between the UNION ALL and UNION operators. In what cases are the two equivalent? 
When they are equivalent, which one should you use?

*/---------------------------------------------------------------------



/*---------------------------------------------------------------------
Exercise 2

Write a query that generates a virtual auxiliary table of 10 numbers in the range 1 through 10 without using a looping construct. 
You do not need to guarantee any order of the rows in the output of your solution:

*/---------------------------------------------------------------------
; WITH CTE_N AS (
SELECT 1 'Num'
UNION 
SELECT 2 'Num'
UNION 
SELECT 3 'Num'
UNION 
SELECT 4 'Num'
UNION 
SELECT 5 'Num'
UNION 
SELECT 6 'Num'
UNION 
SELECT 7 'Num'
UNION 
SELECT 8 'Num'
UNION 
SELECT 9 'Num'
UNION 
SELECT 10 'Num'
)

SELECT * 
FROM CTE_N

/*---------------------------------------------------------------------
Exercise 3

Write a query that returns customer and employee pairs that had order activity in January 2016 but not in February 2016:

Table involved: Sales.Orders table

*/---------------------------------------------------------------------

SELECT custid, empid FROM Sales.Orders WHERE orderdate >= '2016-01-01' AND orderdate < '2016-02-01'
EXCEPT
SELECT custid, empid FROM Sales.Orders WHERE orderdate >= '2016-02-01' AND orderdate < '2016-03-01'


/*---------------------------------------------------------------------
Exercise 4

Write a query that returns customer and employee pairs that had order activity in both January 2016 and February 2016:

Table involved: Sales.Orders

*/---------------------------------------------------------------------

SELECT custid, empid FROM Sales.Orders WHERE orderdate >= '2016-01-01' AND orderdate < '2016-02-01'
INTERSECT
SELECT custid, empid FROM Sales.Orders WHERE orderdate >= '2016-02-01' AND orderdate < '2016-03-01'


/*---------------------------------------------------------------------
Exercise 5

Write a query that returns customer and employee pairs that had order activity in both January 2016 and February 2016 but not in 2015:

Table involved: Sales.Orders

*/---------------------------------------------------------------------
(
SELECT custid, empid FROM Sales.Orders WHERE orderdate >= '2016-01-01' AND orderdate < '2016-02-01'
INTERSECT
SELECT custid, empid FROM Sales.Orders WHERE orderdate >= '2016-02-01' AND orderdate < '2016-03-01'
)
EXCEPT
SELECT custid, empid FROM Sales.Orders WHERE YEAR(orderdate) = 2015

/*---------------------------------------------------------------------
Exercise 6

You are given the following query:

SELECT country, region, city
FROM HR.Employees
UNION ALL
SELECT country, region, city
FROM Production.Suppliers;

You are asked to add logic to the query so that it guarantees that the rows from Employees are returned in the output before the rows from Suppliers. 

Also, within each segment, the rows should be sorted by country, region, and city:
 
Tables involved: HR.Employees and Production.Suppliers

*/---------------------------------------------------------------------

SELECT country, region, city
FROM HR.Employees
UNION ALL
SELECT country, region, city
FROM Production.Suppliers

; WITH CTE AS (
SELECT country, region, city, 'Employees' 'Source'
FROM HR.Employees
UNION ALL
SELECT country, region, city, 'Suppliers' 'Source'
FROM Production.Suppliers
)

SELECT *
FROM CTE
ORDER BY Source, country, region, city


; WITH CTE AS (
SELECT country, region, city, 1 'SortCol'
FROM HR.Employees
UNION ALL
SELECT country, region, city, 2 'SortCol'
FROM Production.Suppliers
)

SELECT *
FROM CTE
ORDER BY SortCol, country, region, city