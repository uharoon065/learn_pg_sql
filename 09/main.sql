--  lecture 1
--  syntax
--  "The basic syntax of the subquery is as follows:
SELECT 
  select_list 
FROM 
  table1 
WHERE 
  columnA operator (
    SELECT 
      columnB 
    from 
      table2 
    WHERE 
      condition
  );"
--    first the database executes the inner query and the result of the  inner query is feed to the main query.
--  statement 
-- The visible message reads: "List the name and price of all products that are more expensive than all products in the 'Toys' department."
--  To achieve this, we only need to compare against the most expensive item in the 'Toys' department. This is because if a product is more expensive than the highest-priced item in the 'Toys' department, it will automatically be more expensive than all other items in that department.
--  FIRST  finding the most expensive item   in toys department.
SELECT department,  name,  price FROM products WHERE LOWER(department) = 'toys' ORDER BY price DESC LIMIT 1;

--  now  if you wanna find and compare  that most expensive item  to every other item  we are  using two quries .  In order to acheive that we uses subqueries.  to perform a subquery we simplysimply wrapp the inner quyery in set of parantheses"()"."
SELECT department,name,price FROM products  WHERE   price >  (SELECT MAX(price)  FROM products  WHERE LOWER(department) ='toys' );
--   example 1
--  here we are trying to find all the cities which belongs to united states. For that first we needed United states ID from countries table  for that we are using subquery instead of making a seperated query.
SELECT city FROM cities  WHERE  country_id= (SELECT country_id FROM countries  WHERE  country='united states')