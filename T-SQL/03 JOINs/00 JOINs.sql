
---------------------------------------------------------------------
-- JOIN

-- A JOIN table operator operates on two input tables
-- The 3 fundamental types of the joins are CROSS JOINS, INNER JOINS and OUTER JOINS. 
-- These 3 types of joins differ in how they apply their logical query processing phases. 

-- CROSS JOIN = 1 Phase = Cartesian Product
-- INNER JOIN = 2 Phase = Cartesian Product + Filter on ON Predicate
-- OUTER JOIN = 3 Phase = Cartesian Product + Filter + Add Outer ROWS

-- Self Join
-- Composite Joins
-- Non-equi Joins
---------------------------------------------------------------------
SELECT <select_list>
FROM <left_input_table>
{CROSS | INNER | OUTER} JOIN <right_input_table> ON <on_predicate>