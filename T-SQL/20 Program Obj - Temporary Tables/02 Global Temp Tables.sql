
---------------------------------------------------------------------
-- Programmable objects

-- Temporary Tables

-- When you need to temporarily store data in tables, in certain cases you might prefer not to work with permanent tables.
-- Another case where people use temporary tables is when they don’t have permissions to create permanent tables in a user database.

-- T-SQL supports three kinds of temporary tables
-- 2. Global ## Tables

-- You create a global temporary table by naming it with a two pound sign as a prefix, such as ##T1.
-- Global ## Tables temporary tables are created in the tempdb database.
-- A global temporary table is visible to all other sessions. 
-- Global temporary tables are destroyed automatically by SQL Server when the creating session disconnects and there are no active references to the table.
-- SQL Server don't need to internally adds a suffix to the table name that makes it unique in tempdb.

-- Use Cases:
-- 1. Global temporary tables are useful when you want to share temporary data with everyone.

---------------------------------------------------------------------

USE TSQLV4
GO

SELECT empid, firstname, lastname
INTO ##TmpEmp
FROM HR.Employees
WHERE firstname LIKE 'P%' 

--In other session - Invalid object name '#TmpEmp'.