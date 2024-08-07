--  lecture 1
--   the union keyword join all the rows from the result sets  and combine them   while  all the  common rows in the results sets appears just once in union resulted table.

--  " There is also a text box with the following instruction: "Find the 4 products with the highest price and the 4 products with the highest price/weight ratio."
--   FIRST finding all the products with highest price.
SELECT * FROM products  ORDER BY price DESC LIMIT 4;
--  now finding the products with highest price to weight ratio.
-- SELECT * FROM products ORDER BY  price/weight DESC  LIMIT 4;
--    joining these rows 
(SELECT *FROM  products ORDER BY price  DESC LIMIT 4 ) UNION (SELECT * FROM products ORDER BY price/weight DESC  limit 4);
--  note that if you want to see the  common rows which is present once in union result set  you can use UNION ALL clause.
--  note that thein both  queris the order in select [list of columns ] must match. as well there data type 
--  this is wrong
-- (SELECT   price,name  FROM  products ORDER BY price  DESC LIMIT 4 ) UNION (SELECT  name,price FROM products ORDER BY price/weight DESC  limit 4);
--  correct
(SELECT  name,price FROM  products ORDER BY price  DESC LIMIT 4 ) UNION (SELECT  name,price FROM products ORDER BY price/weight DESC  limit 4);

--  leculecture 2
--  intersection
--  in intersenction we slect only comman rows from results set.
(SELECT * FROM products  ORDER BY price DESC LIMIT 4)    INTERSECT (SELECT  * FROM  products ORDER BY  price/weight DESC LIMIT 4);
-- INTERSECT ALL returns all rows that appear in both result sets, including duplicates. 
-- Each row in the result appears as many times as it appears in the table where it has the fewest occurrences.
(SELECT * FROM products  ORDER BY price DESC LIMIT 4)    INTERSECT ALL  (SELECT  * FROM  products ORDER BY  price/weight DESC LIMIT 4);
