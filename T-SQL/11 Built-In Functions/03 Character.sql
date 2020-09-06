---------------------------------------------------------------------
-- Functions
---------------------------------------------------------------------
USE TSQLV4

--1. String Concatenation
-- concatenation with a NULL should yield a NULL.
-- T-SQL supports a function called CONCAT that accepts a list of inputs for concatenation and automatically substitutes NULLs with empty strings.

SELECT empid
     , firstname + ' ' + lastname 'FullName'
	 , country + ' ' + region + ' ' + city 'Location'
	 , country + ' ' + ISNULL(region, '') + ' ' + city 'Location'  
	 , country + ' ' + COALESCE(region, '') + ' ' + city 'Location' 
	 , CONCAT(country, ' ', region, ' ', city) 'Location'
FROM HR.Employees;

--2. SUBSTRING
-- The SUBSTRING function extracts a substring from a string.
-- This can be convenient when you want to return everything from a certain point until the end of the string

SELECT 'Nilesh Mahale' 'String'
     , SUBSTRING('Nilesh Mahale', 1, 3) 'Substring'

--3. LEFT, RIGHT
-- The LEFT and RIGHT functions are abbreviations of the SUBSTRING function,
-- returning a requested number of characters from the left or right end of the input string.

SELECT empid
     , firstname
	 , lastname
     , LEFT(firstname, 3) 'LEFT3'
	 , RIGHT(lastname, 3) 'RIGHT3'
FROM HR.Employees;

--4. LEN, DATALENGTH
-- The LEN function returns the number of characters in the input string.
-- With regular characters, both numbers are the same because each character requires 1 byte of storage. 
-- With Unicode characters, each character requires at least 2 bytes of storage therefore, the number of characters is half the number of bytes.
-- Another difference between LEN and DATALENGTH is that the former excludes trailing blanks but the latter doesn’t.

SELECT empid
     , firstname
	 , lastname
     , LEN(firstname)         'LEN'
	 , DATALENGTH(firstname)  'DATALENGTH'
	 , LEN('Nilesh ')         'RegularCharacterLEN'
	 , DATALENGTH('Nilesh ')  'RegularCharacterDATALENGTH'
	 , LEN(N'Nilesh ')        'UnicodeCharacterLEN'
	 , DATALENGTH(N'Nilesh ') 'UnicodeCharacterDATALENGTH'
FROM HR.Employees;

--5. CHARINDEX
-- The CHARINDEX function returns the position of the first occurrence of a substring within a string.

SELECT 'Nilesh Mahale' 'String'
     , CHARINDEX('e', 'Nilesh Mahale', 0) 'CHARINDEX'
	 , CHARINDEX('le', 'Nilesh Mahale', 0) 'CHARINDEX'
	 , CHARINDEX('ale', 'Nilesh Mahale', 0) 'CHARINDEX'

--6. PATINDEX
-- The PATINDEX function returns the position of the first occurrence of a pattern within a string.

SELECT 'Nilesh Mahale 03' 'String'
     , PATINDEX('%le%', 'Nilesh Mahale 03') 'PATINDEX'
	 , PATINDEX('%[0-9]%', 'Nilesh Mahale 03') 'PATINDEX'

--7. REPLACE
-- The REPLACE function replaces all occurrences of a substring with another.
-- You can use the REPLACE function to count the number of occurrences of a character within a string.

SELECT '805:824:5589' 'PhoneNumber'
     , REPLACE('805:824:5589', ':', '-') 'REPLACE'

--8. REPLICATE
-- The REPLICATE function replicates a string a requested number of times.

SELECT REPLICATE('abc', 3)

SELECT supplierid
     , 9 - LEN(supplierid)
	 , REPLICATE('0', 9 - LEN(supplierid))
	 , CAST(REPLICATE('0', 9 - LEN(supplierid)) AS VARCHAR(9)) + CAST(supplierid AS VARCHAR(9)) '1'
	 , RIGHT(REPLICATE('0', 9) + CAST(supplierid AS VARCHAR(10)), 9) '2'
	 , FORMAT(supplierid, '000000000') '3'
FROM Production.Suppliers;

--9. STUFF
-- You use the STUFF function to remove a substring from a string and insert a new substring instead.

SELECT STUFF('xyz', 2, 1, 'abc')
     , STUFF('xyz', 2, 0, 'abc');

--10. UPPER and LOWER
-- The UPPER and LOWER functions return the input string with all uppercase or lowercase characters, respectively.

SELECT UPPER('Nilesh Mahale')
     , LOWER('Nilesh Mahale');

--11. RTRIM and LTRIM
-- The RTRIM and LTRIM functions return the input string with leading or trailing spaces removed.

SELECT RTRIM('   Nilesh Mahale   ')
     , LTRIM('   Nilesh Mahale   ');

--12. FORMAT
-- You use the FORMAT function to format an input value as a character string based on a Microsoft .NET 
-- format string and an optional culture specification

SELECT supplierid
	 , FORMAT(supplierid, '000000000') 'FORMAT'
FROM Production.Suppliers;

--13. COMPRESS and DECOMPRESS
-- The COMPRESS and DECOMPRESS functions use the GZIP algorithm to compress and decompress the input, respectively. 
-- Both functions were introduced in SQL Server 2016.

SELECT COMPRESS('This is my cv. Imagine it was much longer.');
SELECT CAST(DECOMPRESS(COMPRESS('This is my cv. Imagine it was much longer.')) AS VARCHAR(MAX));

--14. STRING_SPLIT
-- The STRING_SPLIT table function splits an input string with a separated list of values into the individual elements. 
-- This function was introduced in SQL Server 2016.
-- Unlike the string functions described so far, which are all scalar functions, the STRING_SPLIT function is a table function.

SELECT ('Los Angeles, Oxnard, Newbury Park, Buena Park')
 
SELECT * FROM STRING_SPLIT('Los Angeles, Oxnard, Newbury Park, Buena Park', ',')