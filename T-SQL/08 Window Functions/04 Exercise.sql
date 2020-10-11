
---------------------------------------------------------------------
-- Window functions
-- Grouping Sets
-- PIVOT UNPIVOT Exercise

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

Write a query against the dbo.Orders table that computes both a rank and a dense rank for each customer order, partitioned by custid and ordered by qty:

Table involved: TSQLV4 database, dbo.Orders table

*/---------------------------------------------------------------------

SELECT *  FROM dbo.Orders

SELECT custid
     , orderid
	 , qty
	 , ROW_NUMBER() OVER(PARTITION BY custid ORDER BY qty) 'RowNum'
	 , RANK() OVER(PARTITION BY custid ORDER BY qty) 'Rank'
	 , DENSE_RANK() OVER(PARTITION BY custid ORDER BY qty) 'DenseRank'
FROM dbo.Orders

/*---------------------------------------------------------------------
Exercise 2

Earlier in the chapter in the section “Ranking window functions,” I provided the following query against the Sales.OrderValues view to return distinct values and their associated row numbers:

SELECT val, ROW_NUMBER() OVER(ORDER BY val) AS rownum
FROM Sales.OrderValues
GROUP BY val;

Can you think of an alternative way to achieve the same task?

Table involved: TSQLV4 database, Sales.OrderValues view

*/---------------------------------------------------------------------

SELECT * FROM Sales.OrderValues

SELECT val, ROW_NUMBER() OVER(ORDER BY val) AS rownum
FROM Sales.OrderValues
GROUP BY val;

SELECT val, ROW_NUMBER() OVER(ORDER BY val) AS rownum
FROM (
	SELECT DISTINCT val
	FROM Sales.OrderValues
) D

/*---------------------------------------------------------------------
Exercise 3

Write a query against the dbo.Orders table that computes for each customer order both the difference
between the current order quantity and the customer’s previous order quantity and the difference between the current order quantity and the customer’s next order quantity:

Table involved: TSQLV4 database, dbo.Orders table

*/---------------------------------------------------------------------
; WITH CTE AS(
SELECT custid, orderdate, orderid, qty 
     , LAG(qty) OVER(PARTITION BY custid ORDER BY orderdate, orderid) 'PreVal'
	 , LEAD(qty) OVER(PARTITION BY custid ORDER BY orderdate, orderid) 'NextVal'
FROM dbo.Orders
)

SELECT custid, orderdate, orderid, qty, PreVal, NextVal
     , qty - PreVal 'DiffPrev'
	 , qty - NextVal 'DiffNext'
FROM CTE
ORDER BY custid, orderdate, orderid

/*---------------------------------------------------------------------
Exercise 4

Write a query against the dbo.Orders table that returns a row for each employee, a column for each order year, and the count of orders for each employee and order year:

Table involved: TSQLV4 database, dbo.Orders table

*/---------------------------------------------------------------------

SELECT *  FROM dbo.Orders

SELECT empid
    , COUNT(CASE WHEN YEAR(orderdate) = 2014 THEN orderid END) 'cnt2014'
    , COUNT(CASE WHEN YEAR(orderdate) = 2015 THEN orderid END) 'cnt2015'
    , COUNT(CASE WHEN YEAR(orderdate) = 2016 THEN orderid END) 'cnt2016'
FROM dbo.Orders
GROUP BY empid

SELECT empid
    , [2014] 'cnt2014'
	, [2015] 'cnt2015'
	, [2016] 'cnt2016'
FROM (SELECT empid, YEAR(orderdate) 'orderdate', orderid FROM dbo.Orders) D
PIVOT (COUNT(orderid)
FOR orderdate IN ([2014], [2015], [2016])) P

/*---------------------------------------------------------------------
Exercise 5

Run the following code to create and populate the EmpYearOrders table:

USE TSQLV4;
DROP TABLE IF EXISTS dbo.EmpYearOrders;
CREATE TABLE dbo.EmpYearOrders
(
empid INT NOT NULL
CONSTRAINT PK_EmpYearOrders PRIMARY KEY,
cnt2014 INT NULL,
cnt2015 INT NULL,
cnt2016 INT NULL
);
INSERT INTO dbo.EmpYearOrders(empid, cnt2014, cnt2015, cnt2016)
SELECT empid, [2014] AS cnt2014, [2015] AS cnt2015, [2016] AS cnt2016
FROM (SELECT empid, YEAR(orderdate) AS orderyear
FROM dbo.Orders) AS D
PIVOT(COUNT(orderyear)
FOR orderyear IN([2014], [2015], [2016])) AS P;

SELECT * FROM dbo.EmpYearOrders;

Here’s the output for the query:
empid cnt2014 cnt2015 cnt2016
----------- ----------- ----------- -----------
1 1 1 1
2 1 2 1
3 2 0 2

Write a query against the EmpYearOrders table that unpivots the data, returning a row for each
employee and order year with the number of orders. Exclude rows in which the number of orders is 0
(in this example, employee 3 in the year 2015).

*/---------------------------------------------------------------------

DROP TABLE IF EXISTS dbo.EmpYearOrders;

CREATE TABLE dbo.EmpYearOrders
(
	empid INT NOT NULL
	CONSTRAINT PK_EmpYearOrders PRIMARY KEY,
	cnt2014 INT NULL,
	cnt2015 INT NULL,
	cnt2016 INT NULL
);

INSERT INTO dbo.EmpYearOrders(empid, cnt2014, cnt2015, cnt2016)
SELECT empid, [2014] AS cnt2014, [2015] AS cnt2015, [2016] AS cnt2016
FROM (SELECT empid, YEAR(orderdate) AS orderyear
      FROM dbo.Orders) AS D
PIVOT(COUNT(orderyear)
FOR orderyear IN([2014], [2015], [2016])) AS P;

SELECT * FROM dbo.EmpYearOrders;

SELECT * 
FROM dbo.EmpYearOrders
CROSS JOIN (VALUES (2014), (2015), (2016)) D(orderyear)

SELECT empid,  orderyear, numorders
FROM dbo.EmpYearOrders
CROSS APPLY (VALUES (2014, cnt2014), (2015, cnt2015), (2016, cnt2016)) D(orderyear, numorders)
WHERE numorders != 0

SELECT empid, orderyear, numorders
FROM dbo.EmpYearOrders
UNPIVOT(numorders FOR orderyear IN (cnt2014, cnt2015, cnt2016)) U

SELECT empid, RIGHT(orderyear, 4) 'orderyear', numorders
FROM dbo.EmpYearOrders
UNPIVOT(numorders FOR orderyear IN (cnt2014, cnt2015, cnt2016)) U
WHERE numorders != 0

/*---------------------------------------------------------------------
Exercise 6

Write a query against the dbo.Orders table that returns the total quantities for each of the following:
(employee, customer, and order year), (employee and order year), and (customer and order year).

Include a result column in the output that uniquely identifies the grouping set with which the current row is associated:

Table involved: TSQLV4 database, dbo.Orders table

*/---------------------------------------------------------------------

SELECT *  FROM dbo.Orders

SELECT empid, custid, YEAR(orderdate) 'OrderYear', sum(qty) 'TotQty'
FROM dbo.Orders
GROUP BY empid, custid, YEAR(orderdate)
UNION ALL
SELECT empid, NULL 'custid', YEAR(orderdate) 'OrderYear', sum(qty) 'TotQty'
FROM dbo.Orders
GROUP BY empid, YEAR(orderdate)
UNION ALL
SELECT NULL 'empid', custid, YEAR(orderdate) 'OrderYear', sum(qty) 'TotQty'
FROM dbo.Orders
GROUP BY custid, YEAR(orderdate)

SELECT GROUPING_ID(empid, custid, YEAR(orderdate)) 'GrpID'
    , empid 
    , custid
	, YEAR(orderdate) 'OrderYear'
	, sum(qty) 'TotQty'
FROM dbo.Orders
GROUP BY GROUPING SETS ((empid, custid, YEAR(orderdate)), (empid, YEAR(orderdate)), (custid, YEAR(orderdate)))
ORDER BY GROUPING_ID(empid, custid, YEAR(orderdate))