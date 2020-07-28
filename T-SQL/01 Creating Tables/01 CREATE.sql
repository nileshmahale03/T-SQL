
-- CREATE TABLE

USE TSQLV4
GO

DROP SCHEMA IF EXISTS Test
GO

--'CREATE SCHEMA' must be the first statement in a query batch.
CREATE SCHEMA Test
GO
--'CREATE SCHEMA' must be the only statement in a query batch.

DROP TABLE IF EXISTS Test.Employees
CREATE TABLE Test.Employees
(
	EmpID      INT          NOT NULL
  , FirstName  VARCHAR(20)  NOT NULL
  ,	LastName   VARCHAR(20)  NOT NULL
  ,	BirthDate  DATE         NOT NULL
  ,	HireDate   DATE         NOT NULL
  ,	Phone      VARCHAR(10)  NULL
)

SELECT * FROM Test.Employees

INSERT INTO Test.Employees (EmpID, FirstName, LastName, BirthDate, HireDate, Phone)
VALUES (1, 'Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,(1, 'Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)

--Problem statament: Multiple employees with EmpID = 1
------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Test.Employees
CREATE TABLE Test.Employees
(
	EmpID      INT          NOT NULL IDENTITY(1,1)
  , FirstName  VARCHAR(20)  NOT NULL
  ,	LastName   VARCHAR(20)  NOT NULL
  ,	BirthDate  DATE         NOT NULL
  ,	HireDate   DATE         NOT NULL
  ,	Phone      VARCHAR(10)  NULL
)

SELECT * FROM Test.Employees

--Cannot insert explicit value for identity column in table 'Employees' when IDENTITY_INSERT is set to OFF.
INSERT INTO Test.Employees (EmpID, FirstName, LastName, BirthDate, HireDate, Phone)
VALUES (1, 'Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,(1, 'Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)

--1. Remove EmpID column from INSERT statement
INSERT INTO Test.Employees (FirstName, LastName, BirthDate, HireDate, Phone)
VALUES ('Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,('Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)

--2. SET IDENTITY_INSERT ON
SET IDENTITY_INSERT Test.Employees ON
INSERT INTO Test.Employees (EmpID, FirstName, LastName, BirthDate, HireDate, Phone)
VALUES (1, 'Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,(1, 'Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)
SET IDENTITY_INSERT Test.Employees OFF

--Problem statament: Multiple employees with EmpID = 1
------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Test.Employees
CREATE TABLE Test.Employees
(
	EmpID      INT          NOT NULL IDENTITY(1,1) PRIMARY KEY
  , FirstName  VARCHAR(20)  NOT NULL
  ,	LastName   VARCHAR(20)  NOT NULL
  ,	BirthDate  DATE         NOT NULL
  ,	HireDate   DATE         NOT NULL
  ,	Phone      VARCHAR(10)  NULL
)

SELECT * FROM Test.Employees

--Cannot insert explicit value for identity column in table 'Employees' when IDENTITY_INSERT is set to OFF.
INSERT INTO Test.Employees (EmpID, FirstName, LastName, BirthDate, HireDate, Phone)
VALUES (1, 'Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,(1, 'Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)

--1. Remove EmpID column from INSERT statement
INSERT INTO Test.Employees (FirstName, LastName, BirthDate, HireDate, Phone)
VALUES ('Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,('Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)

--2. SET IDENTITY_INSERT ON
--Violation of PRIMARY KEY constraint 'PK__Employee__AF2DBA79B09C19F9'. Cannot insert duplicate key in object 'Test.Employees'. 
--The duplicate key value is (1).
SET IDENTITY_INSERT Test.Employees ON
INSERT INTO Test.Employees (EmpID, FirstName, LastName, BirthDate, HireDate, Phone)
VALUES (1, 'Nilesh', 'Mahale', '1986-02-03', getdate(), NULL)
      ,(1, 'Madhuri', 'Nirmale', '1989-04-23', getdate(), NULL)
SET IDENTITY_INSERT Test.Employees OFF

------------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Test.Employees
CREATE TABLE Test.Employees
(
	EmpID      INT          NOT NULL IDENTITY(1,1) 
  , FirstName  VARCHAR(20)  NOT NULL
  ,	LastName   VARCHAR(20)  NOT NULL
  ,	BirthDate  DATE         NOT NULL
  ,	HireDate   DATE         NOT NULL CONSTRAINT DF_TestEmployees_HireDate DEFAULT (GETDATE())
  ,	Phone      VARCHAR(10)  NULL
  , CONSTRAINT PK_TestEmployees_EmpID PRIMARY KEY CLUSTERED (EmpID) ON [PRIMARY]
) ON [PRIMARY]

SELECT * FROM Test.Employees

INSERT INTO Test.Employees (FirstName, LastName, BirthDate)
VALUES ('Nilesh' , 'Mahale'    , '1986-02-03' )
      ,('Madhuri', 'Nirmale'   , '1989-04-23' )
	  ,('Rakesh' , 'Mahale'    , '1984-04-17' )
	  ,('Sonal'  , 'Chaudhari' , '1989-04-23' )


--Note: EmpID Column is PrimaryKey so you can not have 2 or multiple rows with same EmpID
--    : EmpID Column is Identity Column so if you don't provide a value for it, it will automatically increase 
------------------------------------------------------------------------------------------------------------------------------------------
USE TSQLV4
GO

ALTER DATABASE TSQLV4 
ADD FILEGROUP FG_TSQLV4_Dimension_Current

ALTER DATABASE TSQLV4
ADD FILE
(
   NAME = 'FG_TSQLV4_Dimension_Current.ndf'
 , FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FG_TSQLV4_Dimension_Current.ndf'
)
TO FILEGROUP FG_TSQLV4_Dimension_Current

ALTER DATABASE TSQLV4 
ADD FILEGROUP FG_TSQLV4_Dimension_History

ALTER DATABASE TSQLV4
ADD FILE
(
   NAME = 'FG_TSQLV4_Dimension_History.ndf'
 , FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FG_TSQLV4_Dimension_History.ndf'
)
TO FILEGROUP FG_TSQLV4_Dimension_History

ALTER DATABASE TSQLV4 
ADD FILEGROUP FG_TSQLV4_Dimension_Default

ALTER DATABASE TSQLV4
ADD FILE
(
   NAME = 'FG_TSQLV4_Dimension_Default.ndf'
 , FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FG_TSQLV4_Dimension_Default.ndf'
)
TO FILEGROUP FG_TSQLV4_Dimension_Default

CREATE PARTITION FUNCTION psDimensionRecordFlag (VARCHAR(10))
AS RANGE LEFT
FOR VALUES ('Current', 'History')

CREATE PARTITION SCHEME psDimensionRecordFlag
AS PARTITION psDimensionRecordFlag
TO (FG_TSQLV4_Dimension_Current, FG_TSQLV4_Dimension_History, FG_TSQLV4_Dimension_Default)

DROP TABLE IF EXISTS Test.EmployeesDim
CREATE TABLE Test.EmployeesDim
(
	EmpID      INT          NOT NULL IDENTITY(1,1) 
  , FirstName  VARCHAR(20)  NOT NULL
  ,	LastName   VARCHAR(20)  NOT NULL
  ,	BirthDate  DATE         NOT NULL
  ,	HireDate   DATE         NOT NULL CONSTRAINT DF_TestEmployeesDim_HireDate DEFAULT (GETDATE())
  ,	Phone      VARCHAR(10)  NULL
  , RecordFlag VARCHAR(10)  NOT NULL
  , CONSTRAINT PK_TestEmployeesDim_EmpID_RecordFlag PRIMARY KEY CLUSTERED (EmpID, RecordFlag) ON psDimensionRecordFlag(RecordFlag)
) ON psDimensionRecordFlag(RecordFlag)

SELECT * FROM Test.EmployeesDim

INSERT INTO Test.EmployeesDim (FirstName, LastName, BirthDate, RecordFlag)
VALUES ('Nilesh' , 'Mahale'    , '1986-02-03', 'Current' )
      ,('Madhuri', 'Nirmale'   , '1989-04-23', 'History' )
	  ,('Rakesh' , 'Mahale'    , '1984-04-17', 'Current' )
	  ,('Sonal'  , 'Chaudhari' , '1989-04-23', 'History' )
	  ,('Mayur' , 'Nirmale'    , '1991-02-19', 'Current' )
------------------------------------------------------------------------------------------------------------------------------------------

USE TSQLV4
GO

SELECT * 
FROM SYS.dm_db_partition_stats
WHERE OBJECT_ID = OBJECT_ID('Test.Employees')

SELECT * 
FROM SYS.dm_db_partition_stats
WHERE OBJECT_ID = OBJECT_ID('Test.EmployeesDim')

SELECT * FROM SYS.INDEXES
SELECT * FROM SYS.FILEGROUPS
SELECT * FROM SYS.DATABASE_FILES
SELECT * FROM SYS.DATA_SPACES
select * from sys.partition_functions
select * from sys.partition_schemes
select * from sys.objects WHERE is_ms_shipped != 1
select * from sys.partitions

SELECT sc.name + N'.' + so.name 'SchemaTable'
     , si.index_id 'IndexID'
     , si.type_desc 'Structure'
     , si.name 'Index'
	 , stat.row_count 'Rows'
     , d.physical_name 'DatabaseFileName'
     , stat.in_row_reserved_page_count * 8./1024./1024. 'In-RowGB'
     , stat.lob_reserved_page_count * 8./1024./1024. 'LOBGB'
	 , p.partition_number 'PartitionNumber'
	 , pf.name 'PartitionFunction'
     , CASE pf.boundary_value_on_right WHEN 1 then 'Right/Lower' ELSE 'Left/Upper' END 'BoundaryType'
     , prv.value 'BoundaryPoint'
	 , fg.name 'Filegroup'
FROM sys.objects so
LEFT JOIN sys.schemas sc on sc.schema_id = so.schema_id
LEFT JOIN sys.partitions p on so.object_id=p.object_id 
LEFT JOIN sys.indexes si on si.object_id=so.object_id and p.index_id=si.index_id
LEFT JOIN sys.allocation_units au on au.container_id = p.hobt_id
                                 and au.type_desc ='IN_ROW_DATA' 
LEFT JOIN sys.filegroups fg on fg.data_space_id = au.data_space_id
LEFT JOIN sys.database_files d on fg.[data_space_id] = d.[data_space_id]
LEFT JOIN sys.dm_db_partition_stats stat on stat.object_id=p.object_id
                                        and stat.index_id=p.index_id
                                        and stat.index_id=p.index_id and stat.partition_id=p.partition_id
                                        and stat.partition_number=p.partition_number
LEFT JOIN sys.partition_schemes ps on ps.data_space_id=si.data_space_id
LEFT JOIN sys.partition_functions pf on pf.function_id = ps.function_id
LEFT JOIN sys.partition_range_values prv on prv.function_id=pf.function_id
                                        and p.partition_number= CASE pf.boundary_value_on_right WHEN 1 THEN prv.boundary_id + 1 ELSE prv.boundary_id END
WHERE so.is_ms_shipped != 1 and so.type = 'U'
ORDER BY SchemaTable, IndexID, PartitionFunction, PartitionNumber
--WHERE so.object_id = 1509580416
