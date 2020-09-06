---------------------------------------------------------------------
-- TOP

-- Filtering clauses WHERE and HAVING, which are based on predicates.
-- filtering clauses TOP and OFFSET-FETCH, which are based on number of rows and ordering.

-- Use TOP to limit the number or percentage of rows your query returns.

-- You can use the TOP option with the PERCENT keyword, in which case SQL Server calculates the number of rows to return based on a percentage of the number of qualifying rows, rounded up.

-- Note that you can even use the TOP filter in a query without an ORDER BY clause. In such a case, 
-- the ordering is completely undefined—SQL Server returns whichever n rows it happens to physically access first, 
-- where n is the requested number of rows.

-- If you want the query to be deterministic, you need to make the ORDER BY list unique; in other words, add a tiebreaker.

-- Instead of adding a tiebreaker to the ORDER BY list, you can request to return all ties. You achieve this by adding the WITH TIES option
---------------------------------------------------------------------
USE TSQLV4

SELECT TOP (5)
       orderid
     , orderdate
	 , custid
	 , empid
FROM Sales.Orders

--Non-deterministic TOP
SELECT TOP (5)          --7
       orderid          --5
     , orderdate
	 , custid
	 , empid
FROM Sales.Orders       --1
ORDER BY orderdate desc --6

SELECT TOP (1) PERCENT  --7
       orderid          --5
     , orderdate
	 , custid
	 , empid
FROM Sales.Orders       --1
ORDER BY orderdate desc --6

--Deterministic TOP
SELECT TOP (5)          
       orderid          
     , orderdate
	 , custid
	 , empid
FROM Sales.Orders       
ORDER BY orderdate desc, orderid desc 

SELECT TOP (5) WITH TIES          
       orderid          
     , orderdate
	 , custid
	 , empid
FROM Sales.Orders       
ORDER BY orderdate desc