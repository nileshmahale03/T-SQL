---------------------------------------------------------------------
-- Logical query-processing phases
---------------------------------------------------------------------

(5)SELECT
	(5-1)<select_list>
	(5-2)DISTINCT
	(7)TOP
(1)FROM
	(1-J)<left_table> JOIN  (CROSS(1-J1), INNER(1-J2), LEFT OUTER(1-J3), RIGHT OUTER(1-J3), FULL OUTER(1-J3))
		(1-J1) Cartesian Product (1-J2) ON Predicate (1-J3) Add Outer ROWS
	(1-A)<left_table> APPLY (CROSS(1-A1), OUTER(1-A2))
		(1-A1) Apply Table Expression (1-A2) Add Outer Rows
	(1-P)<left_table> PIVOT
		(1-P1) Group (1-P2) Spread (1-P3) Aggregate
	(1-U)<left_table> UNPIVOT
		(1-U1) Generate Copies (1-U2) Extract Element (1-U3) Remove NULLs
(2)WHERE
(3)GROUP BY
(4)HAVING
(6)ORDER BY
(7)OFFSET _ ROWS FETCH NEXT _ ROWS ONLY

---------------------------------------------------------------------
-- Sample Query
---------------------------------------------------------------------

USE TSQLV4

--Could not drop object 'dbo.Customers' because it is referenced by a FOREIGN KEY constraint.
DROP TABLE IF EXISTS dbo.Orders
IF OBJECT_ID('dbo.Customers') IS NOT NULL DROP TABLE dbo.Customers

CREATE TABLE dbo.Customers
(
	CustID VARCHAR(5)  NOT NULL
  , City   VARCHAR(50) NOT NULL
  , CONSTRAINT PK_dboCustomers_CustID PRIMARY KEY(CustID)
)

CREATE TABLE dbo.Orders
(
	OrderID INT        NOT NULL
  , CustID  VARCHAR(5) NULL
  , CONSTRAINT PK_dboOrders_OrderID PRIMARY KEY(OrderID)
  , CONSTRAINT FK_dboOrders_CustID FOREIGN KEY(CustID) REFERENCES dbo.Customers(CustID)
)

INSERT INTO dbo.Customers(CustID, City)
VALUES ('FISSA', 'Madrid')
      ,('FRNDO', 'Madrid')
	  ,('KRLOS', 'Madrid')
	  ,('MRPHS', 'Zion')

-- The INSERT statement conflicted with the FOREIGN KEY constraint "FK_dboOrders_CustID". 
-- The conflict occurred in database "TSQLV4", table "dbo.Customers", column 'CustID'.
INSERT INTO dbo.Orders(OrderID, CustID)
VALUES (1, 'FRNDO')
      ,(2, 'FRNDO')
	  ,(3, 'KRLOS')
	  ,(4, 'KRLOS')
	  ,(5, 'KRLOS')
	  ,(6, 'MRPHS')
	  ,(7, NULL)

SELECT * FROM dbo.Customers
SELECT * FROM dbo.Orders

---------------------------------------------------------------------
-- Query: Madrid customers with fewer than three orders

-- The query returns customers from Madrid who placed fewer than
-- three orders (including zero), and their order count.
-- The result is sorted by the order count.
---------------------------------------------------------------------

SELECT C.CustID
     , COUNT(ALL O.OrderID) 'OrderCount'
FROM dbo.Customers C
LEFT JOIN dbo.Orders O ON C.CustID = O.CustID
WHERE C.City = 'Madrid'
GROUP BY C.CustID
HAVING COUNT(ALL O.OrderID) < 3
ORDER BY OrderCount
