--  sorting records.
--  by default the postgres sort the records in ascending order.
SELECT *   FROM products ORDER BY price;
--  you can optionally provide the option to sort the record in descending order.
SELECT * FROM products  ORDER BY  price  DESC;
--   youc an also sor  the rows by plphabatically 
SELECT * FROM products ORDER BY name;
--  YOU can provide multiple criteria for the  sorting order , where if there are two similar values of the first criteria then they will be sorted to next listed criteria.
--  example one 
SELECT * FROM products ORDER BY price, weight DESC;
--  EXAMPLE 2
SELECT * FROM products ORDER BY  price   DESC, weight DESC;
--   OFFSET AND LIMIT.
-- inin postgress the order of the query si something like this, "select columns from table where  condition order by  column offset some_number_of_rows limit some_number_rows;"
--  you can also  use these seperately,
SELECT * FROM products    LIMIT 10;
SELECT * FROM products  OFFSET 10;
-- normally the offset and limit are used togather, the most common use  of them are in pajunation.
SELECT * FROM products  OFFSET 0 limit 10;
--  NOW TO FIND THE  NEXT 10 recors records skip first 10.
SELECT * FROM products   OFFSET 10  LIMIT 10;

SELECT * FROM products ORDER BY  price  OFFSET 0 limit 10;
--  exercise
SELECT * FROM   phones ORDER BY price DESC  OFFSET 1 LIMIT 2;