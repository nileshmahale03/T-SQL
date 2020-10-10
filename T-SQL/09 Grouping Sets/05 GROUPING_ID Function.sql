

SELECT GROUPING_ID(empid, custid) 'GrpID'
	 , empid, custid, SUM(qty) 'SumQty'
FROM dbo.Orders
GROUP BY CUBE(empid, custid)