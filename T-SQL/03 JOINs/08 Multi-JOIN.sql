
---------------------------------------------------------------------
-- Multi-JOIN

-- A join table operator operates on 2 tables, but a single query can have multiple joins.
-- When more than 1 table operator appears in the FROM clause, the table operators are logically processed from LEFT to RIGHT
---------------------------------------------------------------------

USE TSQLV4

SELECT * FROM Sales.Orders WHERE orderid = 10248

SELECT * FROM Sales.OrderDetails WHERE orderid = 10248  

SELECT * FROM Sales.Customers WHERE custid = 85


SELECT *
FROM Sales.Customers C
INNER JOIN Sales.Orders O ON O.custid = C.custid
INNER JOIN Sales.OrderDetails OD ON OD.orderid = O.orderid