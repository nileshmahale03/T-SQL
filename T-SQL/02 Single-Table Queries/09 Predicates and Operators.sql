---------------------------------------------------------------------
-- Predicates and Operators
---------------------------------------------------------------------

IN
BETWEEN 
LIKE

Comparison Operator: =, >, <, >=, <=, <>, !=, !>, !<

Logical Operator: OR, AND, NOT

Arithmetic Operator: +, -, *, /, %

---------------------------------------------------------------------
-- LIKE Predicate
-- T-SQL provides a predicate called LIKE that you can use to check whether a character string matches a specified pattern.
---------------------------------------------------------------------
USE TSQLV4

--1. %(percent) wildcard
-- The percent sign represents a string of any size, including an empty string.

SELECT empid
     , lastname
FROM HR.Employees
WHERE lastname LIKE 'D%';

SELECT empid
     , lastname
FROM HR.Employees
WHERE LEFT(lastname, 1) = 'D'

--2. _(underscore) wildcard
-- An underscore represents a single character.

SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE '_e%';

--3. [] wildcard
-- Square brackets with a list of characters (such as [ABC]) represent a single character that must be one of the characters specified in the list.

SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE '[ABC]%';

--4. [-] wildcard
-- Square brackets with a character range (such as [A-E]) represent a single character that must be within the specified range.

SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE '[A-E]%';

--5. [^] wildcard
-- Square brackets with a caret sign (^) followed by a character list or range (such as [^A-E]) 
-- represent a single character that is not in the specified character list or range.

SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE '[^A-E]%';

--6. ESCAPE character
-- If you want to search for a character that is also used as a wildcard (such as %, _, [, or ]), you can use an escape character.

UPDATE E
SET lastname = 'Fu_nk'
FROM HR.Employees E
WHERE lastname = 'Funk'

SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE '%_%'

SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE '%&_%' ESCAPE '&'

SELECT empid, lastname
FROM HR.Employees
WHERE lastname LIKE '%[_]%'