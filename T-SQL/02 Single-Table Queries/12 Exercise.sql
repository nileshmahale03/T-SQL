
---------------------------------------------------------------------
-- Single-table queries Exercise

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

Write a query against the Sales.Orders table that returns orders placed in June 2015:

Table involved: Sales.Orders
*/---------------------------------------------------------------------
--1
SELECT orderid
     , orderdate
	 , custid
	 , empid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2015 and MONTH(orderdate) = 6

SELECT orderid
     , orderdate
	 , custid
	 , empid
FROM Sales.Orders
WHERE orderdate >= '20150601' AND orderdate < '20150701'

/*---------------------------------------------------------------------
Exercise 2

Write a query against the Sales.Orders table that returns orders placed on the last day of the month:

Table involved: Sales.Orders
*/---------------------------------------------------------------------
SELECT orderid
     , orderdate
	 , EOMONTH(orderdate) 'EOMONTH'
	 , custid
	 , empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate)

SELECT orderid
     , orderdate
	 , EOMONTH(orderdate) 'EOMONTH'
	 , custid
	 , empid
FROM Sales.Orders
WHERE orderdate = DATEADD(month, DATEDIFF(month, '18991231', orderdate), '18991231')

/*---------------------------------------------------------------------
Exercise 3

Write a query against the HR.Employees table that returns employees with a last name containing the
letter e twice or more:

Table involved: HR.Employees
*/---------------------------------------------------------------------
SELECT empid
     , lastname
FROM HR.Employees 
WHERE lastname like '%e%'

SELECT empid
     , lastname
FROM HR.Employees 
WHERE lastname like '%e%e%'

SELECT empid
     , firstname
     , lastname
	 , REPLACE(lastname, 'e', '')
	 , LEN(lastname)
	 , LEN(REPLACE(lastname, 'e', ''))
	 , LEN(lastname) - LEN(REPLACE(lastname, 'e', ''))
FROM HR.Employees 
WHERE LEN(lastname) - LEN(REPLACE(lastname, 'e', '')) >= 2

/*---------------------------------------------------------------------
Exercise 4

Write a query against the Sales.OrderDetails table that returns orders with a total value (quantity *unitprice) 
greater than 10,000, sorted by total value:

Table involved: Sales.OrderDetails
*/---------------------------------------------------------------------
SELECT orderid
     , SUM(qty * unitprice) 'TotalValue'
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty * unitprice) > 10000
ORDER BY TotalValue DESC

/*---------------------------------------------------------------------
Exercise 5

To check the validity of the data, write a query against the HR.Employees table that returns employees
with a last name that starts with a lowercase English letter in the range a through z. 
Remember that the collation of the sample database is case insensitive (Latin1_General_CI_AS):

Table involved: HR.Employees
*/---------------------------------------------------------------------
SELECT empid
     , firstname
	 , lastname
FROM HR.Employees
WHERE lastname LIKE '[a-z]%'

SELECT empid
     , firstname
	 , lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS LIKE '[a-z]%'

SELECT empid
     , firstname
	 , lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS LIKE '[abcdefghijklmnopqrstuvwxyz]%'

/*---------------------------------------------------------------------
Exercise 6

Explain the difference between the following two queries:

-- Query 1
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderdate < '20160501'
GROUP BY empid;

-- Query 2
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20160501';
*/---------------------------------------------------------------------
-- Query 1
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderdate < '20160501'
GROUP BY empid;
-- Here we are filtering the rows

-- Query 2
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20160501';
-- Here we are filtering the groups i.e. empid

SELECT *
FROM Sales.Orders
WHERE empid = 1
ORDER BY orderdate

SELECT *
FROM Sales.Orders
WHERE empid = 3
ORDER BY orderdate

/*---------------------------------------------------------------------
Exercise 7

Write a query against the Sales.Orders table that returns the three shipped-to countries with the highest average freight in 2015:

Table involved: Sales.Orders table
*/---------------------------------------------------------------------
SELECT TOP (3) 
     shipcountry
   , AVG(freight) 'AvgFreight'
FROM Sales.Orders
WHERE YEAR(orderdate) = 2015
GROUP BY shipcountry
ORDER BY AvgFreight DESC

SELECT shipcountry
   , AVG(freight) 'AvgFreight'
FROM Sales.Orders
WHERE YEAR(orderdate) = 2015
GROUP BY shipcountry
ORDER BY AvgFreight DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY

/*---------------------------------------------------------------------
Exercise 8

Write a query against the Sales.Orders table that calculates row numbers for orders based on order date ordering 
(using the order ID as the tiebreaker) for each customer separately:

Table involved: Sales.Orders table
*/---------------------------------------------------------------------
SELECT custid
     , orderid
	 , orderdate
     , ROW_NUMBER() OVER (PARTITION BY custid ORDER BY orderdate, orderid) 'RowNum'
FROM Sales.Orders

/*---------------------------------------------------------------------
Exercise 9

Using the HR.Employees table, write a SELECT statement that returns for each employee the gender
based on the title of courtesy. For ‘Ms.‘ and ‘Mrs.’ return ‘Female’; for ‘Mr.‘ return ‘Male’; and in all other
cases (for example, ‘Dr.‘) return ‘Unknown’:

Table involved: HR.Employees table
*/---------------------------------------------------------------------
SELECT empid
     , firstname
	 , lastname
	 , title
	 , titleofcourtesy
	 , CASE WHEN titleofcourtesy IN ('Ms.', 'Mrs.') THEN 'Female'
	        WHEN titleofcourtesy = 'Mr.' THEN 'Male'
		ELSE 'Unknown' END 'gender'
FROM HR.Employees

SELECT empid
     , firstname
	 , lastname
	 , titleofcourtesy
	 , CASE titleofcourtesy
			WHEN 'Ms.'  THEN 'Female'
		    WHEN 'Mrs.' THEN 'Female'
		    WHEN 'Mr.'  THEN 'Male'
		ELSE 'Unknown' END  'gender'
FROM HR.Employees;

/*---------------------------------------------------------------------
Exercise 10

Write a query against the Sales.Customers table that returns for each customer the customer ID and region. 
Sort the rows in the output by region, having NULLs sort last (after non-NULL values). 
Note that the default sort behavior for NULLs in T-SQL is to sort first (before non-NULL values):

Table involved: Sales.Customers table
*/---------------------------------------------------------------------
SELECT custid
     , region
	-- , ISNULL(region, 'ZZ')
FROM Sales.Customers
ORDER BY ISNULL(region, 'ZZ')

SELECT custid
     , region
FROM Sales.Customers
ORDER BY CASE WHEN region IS NULL THEN 1 ELSE 0 END