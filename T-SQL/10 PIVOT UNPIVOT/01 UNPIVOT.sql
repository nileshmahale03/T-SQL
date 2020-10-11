
---------------------------------------------------------------------
-- UNPIVOT

-- Unpivoting is a technique that rotates data from a state of columns to a state of rows
-- A common use case is to unpivot data you imported from a spreadsheet into the database for easier manipulation.

-- 1. unpivoting with the CROSS APPLY VALUES operator
-- 2. unpivoting with the UNPIVOT operator

-- Unpivoting involves 
--                     1.Producing copies
--                     2.extracting values
--                     3.eliminating irrelevant rows

-- When you need to apply the third phase, it’s convenient to use the solution with the UNPIVOT operator because it’s more concise. 
-- When you need to keep the rows with the NULLs, use the solution with the APPLY operator.
---------------------------------------------------------------------

USE TSQLV4
GO

DROP TABLE IF EXISTS dbo.EmpCustOrders

CREATE TABLE dbo.EmpCustOrders
(
	empid INT        NOT NULL CONSTRAINT PK_EmpCustOrders PRIMARY KEY,
	A     VARCHAR(5) NULL,
	B     VARCHAR(5) NULL,
	C     VARCHAR(5) NULL,
	D     VARCHAR(5) NULL
);

INSERT INTO dbo.EmpCustOrders(empid, A, B, C, D)
SELECT empid, A, B, C, D
FROM (SELECT empid, custid, qty
FROM dbo.Orders) AS D
PIVOT(SUM(qty) FOR custid IN(A, B, C, D)) AS P

SELECT * FROM dbo.EmpCustOrders

---------------------------------------------------------------------
-- 1. unpivoting with the CROSS APPLY VALUES operator
---------------------------------------------------------------------

SELECT * 
FROM dbo.EmpCustOrders
CROSS JOIN ( VALUES ('A')
                   ,('B')
				   ,('C')
				   ,('D')
) C(custid)

SELECT * 
FROM dbo.EmpCustOrders
CROSS JOIN ( VALUES ('A', A)
                   ,('B', B)
				   ,('C', C)
				   ,('D', D)
) C(custid, qty)

SELECT * 
FROM dbo.EmpCustOrders
CROSS APPLY ( VALUES ('A', A)
                    ,('B', B)
				    ,('C', C)
				    ,('D', D)
) C(custid, qty)

CREATE TABLE C (
	custid VARCHAR(5) not null
   ,qty    INT 
)
INSERT INTO c (custid, qty)
VALUES ('A', A)

SELECT empid, custid, qty 
FROM dbo.EmpCustOrders
CROSS APPLY ( VALUES ('A', A)
                    ,('B', B)
				    ,('C', C)
				    ,('D', D)
) C(custid, qty)
WHERE qty IS NOT NULL

---------------------------------------------------------------------
-- 2. unpivoting with the UNPIVOT operator
/*
SELECT ...
FROM <input_table>
UNPIVOT(<values_column> FOR <names_column> IN(<source_columns>)) AS <result_table_alias>
WHERE ...;
*/
---------------------------------------------------------------------

SELECT empid, custid, qty
FROM dbo.EmpCustOrders
UNPIVOT(qty FOR custid IN(A, B, C, D)) U
