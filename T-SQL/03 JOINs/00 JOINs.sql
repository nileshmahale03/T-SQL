
---------------------------------------------------------------------
-- JOIN

-- A JOIN table operator operates on two input tables
-- The 3 fundamental types of the joins are CROSS JOINS, INNER JOINS and OUTER JOINS. 
-- These 3 types of joins differ in how they apply their logical query processing phases. 

-- CROSS JOIN = 1 Phase = Cartesian Product
-- INNER JOIN = 2 Phase = Cartesian Product + Filter on ON Predicate
-- OUTER JOIN = 3 Phase = Cartesian Product + Filter + Add Outer ROWS

-- Self Join          : You can join multiple instances of the same table. This capability is known as a self join and is supported with all fundamental join types
-- Composite Joins    : A composite join is simply a join where you need to match multiple attributes from each side.
-- Non-equi Joins     : When a join condition involves any operator besides equality, the join is said to be a non-equi join.
-- Multi-join queries : When more than 1 table operator appears in the FROM clause, the table operators are logically processed from LEFT to RIGHT
---------------------------------------------------------------------
SELECT <select_list>
FROM <left_input_table>
{CROSS | INNER | OUTER} JOIN <right_input_table> ON <on_predicate>


---------------------------------------------------------------------
-- Beyond the fundamentals of outer joins

--1. Including missing values 
--   You can use outer joins to identify and include missing values when querying data.

--2. Filtering attributes from the nonpreserved side of an outer join
--   When you need to review code involving outer joins to look for logical bugs, one of the things you should examine is the WHERE clause. 
--   If the predicate in the WHERE clause refers to an attribute from the nonpreserved side of the join using an expression 
--   in the form <attribute> <operator> <value>, it’s usually an indication of a bug.

--3. Using outer joins in a multi-join query
--   Suppose you write a multi-join query with an outer join between two tables, followed by an inner join with a third table. 
--   If the predicate in the inner join’s ON clause compares an attribute from the nonpreserved side of the outer join and an attribute from the third table, all outer rows are discarded.

--4. Using the COUNT aggregate with outer joins
--   To fix the problem, you should use COUNT(<column>) instead of COUNT(*) and provide a column from the nonpreserved side of the join.
---------------------------------------------------------------------
