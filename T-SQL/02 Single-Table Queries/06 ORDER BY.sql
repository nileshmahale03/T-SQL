---------------------------------------------------------------------
-- ORDER BY

-- You use the ORDER BY clause to sort the rows in the output for presentation purposes.

-- The only way for you to guarantee the presentation order in the result is with an ORDER BY clause.

-- However, you should realize that if you do specify an ORDER BY clause, the result can’t qualify as a table because it is ordered. 
-- Standard SQL calls such a result a cursor.

-- Some language elements and operations in SQL expect to work with table results of queries and not with cursors. e.g. SET operators

-- ASC is the default. If you want to sort in descending order, you need to specify DESC after the expression

-- With T-SQL, you also can specify elements in the ORDER BY clause that do not appear in the SELECT clause, 
-- meaning you can sort by something you don’t necessarily want to return.

-- However, when the DISTINCT clause is specified, you are restricted in the ORDER BY list only to elements that appear in the SELECT list.
---------------------------------------------------------------------

USE TSQLV4

SELECT empid                        
     , YEAR(orderdate) 'OrderYear'
	 , COUNT(*) 'NumOfOrders'
FROM Sales.Orders                   
WHERE custid = 71                   
GROUP BY empid, YEAR(orderdate)     
HAVING COUNT(*) > 1   
ORDER BY empid, OrderYear; 