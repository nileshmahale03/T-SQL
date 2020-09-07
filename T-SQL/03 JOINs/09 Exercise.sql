
---------------------------------------------------------------------
-- JOIN Exercise

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

SELECT * FROM dbo.Nums

/*---------------------------------------------------------------------
Exercise 1-1

Write a query that generates five copies of each employee row:

Table involved: HR.Employees and dbo.Nums
*/---------------------------------------------------------------------
SELECT *
FROM HR.Employees E
CROSS JOIN dbo.Nums N
WHERE N.n <= 5
ORDER BY E.empid

/*---------------------------------------------------------------------
Exercise 1-2

Write a query that returns a row for each employee and day in the range June 12, 2016 through June 16, 2016:

Tables involved: HR.Employees and dbo.Nums
*/---------------------------------------------------------------------
;WITH CTE AS (
SELECT n
     , DATEADD(DAY, n-1, '2016-06-12') 'date'
FROM dbo.Nums N
WHERE N.n <= 5
)
SELECT empid
     , firstname
	 , lastname
	 , date
FROM HR.Employees E
CROSS JOIN CTE C 
ORDER BY E.empid

/*---------------------------------------------------------------------
Exercise 2

Explain what’s wrong in the following query, and provide a correct alternative:

SELECT Customers.custid, Customers.companyname, Orders.orderid, Orders.orderdate
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
ON Customers.custid = Orders.custid;
*/---------------------------------------------------------------------
SELECT Customers.custid, Customers.companyname, Orders.orderid, Orders.orderdate
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
ON Customers.custid = Orders.custid;

SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O ON C.custid = O.custid;

/*---------------------------------------------------------------------
Exercise 3

Return US customers, and for each customer return the total number of orders and total quantities:

 Tables involved: Sales.Customers, Sales.Orders, and Sales.OrderDetails
*/---------------------------------------------------------------------
SELECT C.custid
     , O.orderid
	 , OD.qty
FROM Sales.Customers C
INNER JOIN Sales.Orders O ON O.custid = C.custid
INNER JOIN Sales.OrderDetails OD ON OD.orderid = O.orderid
WHERE C.country = 'USA'

SELECT C.custid
     , COUNT(DISTINCT O.orderid) 'TotalOrders'
	 , SUM(OD.qty) 'TotalQtys'
FROM Sales.Customers C
INNER JOIN Sales.Orders O ON O.custid = C.custid
INNER JOIN Sales.OrderDetails OD ON OD.orderid = O.orderid
WHERE C.country = 'USA'
GROUP BY C.custid

SELECT *
FROM Sales.Orders
WHERE custid = 32

SELECT *
FROM Sales.OrderDetails
WHERE orderid = 10528

/*---------------------------------------------------------------------
Exercise 4

Return customers and their orders, including customers who placed no orders:

 Tables involved: Sales.Customers and Sales.Orders
*/---------------------------------------------------------------------
SELECT C.custid
     , O.orderid
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON O.custid = C.custid

/*---------------------------------------------------------------------
Exercise 5

Return customers who placed no orders:

 Tables involved: Sales.Customers and Sales.Orders
*/---------------------------------------------------------------------
SELECT C.custid
     , O.orderid
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON O.custid = C.custid
WHERE O.orderid IS NULL

/*---------------------------------------------------------------------
Exercise 6

Return customers with orders placed on February 12, 2016, along with their orders:

 Tables involved: Sales.Customers and Sales.Orders
*/---------------------------------------------------------------------
SELECT C.custid
     , O.orderid
	 , O.orderdate
FROM Sales.Customers C
INNER JOIN Sales.Orders O ON O.custid = C.custid
WHERE O.orderdate = '20160212'

/*---------------------------------------------------------------------
Exercise 7

Write a query that returns all customers in the output, but matches them with their respective orders only if they were placed on February 12, 2016:

 Tables involved: Sales.Customers and Sales.Orders
*/---------------------------------------------------------------------
SELECT C.custid
     , O.orderid
	 , O.orderdate
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON O.custid = C.custid AND O.orderdate = '20160212'
ORDER BY C.custid

/*---------------------------------------------------------------------
Exercise 8

Explain why the following query isn’t a correct solution query for Exercise 7:

SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O
ON O.custid = C.custid
WHERE O.orderdate = '20160212'
OR O.orderid IS NULL;
*/---------------------------------------------------------------------
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O ON O.custid = C.custid
WHERE O.orderdate = '20160212'
OR O.orderid IS NULL;

/*---------------------------------------------------------------------
Exercise 9

Return all customers, and for each return a Yes/No value depending on whether the customer placed orders on February 12, 2016:

 Tables involved: Sales.Customers and Sales.Orders
*/---------------------------------------------------------------------
SELECT C.custid
     , O.orderid
	 , O.orderdate
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON O.custid = C.custid AND O.orderdate = '20160212'
ORDER BY C.custid

SELECT DISTINCT C.custid
	 , CASE WHEN orderdate IS NOT NULL THEN 'Yes'
	        WHEN orderdate IS NULL     THEN 'No'
	   END 'Flag'
FROM Sales.Customers C
LEFT JOIN Sales.Orders O ON O.custid = C.custid AND O.orderdate = '20160212'
ORDER BY C.custid
