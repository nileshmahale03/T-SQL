
---------------------------------------------------------------------
-- Conditional Logic

-- You use flow elements to control the flow of your code.

-- 5. WHILE 

WHILE condition
BEGIN
   {...statements...}
END

-- T-SQL provides the WHILE element, which you can use to execute code in a loop
-- The WHILE element executes a statement or statement block repeatedly while the predicate you specify after the WHILE keyword is TRUE. 
-- When the predicate is FALSE or UNKNOWN, the loop terminates.

-- BREAK: If at some point in the loop’s body you want to break out of the current loop and proceed to execute the statement that appears after the loop’s body, use the BREAK command.
-- CONTINUE: If at some point in the loop’s body you want to skip the rest of the activity in the current iteration and evaluate the loop’s predicate again, use the CONTINUE command.

---------------------------------------------------------------------

USE TSQLV4
GO

--1 : PRINT 1 to 10
DECLARE @i INT = 1
WHILE @i <= 10
BEGIN
	PRINT @i
	SET @i = @i + 1
END
GO

--2 : PRINT 1 to 10 but then break at 6
DECLARE @i INT = 1
WHILE @i <= 10
BEGIN
    IF @i = 6 BREAK
	PRINT @i
	SET @i = @i + 1
END
GO

--3 : PRINT 1 to 10 but skip 6
DECLARE @i INT = 0
WHILE @i < 10
BEGIN
	SET @i = @i + 1
	IF @i = 6 CONTINUE
	PRINT @i
END
GO

--4
DECLARE @i INT = 1

DROP TABLE IF EXISTS dbo.Number
CREATE TABLE dbo.Number (
	Number INT 
)
WHILE @i <= 100
BEGIN
	INSERT INTO dbo.Number (Number)
	VALUES (@i)
	SET @i = @i + 1
END

SELECT * FROM dbo.Number