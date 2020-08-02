---------------------------------------------------------------------
--CREATE TABLE ON PRIMARY
---------------------------------------------------------------------
CREATE TABLE Schema.Table_Name
(
	Column1 datatype NOT NULL IDENTITY(1,1)
  , Column2 datatype NOT NULL
  , Column3 datatype NOT NULL
  , Column4 datatype NOT NULL
  CONSTRAINT PK_SChema_Table_Name PRIMARY KEY(Column1)
) ON [PRIMARY]

---------------------------------------------------------------------
--CREATE TABLE ON PARTITION SCHEME
---------------------------------------------------------------------
CREATE TABLE Schema.Table_Name
(
	Column1 datatype NOT NULL IDENTITY(1,1)
  , Column2 datatype NOT NULL
  , Column3 datatype NOT NULL
  , Column4 datatype NOT NULL
  CONSTRAINT PK_SChema_Table_Name PRIMARY KEY(Column1)
) ON partitionScheme(Column4)

---------------------------------------------------------------------
--ALTER TABLE - ADD COLUMN
---------------------------------------------------------------------
ALTER TABLE Schema.Table_Name ADD Column5 datatype

---------------------------------------------------------------------
--ALTER TABLE - ALTER COLUMN
---------------------------------------------------------------------
ALTER TABLE Schema.Table_Name ALTER COLUMN Column5 new_datatype

---------------------------------------------------------------------
--ALTER TABLE - DROP COLUMN
---------------------------------------------------------------------
ALTER TABLE Schema.Table_Name DROP COLUMN Column5

---------------------------------------------------------------------
--DROP TABLE 
---------------------------------------------------------------------
DROP TABLE Schema.Table_Name