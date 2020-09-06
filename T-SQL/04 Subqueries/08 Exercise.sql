
---------------------------------------------------------------------
-- Subqueries Exercise

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
---------------------------------------------------------------------
-- Query 1: Write a query that queries the Orders table and return information about the order that has the maximum orderid in the table
-- Query 2: Write a query that returns orders placed by employees whose last name starts with the letter C
-- Query 3: Write a query that returns orders placed by employees whose last name starts with the letter D
-- Query 4: Write a query that returns orders placed by customers from a USA
-- Query 5: Write a query that returns customers who did not put any orders
-- Query 6: Write a query that returns orders with a maximum order ID for each customer
-- Query 7: Write a query that queries Sales.OrderValues view and return for each order the percentage of the current order value out of the customer total.
-- Query 8: Write a query that returns customers from spain who placed orders
-- Query 9: Write a query that returns customers from spain who DID NOT placed orders
---------------------------------------------------------------------

/*---------------------------------------------------------------------
Exercise 1

Write a query that returns all orders placed on the last day of activity that can be found in the Orders table

Table involved: Sales.Orders
*/---------------------------------------------------------------------
--1. Self-contained scalar subquery
SELECT * 
FROM Sales.Orders
WHERE orderdate = (
	SELECT MAX(orderdate)
	FROM Sales.Orders
)

/*---------------------------------------------------------------------
Exercise 2 

Write a query that returns all orders placed by the customer(s) who placed the highest number of orders. 

Note that more than one customer might have the same number of orders:

Table involved: Sales.Orders
*/---------------------------------------------------------------------
--1. 
;WITH CTEOrderCount AS(
	SELECT custid, COUNT(DISTINCT orderid) 'OrderCount'
	FROM Sales.Orders
	GROUP BY custid
)
SELECT *
FROM Sales.Orders
WHERE custid IN (
	SELECT custid
	FROM CTEOrderCount
	WHERE OrderCount = (
		SELECT MAX(OrderCount)
		FROM CTEOrderCount
	)
)

--2
;WITH CTEOrderCount AS(
	SELECT *
		 , COUNT(orderid) OVER(PARTITION BY custid) 'OrderCount'
	FROM Sales.Orders
)
SELECT *
FROM CTEOrderCount
WHERE OrderCount = (
	SELECT MAX(OrderCount)
	FROM CTEOrderCount
)

--3
SELECT *
FROM Sales.Orders
WHERE custid IN (
	SELECT TOP(1) WITH TIES custid
	FROM Sales.Orders
	GROUP BY custid
	ORDER BY COUNT(DISTINCT orderid) DESC
)

/*---------------------------------------------------------------------
Exercise 3
Write a query that returns employees who did not place orders on or after May 1, 2016

Tables involved: HR.Employees and Sales.Orders
*/---------------------------------------------------------------------
--1
SELECT * 
FROM HR.Employees
WHERE empid NOT IN (
	SELECT DISTINCT empid
	FROM Sales.Orders
	WHERE orderdate >= '2016-05-01' AND empid IS NOT NULL
)

--2
SELECT * 
FROM HR.Employees E
WHERE NOT EXISTS (
	SELECT *
	FROM Sales.Orders O
	WHERE O.empid = E.empid
	AND O.orderdate >= '2016-05-01' 
)

--3
SELECT * 
FROM HR.Employees E
LEFT JOIN (SELECT * FROM Sales.Orders WHERE orderdate >= '2016-05-01') O ON O.empid = E.empid
WHERE O.orderid IS NULL

--4
SELECT * 
FROM HR.Employees E
LEFT JOIN Sales.Orders O ON O.empid = E.empid AND O.orderdate >= '2016-05-01'
WHERE O.orderid IS NULL

/*---------------------------------------------------------------------
Exercise 4
Write a query that returns countries where there are customers but not employees

Tables involved: Sales.Customers and HR.Employees
*/---------------------------------------------------------------------
--1
SELECT DISTINCT country
FROM Sales.Customers
WHERE country NOT IN (
	SELECT DISTINCT country
	FROM HR.Employees
)

--2
SELECT DISTINCT C.country
FROM Sales.Customers C
LEFT JOIN HR.Employees E ON E.country = C.country
WHERE E.country IS NULL

/*---------------------------------------------------------------------
Exercise 5
Write a query that returns for each customer all orders placed on the customer’s last day of activity

Table involved: Sales.Orders
*/---------------------------------------------------------------------
--1
;WITH CTELastDayOfActivity AS(
SELECT custid, MAX(orderdate) 'LastDayOfActivity'
FROM Sales.Orders
GROUP BY custid
)
SELECT *
FROM Sales.Orders O
JOIN CTELastDayOfActivity C ON C.custid = O.custid and C.LastDayOfActivity = O.orderdate

--2
SELECT *
FROM Sales.Orders O1
WHERE orderdate IN (
	SELECT MAX(orderdate)
	FROM Sales.Orders O2
	WHERE O2.custid = O1.custid
)

/*---------------------------------------------------------------------
Exercise 6
Write a query that returns customers who placed orders in 2015 but not in 2016

Tables involved: Sales.Customers and Sales.Orders
*/---------------------------------------------------------------------
--1
SELECT DISTINCT custid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2015
EXCEPT
SELECT DISTINCT custid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2016

--2
SELECT DISTINCT O1.custid
FROM (SELECT * FROM Sales.Orders WHERE YEAR(orderdate) = 2015) O1
LEFT JOIN (SELECT * FROM Sales.Orders WHERE YEAR(orderdate) = 2016) O2 ON O2.custid = O1.custid
WHERE O2.orderid IS NULL


--3
SELECT *
FROM Sales.Customers
WHERE custid IN (
	SELECT DISTINCT custid
	FROM Sales.Orders
	WHERE YEAR(orderdate) = 2015
	AND custid NOT IN (
		SELECT custid
		FROM Sales.Orders
		WHERE YEAR(orderdate) = 2016
	)
)

--4
SELECT *
FROM Sales.Customers C
WHERE EXISTS (
	SELECT *
	FROM Sales.Orders O1
	WHERE O1.custid = C.custid
	AND YEAR(O1.orderdate) = 2015
)
AND NOT EXISTS (
	SELECT *
	FROM Sales.Orders O1
	WHERE O1.custid = C.custid
	AND YEAR(O1.orderdate) = 2016
)

/*---------------------------------------------------------------------
Exercise 7
Write a query that returns customers who ordered product 12

Tables involved: Sales.Customers, Sales.Orders, and Sales.OrderDetails
*/---------------------------------------------------------------------
--1
SELECT DISTINCT C.custid, C.contactname, C.contacttitle, C.address
FROM Sales.Customers C
JOIN Sales.Orders O ON O.custid = C.custid
JOIN Sales.OrderDetails OD ON OD.orderid = O.orderid
WHERE OD.productid = 12

--2
SELECT DISTINCT custid, contactname, contacttitle, address
FROM Sales.Customers
WHERE custid IN (
	SELECT custid
	FROM Sales.Orders 
	WHERE orderid IN (
	    SELECT orderid
		FROM Sales.OrderDetails
		WHERE productid = 12
	)
)

--3. Nested EXISTS
SELECT DISTINCT custid, contactname, contacttitle, address
FROM Sales.Customers C
WHERE EXISTS (
	SELECT *
	FROM Sales.Orders O
	WHERE O.custid = C.custid
	AND EXISTS (
	    SELECT *
		FROM Sales.OrderDetails OD
		WHERE OD.orderid = O.orderid
		AND productid = 12
	)
)

/*---------------------------------------------------------------------
Exercise 8
Write a query that calculates a running-total quantity for each customer and month

Tables involved: Sales.CustOrders
*/---------------------------------------------------------------------
--1
SELECT custid
     , ordermonth
	 , qty
     , SUM(qty) OVER (PARTITION BY custid ORDER BY ordermonth) 'RunningTotalQty'
FROM Sales.CustOrders
ORDER BY 1

--2
SELECT CO1.custid
     , CO1.ordermonth
	 , CO1.qty
	 , SUM(CO2.qty) 'RunningTotalQty'
FROM Sales.CustOrders CO1
JOIN Sales.CustOrders CO2 ON CO2.custid = CO1.custid and CO1.ordermonth >= CO2.ordermonth
GROUP BY CO1.custid, CO1.ordermonth, CO1.qty
ORDER BY CO1.custid, CO1.ordermonth, CO1.qty

--3
SELECT CO1.custid
     , CO1.ordermonth
	 , CO1.qty
	 , (SELECT SUM(qty) FROM Sales.CustOrders CO2 WHERE CO2.custid = CO1.custid AND CO1.ordermonth >= CO2.ordermonth) 'RunningTotalQty'
FROM Sales.CustOrders CO1
ORDER BY CO1.custid

/*---------------------------------------------------------------------
Exercise 10
Write a query that returns for each order the number of days that passed since the same customer’s previous order. 
To determine recency among orders, use orderdate as the primary sort element and orderid as the tiebreaker

Table involved: Sales.Orders
*/---------------------------------------------------------------------
--1
;WITH CTEPrevOrder AS(
SELECT *
     , LAG(orderdate) OVER(PARTITION BY custid ORDER BY orderdate, orderid) 'PrevOrder'
FROM Sales.Orders
)
SELECT orderid
     , custid
	 , orderdate
	 , PrevOrder
	 , DATEDIFF(DAY, PrevOrder, orderdate) 'NumberOfDaysSinceLastOrder'
FROM CTEPrevOrder

--2
;WITH CTERowNUM AS(
	SELECT *
		 , ROW_NUMBER() OVER(PARTITION BY custid ORDER BY orderdate, orderid) 'RowNUM'
	FROM Sales.Orders O1
)
SELECT N1.*
     , DATEDIFF(DAY, N2.orderdate, N1.orderdate) 'NumberOfDaysSinceLastOrder'
FROM CTERowNUM N1
LEFT JOIN CTERowNUM N2 ON N1.custid = N2.custid AND N1.RowNUM = N2.RowNUM + 1
ORDER BY N1.custid, N1.orderdate, N1.orderid

--3
SELECT *
     , (SELECT MAX(orderdate) FROM Sales.Orders O2 WHERE O2.custid = O1.custid AND O2.orderid < O1.orderid)
FROM Sales.Orders O1
ORDER BY O1.custid, O1.orderdate, O1.orderid

--4
SELECT *
     , (SELECT TOP(1) orderdate FROM Sales.Orders O2 WHERE O2.custid = O1.custid AND (O2.orderdate = O1.orderdate AND O2.orderid < O1.orderid OR O2.orderdate < O1.orderdate) ORDER BY orderdate DESC, orderid DESC) 'PrevOrder'
	 , DATEDIFF(DAY
	           ,(SELECT TOP(1) orderdate FROM Sales.Orders O2 WHERE O2.custid = O1.custid AND (O2.orderdate = O1.orderdate AND O2.orderid < O1.orderid OR O2.orderdate < O1.orderdate) ORDER BY orderdate DESC, orderid DESC)
			   , orderdate) 'NumberOfDaysSinceLastOrder'
FROM Sales.Orders O1
ORDER BY O1.custid, O1.orderdate, O1.orderid