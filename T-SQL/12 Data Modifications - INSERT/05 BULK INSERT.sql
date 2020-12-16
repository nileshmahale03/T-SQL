
---------------------------------------------------------------------
-- DML (Data Modification & Retrieval)
-- DML includes the statements SELECT, INSERT, UPDATE, DELETE, TRUNCATE, and MERGE.

-- INSERT

-- 5. BULK INSERT

-- You use the BULK INSERT statement to insert into an existing table data originating from a file
-- In thestatement, you specify the target table, the source file, and options.

---------------------------------------------------------------------
USE TSQLV4
GO

SELECT * FROM dbo.Orders

BULK INSERT dbo.Orders
FROM 'C:\Users\Nilesh\OneDrive - California State University, Northridge\FILES\documents\ZD. ebook\SQL\Certification\2. MCSA SQL 2016 Database Development\70-761 Querying Data with Transact-SQL\TSQLFundamentals20160601\orders.txt'
WITH (
	--DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
)