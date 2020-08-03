
---------------------------------------------------------------------
-- Subqueries

-- SQL supports writing queries within queries, or nesting queries
-- When you use subqueries, you avoid the need for seperate steps in your solution that store intermediate query results in variables. 

-- A subquery can either be self-contained or correlated. 
-- A self-conatined subquery has no dependency on tables from the outer query, wheras a correlated subquey does. 

-- A subquey can be single-valued, multivalued or table-valued. 

-- You're likely to stumble into many other querying problems you can solve with either subqueries or joins. 
-- I don't know a reliable rule of a thumb that says a subquery is better thana join or other way around. 
-- In some cases the database engine optimizes both the same way, sometimes joins perform better, sometime subqueries perform better. 
-- My approcah is to first write a solution query that is intuitive and then, if performance is not satisfactory, try query revisions among other tuning methods
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

