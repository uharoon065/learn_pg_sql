--  lecture 1
--  syntax
--  "The basic syntax of the subquery is as follows:
/*
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
  */
--    first the database executes the inner query and the result of the  inner query is feed to the main query.
--  statement 
-- The visible message reads: "List the name and price of all products that are more expensive than all products in the 'Toys' department."
--  To achieve this, we only need to compare against the most expensive item in the 'Toys' department. This is because if a product is more expensive than the highest-priced item in the 'Toys' department, it will automatically be more expensive than all other items in that department.
--  FIRST  finding the most expensive item   in toys department.
-- SELECT department,  name,  price FROM products WHERE LOWER(department) = 'toys' ORDER BY price DESC LIMIT 1;

--  now  if you wanna find and compare  that most expensive item  to every other item  we are  using two quries .  In order to acheive that we uses subqueries.  to perform a subquery we simplysimply wrapp the inner quyery in set of parantheses"()"."
SELECT department,name,price FROM products  WHERE   price >  (SELECT MAX(price)  FROM products  WHERE LOWER(department) ='toys' );
--   example 1
--  here we are trying to find all the cities which belongs to united states. For that first we needed United states ID from countries table  for that we are using subquery instead of making a seperated query.
SELECT city FROM cities  WHERE  country_id= (SELECT country_id FROM countries  WHERE  country='united states')

--  lecture 2
--  the sub  queries has 3 uses .
--  source of rows , source of columns and source of value.
--  example
--  select p1.price , (select count(name) from products) from   (select * from products ) join as p1 join (select * from products ) as p2 on p1.id=p2.id where  p1.id in (select id from products);
--  the "source of value " returns single   row  in this case (select  count(name )from products ) will return   total number of names in products column.
--  so when a query returns a  single row and column this is known as scalur query.
--  this will be wrong  and you will get an error since you are returning more then one single row here.
-- SELECT  name, (SELECT   price FROM products    ORDER BY price DESC)  FROM products ORDER BY  price DESC ;
--  so  in slect [list of columns] when you use subquery remember it should return  a single row.

--  the source of rows return  you multiple rows .  we have use source of rows in "from and join" clauses because we cantcant just have single "value" in from  clause and also   not a single column.
--  in where clause we could have both source of value  as we use in lecture 1   select * from products where price > ( select max(price )  from products where department='toys')  and in this example   select id from products  returns you single column with multiple rows 
--  the most important thing to understand is where you  put these sources.