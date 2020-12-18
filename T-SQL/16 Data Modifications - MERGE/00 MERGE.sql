
---------------------------------------------------------------------

-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- MERGE

-- T-SQL supports a statement called MERGE you can use to merge data from a source into a target, 
-- applying different actions (INSERT, UPDATE, and DELETE) based on conditional logic.

-- A task achieved by a single MERGE statement typically translates to a combination of several other DML statements (INSERT, UPDATE, and DELETE) without MERGE.

-- It’s mandatory to terminate the MERGE statement with a semicolon

-- Suppose you need to merge the contents of the CustomersStage table (the source) into the Customers table (the target)
-- More specifically, you need to add customers that do not exist and update the customers that do exist.

-- MERGE INTO : You specify the target table name in the MERGE clause 
-- USING      : You specify the source table name in the USING clause.
-- ON         : You define a merge condition by specifying a predicate in the ON clause.
-- WHEN MATCHED THEN UPDATE                : You define the UPDATE action to take when a match is found (a source row is matched by a target row) in a clause called WHEN MATCHED THEN clause.  
-- WHEN NOT MATCHED THEN INSERT            : You define the INSERT action to take when a match is not found (a source row is not matched by a target row) in the WHEN NOT MATCHED THEN clause.
-- WHEN NOT MATCHED BY SOURCE THEN DELETE  : You define the DELETE action to take when a target row is not matched by a source row in a clause called WHEN NOT MATCHED BY SOURCE THEN clause.

---------------------------------------------------------------------

USE TSQLV4
GO

DROP TABLE IF EXISTS dbo.Customers

CREATE TABLE dbo.Customers (
	custid       INT     
  , companyname  VARCHAR(25)
  , phone        VARCHAR(25)
  , address      VARCHAR(50)
)

SELECT * FROM dbo.Customers

INSERT INTO dbo.Customers (custid, companyname, phone, address)
VALUES (1, 'cust 1', '111 111-1111', 'address 1')
     , (2, 'cust 2', '222 222-2222', 'address 2')
	 , (3, 'cust 3', '333 333-3333', 'address 3')
	 , (4, 'cust 4', '444 444-4444', 'address 4')
	 , (5, 'cust 5', '555 555-5555', 'address 5')

DROP TABLE IF EXISTS dbo.CustomersStage

CREATE TABLE dbo.CustomersStage (
	custid       INT     
  , companyname  VARCHAR(25)
  , phone        VARCHAR(25)
  , address      VARCHAR(50)
)

SELECT * FROM dbo.CustomersStage

INSERT INTO dbo.CustomersStage (custid, companyname, phone, address)
VALUES (2, 'AAAAA' , '222 222-2222', 'address 2')
     , (3, 'cust 3', '333 333-3333', 'address 3')
	 , (5, 'BBBBB' , 'CCCC'        , 'DDDDD')
	 , (6, 'cust 6', '666 666-6666', 'address 6')
	 , (7, 'cust 7', '777 777-7777', 'address 7')



--1 : It doesn’t check whether column values are actually different before applying an update. 
--  : This means that a customer row is modified even when the source and target rows are identical. e.g. custid = 3
/*
Target    - MERGE INTO                 - dbo.Customers
Source    - USING                      - dbo.CustomersStage
Predicate - ON                         - custid
UPDATE    - WHEN MATCHED THEN          - source matched by target     - 2, 3, 5
INSERT    - WHEN NOT MATCHED THEN      - source not matched by target - 6, 7
DELETE    - WHEN NOT MATCHED BY SOURCE - target not natched by source - 1, 4
*/

MERGE INTO dbo.Customers TGT
USING dbo.CustomersStage SRC
ON SRC.custid = TGT.custid
WHEN MATCHED THEN
UPDATE
SET TGT.companyname = SRC.companyname
  , TGT.phone       = SRC.phone
  , TGT.address     = SRC.address
WHEN NOT MATCHED THEN
INSERT (custid, companyname, phone, address)
VALUES (SRC.custid, SRC.companyname, SRC.phone, SRC.address)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;
--(7 rows affected)


--2 : It does check whether column values are actually different before applying an update. 
--  : This means that a customer row is NOT modified when the source and target rows are identical. e.g. custid = 3
/*
Target    - MERGE INTO                 - dbo.Customers
Source    - USING                      - dbo.CustomersStage
Predicate - ON                         - custid
UPDATE    - WHEN MATCHED AND THEN      - source matched by target     - 2, 5
INSERT    - WHEN NOT MATCHED THEN      - source not matched by target - 6, 7
DELETE    - WHEN NOT MATCHED BY SOURCE - target not natched by source - 1, 4
*/
MERGE INTO dbo.Customers TGT
USING dbo.CustomersStage SRC
ON SRC.custid = TGT.custid
WHEN MATCHED AND (
	TGT.companyname <> SRC.companyname
 OR TGT.phone       <> SRC.phone
 OR TGT.address     <> SRC.address
) THEN
UPDATE
SET TGT.companyname = SRC.companyname
  , TGT.phone       = SRC.phone
  , TGT.address     = SRC.address
WHEN NOT MATCHED THEN
INSERT (custid, companyname, phone, address)
VALUES (SRC.custid, SRC.companyname, SRC.phone, SRC.address)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;
--(6 rows affected)