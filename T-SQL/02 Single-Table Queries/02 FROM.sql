USE AdventureWorksDW2017

SELECT * 
FROM dbo.DimCustomer

SELECT CustomerKey
     , FirstName
	 , LastName
	 , BirthDate
	 , Gender
	 , EmailAddress
	 , AddressLine1
	 , Phone
FROM dbo.DimCustomer

SELECT COUNT(*)
FROM dbo.DimCustomer

SELECT COUNT(1)
FROM dbo.DimCustomer

SELECT COUNT(29)
FROM dbo.DimCustomer

SELECT COUNT(123)
FROM dbo.DimCustomer

SELECT COUNT(FirstName)
FROM dbo.DimCustomer

SELECT COUNT(ALL FirstName)
FROM dbo.DimCustomer

SELECT COUNT(DISTINCT FirstName)
FROM dbo.DimCustomer