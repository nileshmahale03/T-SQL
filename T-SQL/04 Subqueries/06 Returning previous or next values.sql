
---------------------------------------------------------------------
-- Subqueries 

-- Returning previous or next values

-- Previous: Maximum value that is smaller than the current value
-- Next    : Minimum value that is greater than the current value
---------------------------------------------------------------------

/*---------------------------------------------------------------------
Exercise 1

You need to query the Orders table and return, for each order, information about the current order and the previous order ID

Table involved: Sales.Orders
*/---------------------------------------------------------------------
USE TSQLV4

SELECT orderid
     , orderdate
	 , empid
	 , custid
FROM Sales.Orders
ORDER BY orderid

SELECT orderid
     , orderdate
	 , empid
	 , custid
	 , (SELECT MAX(orderid) FROM Sales.Orders O2 WHERE O2.orderid < O1.orderid) 'PrevOrderID'
	 , (SELECT MIN(orderid) FROM Sales.Orders O3 WHERE O3.orderid > O1.orderid) 'NextOrderID'
FROM Sales.Orders O1
ORDER BY O1.orderid