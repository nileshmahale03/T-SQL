
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- OUTPUT Clause (Not a statement)

-- Normally, a modification statement just modifies data. 
-- However, sometimes you might find it useful to return information from the modified rows for troubleshooting, auditing, and archiving. 
-- T-SQL supports this capability via a clause called OUTPUT that you add to the modification statement.

-- The OUTPUT clause is designed similarly to the SELECT clause, only you need to prefix the attributes with either the inserted or deleted keyword.
-- In an INSERT statement, you refer to inserted; 
-- In a DELETE statement, you refer to deleted; and 
-- In an UPDATE statement, you refer to deleted for the old state of the row and inserted for the new state.
-- In an MERGE statement, to identify which DML action produced each output row, you can invoke a function called $action in the OUTPUT clause, 
--                        which will return a string representing the action (INSERT, UPDATE, or DELETE).

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
OUTPUT inserted.custid, inserted.companyname, inserted.phone, inserted.address
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
--WHEN NOT MATCHED BY SOURCE THEN
--DELETE
OUTPUT $action
     , inserted.custid
     , inserted.companyname
	 , inserted.phone
	 , inserted.address
     , deleted.custid 'old_custid'
     , deleted.companyname 'old_companyname'
	 , deleted.phone 'old_phone'
	 , deleted.address 'old_address'; 
