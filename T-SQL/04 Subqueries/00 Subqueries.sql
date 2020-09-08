
---------------------------------------------------------------------
-- Subqueries

-- SQL supports writing queries within queries, or nesting queries
-- When you use subqueries, you avoid the need for seperate steps in your solution that store intermediate query results in variables. 

-- A subquery can either be self-contained or correlated. 
-- A self-conatined subquery has no dependency on tables from the outer query, wheras a correlated subquey does. 

-- A subquey can be single-valued, multivalued or table-valued. 
-- Scalar       : SELECT, WHERE
-- Multi-valued : WHERE
-- Table-valued : FROM 

-- You're likely to stumble into many other querying problems you can solve with either subqueries or joins. 
-- I don't know a reliable rule of a thumb that says a subquery is better than a join or other way around. 
-- In some cases the database engine optimizes both the same way, sometimes joins perform better, sometime subqueries perform better. 
-- My approcah is to first write a solution query that is intuitive and then, if performance is not satisfactory, try query revisions among other tuning methods

---------------------------------------------------------------------


