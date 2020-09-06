
-- ==========================================================================================
/*
0.SQL
	a.DDL
		i.CREATE
		ii.ALTER
		iii.DROP
	b.DML
		i.SELECT
		ii.INSERT
		iii.UPDATE
		iv.DELETE
		v.TRUNCATE
		vi.MERGE
	c.DCL
		i.GRANT
		ii.REVOKE
    d.Relational Model
		i.Set Theory
		ii.Predicate Logic
		iii.Missing values
		iv.Constraint
			a.entity 
			b.referential 
		v.Normalization
			a.1NF
			b.2NF
			c.3NF
		vi.Types of database systems
			a.OLTP
			b.DSA
			C.DWs
		vii.Database
			a.System Database
			b.User Database
				i. Primary Filegroup .mdf
				ii. User Filegroups .ndf
				iii. Memory Optimized Filegroup 
				iv. Log File .ldf
		viii.Schemas and Objects

1.Creating Tables and Defining Data Integrity
	a.CREATE/ALTER/DROP/RENAME

2.SELECT Statement
	a.FROM
	b.WHERE
	c.GROUP BY
	d.HAVING
	e.SELECT
		i.Expressions
		ii.Functions
		iii.TOP
		iv.DISTINCT
	f.ORDER BY
	g.TOP
	h.OFFSET-FETCH

	Predicates and Operators
	LIKE Predicate
	CASE Expressions

3.JOIN
	a.CROSS JOIN
	b.INNER JOIN
	c.OUTER JOIN
		i.LEFT OUTER JOIN
		ii.RIGHT OUTER JOIN
	d.SELF JOIN
	e.NON-EQUI JOINS
	f.COMPOSITE JOINS

4.Sub-Query
	a.IN
	b.NOT IN
	c.EXITS
	d.NOT EXISTS

	a.Self Contained
		i.Scalar
		ii.Multivalue
	b.Correlated
		i.Scalar
		ii.Multivalue

5.Table Expressions
	a.Derived Table
	b.CTEs
	c.Views
	d.Inline Table-valued Functions

6.APPLY
	a. CROSS APPLY
	b. OUTER APPLY

7.SET
	a.UNION (DISTINCT)
	b.UNION ALL
	c.INTERSECT
	d.EXCEPT

8.Window Functions
	a.RANKING
		i.ROW_NUMBER()
		ii.RANK
		iii.DENSE_RANK
		iv.NTILE
	b.AGGREGATE
		i.SUM
		ii.MIN
		iii.MAX
		iv.COUNT
		v.AVG
	c.ANALYTICAL
		i.FIRST_VALUE & LAST_VALUE
		ii.LAG & LEAD
		iii.CUME_DIST
		iv.PERCENTILE_CONT
		v.PERCENTILE_DISC
		vi.PERCENT_RANK

9.PIVOT

10.UNPIVOT

11.System Functions
	Date and Time
		GETDATE, CURRENT_TIMESTAMP
		DATEPART, DATENAME, DAY/MONTH/YEAR, DATEFROMPARTS, EOMONTH
		DATEADD, DATEDIFF
	Type Conversion
		CAST/CONVERT, PARSE, TRY_CAST/TRY_CONVERT/TRY_PARSE, FORMAT
	Character
		CONCAT: CONCAT
		Substring Extraction and position: SUBSTRING, left/right, CHARINDEX, PATINDEX
		String length: len, DATALENGTH
		String Alteration: replace, replicate, STUFF
		String Formatting: lower/upper, RTRIM/LTRIM, FORMAT
		String Splitting: STRING_SPLIT
	CASE Expression Abbreviation: ISNULL/COALESCE,NULLIF, IIF, CHOOSE
	Misc. object_id(), HASHBYTES, CHECKSUM

     
12.INSERT
	a.INSERT INTO
		i.VALUES
		ii.SELECT
	b.INSERT EXEC
	c.SELECT INTO	
	d.BULK INSERT

13.UPDATE

14.DELETE

15.TRUNCATE

16.MERGE

17.OUTPUT

18.Conditional Logic
	a.IF
	b.IF ELSE
	c.IF EXISTS
	d.DROP [] IF EXISTS
	e.WHILE
	f.WHILE EXISTS

19.Variables

20.Temporary Tables
	a.Local
	b.Global
	c.Table Variables
	d.Table Types

21.User Defined Functions
	Scalar Function 
	Table-valued Functions
			a. Inline - 
			b. Multi-Statement
	DETERMINSTIC
	NON-DETEMINISTIC

22.Stored Procedures

23.Triggers

24.DYNAMIC SQL

25.CURSORS

26.Transaction
	a. AutoCommit
	b. Implicit
	c. Explicit 

27.Error
	a. @@ERROR
	b. TRY/CATCH
	c. RAISERROR

28.XML
	a. XML RAW
	b. XML AUTO 
	c. XML PATH
		6. XQUERY
		   1.QUERY
		   2.VALUE

29.JSON


*/
-- ==========================================================================================