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
--  lecture 3
--  shape of data you get from sub queries and where you place them.
--  data  returned by sub query inside the select clause 
--   select  [ column1, subquery1,subquery2,.....]
--  if you want to place sub  query in  select clause it must return single  row (one row and one column) also know  as scalur query.
SELECT name,  (SELECT MAX(price) FROM  products ),(SELECT  MIN(price) FROM  products)FROM products;
SELECT name, (SELECT price FROM products  WHERE  id= 3)  FROM products WHERE  id=3;

/* note that if you  normally use  a agrigate function and non agrigate function  in select clause you will get an error unless that column is in  group by clause.
 * nthis is wrong
*   select name, max(price), min(price) from products;
*/

--  lecture 4 and 5 
/*
* instructions
* Instructions:
- Write a query that prints the name and price for each phone.
- Additionally, print out the ratio of the phone's price against the maximum price of all phones.
- Rename this third column to price_ratio.
*/
--  solution 
SELECT  name ,price, ROUND (price/ CAST (( SELECT MAX(price) FROM phones ) AS numeric ), 2  )AS price_ratio  FROM phones;


--  lecture 6
--  data returned by sub queries inside  "from" clause
--  source of rows.
--  the data inside from clause can be bit flexable.  The source of data inside the from clause dependts upon the outer query weather it supports it or not.  Generally   in from clause we have some set of rows and columns which we called table. So   if our outter query  supports inner query it will work. look at following example.
SELECT  MAX(price_weight_ratio) FROM (SELECT name, price/weight AS  price_weight_ratio  FROM  products) AS prices_raios;
/*
  here we have  sub  query that returns a multiple rows x columns  which we  have assign an alias which is necessary because the table returned by the sub query must have some name.
  So the sub query works as long the outter query  supports it.
  That  means  in our example if the sub query returns only two columns name and price_weiht_ratio  and multiple rows.
  here if our query  try to select  some columns that does not exists " select weight from (sub_query );" will throws an error, because there is no column  named "weight" inside our returned table .
  */

  --  lecture 7
  --  continue  data returned inside  from clause.
  --  source of value.
  --  the from  clause can hae  sub query that returns scalor query (one row and one column). That your main query will work as long your writing a outter queyrquery that is compitible with  inner query. Look at the following examples. 
  --  the example one works because our outter query  is doing something that is posible to do with  single row and column, even it is selecting a all columns , as long is compitable it works.
  --  look at the example 2 it fails because there is no column  by name  to select from single value niether there is any column  by price  which we can compare.
  --  example 1
  SELECT * FROM (SELECT MIN(price) FROM  phones  ) AS my_phones;
  --  example 2
  SELECT    name FROM (SELECT MAX(price) FROM phones  ) AS phones WHERE price < 200;
  --  lecture 8
  /*
  The task is to "Find the average number of orders for all users." It mentions that there is more than one way to solve this, but the approach will be using a 'FROM' subquery.
  formula
  sum of orders/ number of users
*/
-- SELECT SUM(numberOfOrders) FROM  -> 550 total orders
--  solution 1
SELECT SUM(numberOfOrders)/COUNT(user_id) AS averageNumberOfOrders  FROM  
(SELECT  user_id , COUNT(*) AS  numberOfOrders  FROM orders GROUP BY user_id ORDER BY user_id) as  orders;
--  solution 2
SELECT avg(numberOfOrders)  AS averageNumberOfOrdersByUsers  FROM  
(SELECT    COUNT(*) AS  numberOfOrders  FROM orders GROUP BY user_id ORDER BY user_id) as  orders;

--  lecture  9 and 10
/*
The The task is to calculate the average price of phones for each manufacturer and then print the highest average price. 
*/
-- SELECT manufacturer, COUNT(*) AS  numberOfUnitsSold  FROM phones GROUP BY manufacturer;

-- SELECT manufacturer,  ROUND(AVG(price),2) AS  averagePrice  FROM phones GROUP BY manufacturer;
SELECT MAX(averagePrice) FROM  (SELECT ROUND(AVG(price),2) AS  averagePrice  FROM phones GROUP BY manufacturer) AS  manufacturersAveragePrices;

--  lecture 11
/**
 in this lecture we will learn about   source of data inside in join clause.
 the data returned by sub query  in  join clause  depends on the on clause. 
lets try to understand it by an example.
lets try to find out the users firstname who has ordered product with id 3
SELECT   users.id,user_id,  first_name FROM users 
JOIN 
(SELECT user_id  FROM orders WHERE product_id=3) AS orders 
ON  users.id=orders.user_id;
-- (SELECT * FROM orders WHERE product_id=3)
 in our sub query  the on  clause just require user_id column so even we  skip  rest of  of colmns  it wont matter.  
( select  user_id   orders where product_id=3 from )