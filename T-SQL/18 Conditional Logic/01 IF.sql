
---------------------------------------------------------------------
-- Conditional Logic

-- You use flow elements to control the flow of your code.

-- 1. IF

-- You use the IF . . . ELSE element to control the flow of your code based on the result of a predicate.
-- If you need to run more than one statement in the IF or ELSE sections, you need to use a statement block. 
-- You mark the boundaries of a statement block with the BEGIN and END keywords.

---------------------------------------------------------------------

USE TSQLV4
GO

DECLARE @a INT = 5
DECLARE @b INT = 5

-- 1. IF
IF @a > @b
PRINT 'a is greater than b'

