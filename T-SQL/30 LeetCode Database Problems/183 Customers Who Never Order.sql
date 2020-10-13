
/*---------------------------------------------------------------------
Exercise 183

Suppose that a website contains two tables, the Customers table and the Orders table. Write a SQL query to find all customers who never order anything.

Table: Customers.

+----+-------+
| Id | Name  |
+----+-------+
| 1  | Joe   |
| 2  | Henry |
| 3  | Sam   |
| 4  | Max   |
+----+-------+
Table: Orders.

+----+------------+
| Id | CustomerId |
+----+------------+
| 1  | 3          |
| 2  | 1          |
+----+------------+
Using the above tables as example, return the following:

+-----------+
| Customers |
+-----------+
| Henry     |
| Max       |
+-----------+

*/---------------------------------------------------------------------
USE QuestionBank
Go

DROP TABLE IF EXISTS dbo.Customers 
GO
DROP TABLE IF EXISTS dbo.Orders 
GO

CREATE TABLE dbo.Customers (
	Id   INT         NOT NULL IDENTITY(1,1)
  , Name VARCHAR(10) NOT NULL
  CONSTRAINT PK_dbo_Customers_Id PRIMARY KEY (Id)
)

CREATE TABLE dbo.Orders (
	Id         INT NOT NULL IDENTITY(1,1)
  , CustomerId INT NOT NULL
  CONSTRAINT PK_dbo_Orders_Id PRIMARY KEY (Id)
)

INSERT INTO dbo.Customers(Name)
VALUES ('Joe')
     , ('Henry')
	 , ('Sam')
	 , ('Max')

INSERT INTO dbo.Orders(CustomerId)
VALUES (3)
      ,(1)

SELECT * FROM dbo.Customers
SELECT * FROM dbo.Orders

--1.
SELECT * 
FROM dbo.Customers C
LEFT JOIN dbo.Orders O ON O.CustomerId = C.Id
WHERE O.CustomerId IS NULL