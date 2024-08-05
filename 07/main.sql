--    next section
--  syntax
--  slect [list of  columns ] from table order by expression [asc,desc], expressions2 [asc,desc],... { optional  null first/last };
--  lecture 1
--  by default the sort is in ascending order.
SELECT * FROM products ORDER BY price;
select * FROM   products ORDER BY price desc;
--  lecture 2
SELECT * FROM products ORDER BY name;
--  you can specify more then one expressions  in order by clause,   if  tow or more rows have equal values then second specify expression is use to sort those rows. e.g. 
SELECT * FROM  products ORDER BY price , weight;
--  here if multiple rows have same price then those rows will be sorted by the  wieght.
--  lecture 3
--   offset and limit 
--  the offset keyword is use to skip nth amount of rows from the result set.
-- SELECT * FROM   products ORDER BY price OFFSET 7;
--  this statement will skip 7 rows from the sorted result set.
--  the limit keyword allows you to limit the  the amount of rows from the result set.
-- SELECT * FROM products ORDER BY price LIMIT 5 ;
--  this statement will  return first 7 rows specified  here.
--  note that  when combining these clauses  it is very important to    right the query in right order. here its correct syntax.
--  select list_of_ccolumns from table_name order by column_name  offset  numberOfRowsToSkipFromResultSet limit   numberOfToLimitFromResultSet;
-- SELECT * FROM products   ORDER BY price   DESC LIMIT 3;
--  SELECT * FROM products  ORDER BY name OFFSET 4 LIMIT 3;
-- SELECT *FROM products WHERE  department='Electronics'  ORDER BY price LIMIT 2;
--  SELECT * FROM products ORDER BY weight  DESC OFFSET 2 LIMIT 4;
-- SELECT * FROM products  ORDER BY price ASC   OFFSET 3 LIMIT 5;
--  LECTURE 4 AND 5 EXERCISE 
--  SELECT * FROM phones ORDER BY  price  DESC  OFFSET 1 LIMIT 2;
--  note that sorting works in unions and intersections as well come to this lecture after that again.
