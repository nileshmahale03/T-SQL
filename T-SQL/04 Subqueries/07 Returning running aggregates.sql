
---------------------------------------------------------------------
-- Subqueries 

-- Returning running aggregates

-- Running aggregates are aggregates that accumulates values based on some order.
---------------------------------------------------------------------

/*---------------------------------------------------------------------
Exercise 1

You need to compute for each year the running total quantity up to and including that year's

Table involved: Sales.OrderTotalsByYear
*/---------------------------------------------------------------------
USE TSQLV4

SELECT *
FROM Sales.OrderTotalsByYear
ORDER BY orderyear

SELECT orderyear
     , qty
	 , (SELECT SUM(qty) FROM Sales.OrderTotalsByYear O2 WHERE O2.orderyear <= O1.orderyear) 'RunQty'
FROM Sales.OrderTotalsByYear O1
ORDER BY O1.orderyear

SELECT O1.orderyear
     , O1.qty
	 , O2.orderyear
	 , O2.qty
FROM Sales.OrderTotalsByYear O1
LEFT JOIN Sales.OrderTotalsByYear O2 ON O2.orderyear <= O1.orderyear
ORDER BY O1.orderyear

SELECT O1.orderyear
     , O1.qty
	 , SUM(O2.qty) 'RunQty'
FROM Sales.OrderTotalsByYear O1
LEFT JOIN Sales.OrderTotalsByYear O2 ON O2.orderyear <= O1.orderyear
GROUP BY O1.orderyear, O1.qty
ORDER BY O1.orderyear