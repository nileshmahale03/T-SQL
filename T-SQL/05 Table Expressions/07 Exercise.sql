
---------------------------------------------------------------------
-- Table Expressions Exercise

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

The following query attempts to filter orders that were not placed on the last day of the year. 
It’s supposed to return the order ID, order date, customer ID, employee ID, and respective end-of-year date for each order:

SELECT orderid, orderdate, custid, empid,
DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
FROM Sales.Orders
WHERE orderdate <> endofyear;

When you try to run this query, you get the following error:

Msg 207, Level 16, State 1, Line 233
Invalid column name ‘endofyear'.

Explain what the problem is, and suggest a valid solution.

*/---------------------------------------------------------------------
SELECT orderid, orderdate, custid, empid, DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
FROM Sales.Orders
WHERE orderdate <> DATEFROMPARTS(YEAR(orderdate), 12, 31);

/*---------------------------------------------------------------------
Exercise 2-1

Write a query that returns the maximum value in the orderdate column for each employee:

Table involved: TSQLV4 database, Sales.Orders table
*/---------------------------------------------------------------------
SELECT empid
     , MAX(orderdate) 'MaxOrderDate'
FROM Sales.Orders
GROUP BY empid

/*---------------------------------------------------------------------
Exercise 2-2

Encapsulate the query from Exercise 2-1 in a derived table. 
Write a join query between the derived table and the Orders table to return the orders with the maximum order date for each employee:

Table involved: TSQLV4 database, Sales.Orders table
*/---------------------------------------------------------------------
SELECT * 
FROM (
	SELECT empid
		 , MAX(orderdate) 'MaxOrderDate'
	FROM Sales.Orders
	GROUP BY empid
) D
INNER JOIN Sales.Orders O ON O.empid = D.empid and O.orderdate = D.MaxOrderDate

/*---------------------------------------------------------------------
Exercise 3-1

Write a query that calculates a row number for each order based on orderdate, orderid ordering:

Table involved: Sales.Orders
*/---------------------------------------------------------------------

SELECT custid, orderdate, orderid
     , ROW_NUMBER() OVER ( ORDER BY orderdate, orderid) 'RowNum'
FROM Sales.Orders

/*---------------------------------------------------------------------
Exercise 3-2

Write a query that returns rows with row numbers 11 through 20 based on the row-number definition in Exercise 3-1. 
Use a CTE to encapsulate the code from Exercise 3-1:

Table involved: Sales.Orders
*/---------------------------------------------------------------------
; WITH CTERowNum AS (
	SELECT custid, orderdate, orderid
		 , ROW_NUMBER() OVER ( ORDER BY orderdate, orderid) 'RowNum'
	FROM Sales.Orders
)
SELECT * 
FROM CTERowNum
WHERE RowNum BETWEEN 11 and 20

/*---------------------------------------------------------------------
Exercise 4

Write a solution using a recursive CTE that returns the management chain leading to Patricia Doyle (employee ID 9):

Table involved: HR.Employees
*/---------------------------------------------------------------------
; WITH CTEEmp AS (
SELECT empid, firstname, lastname, mgrid 
FROM HR.Employees
WHERE empid = 9

UNION ALL

SELECT E.empid, E.firstname, E.lastname, E.mgrid  
FROM CTEEmp C
INNER JOIN HR.Employees E ON E.empid = C.mgrid
)
SELECT *
FROM CTEEmp

/*---------------------------------------------------------------------
Exercise 5-1

Create a view that returns the total quantity for each employee and year:

Tables involved: Sales.Orders and Sales.OrderDetails

When running the following code:
SELECT * FROM Sales.VEmpOrders ORDER BY empid, orderyear;
*/---------------------------------------------------------------------

DROP VIEW IF EXISTS Sales.vwEmpOrders
Go

CREATE VIEW Sales.vwEmpOrders
AS

SELECT empid, YEAR(orderdate) 'orderyear'
     , SUM(qty) 'qty'
FROM Sales.Orders O
INNER JOIN Sales.OrderDetails OD ON OD.orderid = O.orderid
GROUP BY empid, YEAR(orderdate)

GO

SELECT * FROM Sales.vwEmpOrders 
ORDER BY empid, orderyear;

/*---------------------------------------------------------------------
Exercise 5-2 (optional, advanced)

Write a query against Sales.vwEmpOrders that returns the running total quantity for each employee and year:

Table involved: Sales.VEmpOrders view
*/---------------------------------------------------------------------

SELECT V1.empid, V1.orderyear, V1.qty 
     , (SELECT SUM(qty) FROM Sales.vwEmpOrders V2 WHERE V2.empid = V1.empid AND V2.orderyear <= V1.orderyear) 'RunTotal'
FROM Sales.vwEmpOrders V1
ORDER BY empid, orderyear

/*---------------------------------------------------------------------
Exercise 6-1 

Create an inline TVF that accepts as inputs a supplier ID (@supid AS INT) and a requested number of products (@n AS INT). 
The function should return @n products with the highest unit prices that are supplied by the specified supplier ID:

Table involved: Production.Products

When issuing the following query:
SELECT * FROM Production.fnTopProducts(5, 2);
*/---------------------------------------------------------------------

DROP FUNCTION IF EXISTS Production.fnTopProducts
Go

CREATE FUNCTION Production.fnTopProducts
(@supplierid INT, @N INT)
RETURNS TABLE
AS
RETURN

SELECT productid, productname, unitprice 
FROM Production.Products
WHERE supplierid = @supplierid 
ORDER BY unitprice DESC
OFFSET 0 ROWS FETCH NEXT @n ROWS ONLY

GO

SELECT * FROM Production.fnTopProducts(5, 2)

/*---------------------------------------------------------------------
Exercise 6-2

Using the CROSS APPLY operator and the function you created in Exercise 6-1, return the two most
expensive products for each supplier:

Table involved: Production.Suppliers
*/---------------------------------------------------------------------
SELECT * 
FROM Production.Suppliers S
CROSS APPLY Production.fnTopProducts(S.supplierid, 2)

DROP VIEW IF EXISTS Sales.VEmpOrders;
DROP FUNCTION IF EXISTS Production.fnTopProducts;