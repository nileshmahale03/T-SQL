---------------------------------------------------------------------
-- SELECT 

-- The SELECT clause is where you specify the attributes (columns) you want to return in the result table of the query.

-- Remember that the SELECT clause is processed after the FROM, WHERE, GROUP BY, and HAVING clauses

-- This means that aliases assigned to expressions in the SELECT clause do not exist as far as clauses 
-- that are processed before the SELECT clause are concerned.

-- SQL provides the means to remove duplicates using the DISTINCT clause

-- SQL allows specifying an asterisk (*) in the SELECT list to request all attributes from the queried tables instead of listing them explicitly

-- Curiously, you are not allowed to refer to column aliases created in the SELECT clause in other expressions within the same SELECT clause.
-- beacuse of All at Once operation
---------------------------------------------------------------------

USE TSQLV4

SELECT empid                        
     , YEAR(orderdate) 'OrderYear'
	 , COUNT(*) 'NumOfOrders'
FROM Sales.Orders                   
WHERE custid = 71                   
GROUP BY empid, YEAR(orderdate)     
HAVING COUNT(*) > 1                 
