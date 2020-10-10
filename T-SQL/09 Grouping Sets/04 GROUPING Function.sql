

SELECT GROUPING(empid) 'GrpEmp'
     , GROUPING(custid) 'GrpCust'
	 , empid, custid, SUM(qty) 'SumQty'
FROM dbo.Orders
GROUP BY CUBE(empid, custid)
