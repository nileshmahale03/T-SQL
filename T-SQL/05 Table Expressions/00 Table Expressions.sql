
---------------------------------------------------------------------
-- Table Expressions

-- A table expression is a named query expression that represents a valid relational table.
-- Types - 1.Derived Tables 2.CTEs 3.VIEWs 4.Inline TVFs
-- Table expressions are not physically materialized anywhere—they are virtual.
-- The benefits of using table expressions are typically related to logical aspects of your code and not to performance.
-- Table expressions also help you circumvent certain restrictions in the language

-- Rule 1: Order is not guaranteed
-- Rule 2: All columns must have names
-- Rule 3: All column names must be unique

-- Derived Tables : Single-statement scope, not reusable
--                : Assigning column aliases
--                : Using arguments
--                : Nesting
--                : Multiple references

-- CTEs           : Single-statement scope, not reusable
--                : Assigning column aliases
--                : Using arguments 
--                : Defining multiple CTEs
--                : Multiple references  

-- VIEWs          : Definition are stored as permanent objects, reusable
--                : Because a view is an object in the database, you can manage access permissions similar to the way
--                  you do for tables. (These permissions include SELECT, INSERT, UPDATE, and DELETE.)
-- View option    : ENCRYPTION
--                : SCHEMABINDING
--                : CHECK OPTION

-- Inline TVFs    : Definition are stored as permanent objects, reusable
--                : Reusable table expressions that support input parameters. 
--                : Paramaterized views
---------------------------------------------------------------------
--Derived Table
SELECT * 
FROM (
	SELECT Col1, Col2 
	FROM dbo.TableName 
	WHERE Condition1 = Value1
) D


--CTE
;WITH CTE AS (
SELECT Col1  
     , COl2
FROM dbo.TableName
)
SELECT * 
FROM CTE


--Recursive CTEs
WITH<CTE_Name>[(<target_column_list>)]
AS
(
<anchor_member>
UNION ALL
<recursive_member>
)
<outer_query_against_CTE>;


--VIEW
CREATE VIEW [dbo].[VW_Name]
AS
	SELECT Col1
		 , Col2
		 , Col3
	FROM  dbo.TableName
GO


--Inline TVFs
CREATE FUNCTION <Inline_Function_Name, sysname, FunctionName> 
(	
	-- Add the parameters for the function here
	<@param1, sysname, @p1> <Data_Type_For_Param1, , int>, 
	<@param2, sysname, @p2> <Data_Type_For_Param2, , char>
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT 0
)
GO