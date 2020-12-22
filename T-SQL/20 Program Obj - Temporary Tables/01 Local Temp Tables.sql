
---------------------------------------------------------------------
-- Programmable objects

-- Temporary Tables

-- When you need to temporarily store data in tables, in certain cases you might prefer not to work with permanent tables.
-- Another case where people use temporary tables is when they don’t have permissions to create permanent tables in a user database.

-- T-SQL supports three kinds of temporary tables
-- 1. Local # Tables

-- You create a local temporary table by naming it with a single pound sign as a prefix, such as #T1.
-- Local # Tables temporary tables are created in the tempdb database.
-- A local temporary table is visible only to the session that created it. 
-- A local temporary table is destroyed automatically by SQL Server when the creating level in the call stack goes out of scope.
-- SQL Server internally adds a suffix to the table name that makes it unique in tempdb.

-- e.g. Proc 1 -> Proc 2 (#Tmp) -> Proc 3 -> Proc 4
-- In above case #Tmp is availbale to Proc 2, Proc 3, Proc 4 and gets dropped when Proc 2 finishes

-- Use Cases:
-- 1. when you have a process that needs to store intermediate results temporarily—such as during a loop—and later query the data.
-- 2. Another scenario is when you need to access the result of some expensive processing multiple times.

---------------------------------------------------------------------

USE TSQLV4
GO

SELECT empid, firstname, lastname
INTO #TmpEmp
FROM HR.Employees
WHERE firstname LIKE 'P%' 

--In other session - Invalid object name '#TmpEmp'.

SELECT * 
FROM #TmpEmp