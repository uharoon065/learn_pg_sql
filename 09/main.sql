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

--  lecture 12
/* the use  sub queries inside where clause
the  source  of data  that can be   returned by sub query inside the where clause depends upon the operator being used.  A sub query can returned a scalor query as well as list of rows (meaning a single column with  multiple rows.)
example 1
finding all the  orders  of products where price to weight ratio is  > 250
SELECT * FROM orders  WHERE  product_id IN 
( SELECT id FROM   products WHERE  price/weight  > 200);
in this example  you can see we have used "iIN" operator which requires list so our subquery can return a column.
*/

-- lecture 13
--  table for operators and there coresponding data structure
/*
1. On the left side:
   - Operators: >, <, >=, <=, =, <> or !=, IN, NOT IN
   - Required structure of data: Single value for the first six operators, and Single column for IN and NOT IN.

2. On the right side:
   - Operators with ALL/SOME/ANY: > ALL/SOME/ANY, < ALL/SOME/ANY, >= ALL/SOME/ANY, <= ALL/SOME/ANY, = ALL/SOME/ANY, <> ALL/SOME/ANY
   - Required structure of data: Single column for all these operators.

*/

/*
continueing our discussion  this lecture is about operators and data structure that they support in where clause.
The image is a diagram that explains the relationship between SQL operators in the WHERE clause and the structure of data that a subquery must return. It is divided into two main sections:

     lets try to understand  some   uses of operators by an  solving a query.
     The challenge is to write a SQL query that retrieves the names of all products with a price greater than the average product price from the given database table. The task involves calculating the average price of all products and then selecting only those products whose price exceeds this average.
     */
     SELECT name,price  FROM  products 
 WHERE  price > (SELECT ROUND(AVG(price),2) AS average_price    FROM products  )

--   lecture 14 and 15
--  exercise
/* The challenge mentioned in the document is to create a query that outputs the names and prices of phones that have a price greater than the Samsung S5620 Monte. */
 SELECT name,price FROM phones 
 WHERE  price > (SELECT price FROM phones WHERE LOWER(name)  ILIKE  '%s21' );
--  "%" WILDCART matches any sequences of characters before s21.

--  lecture 16
/*
use of "NOT IN" operator
task:
The task is to write an SQL query that retrieves the names of all products that are not in the same department as products with a price less than 100. 
This means you need to identify departments with products priced under 100 and exclude products from those departments in your result.
*/
 -- in sub  query  i have to find  all the  departments first which has products where price of product is < 100.
-- ( SELECT  department FROM products  WHERE price  < 100) 
--  now in my outter query  i have to find the names of those products   that are not  present in those list of departments.
SELECT name  FROM products 
WHERE  department NOT IN  (SELECT  department FROM products  WHERE price  < 100);

--  lecture 17
/* 
IN  thislecture will learn about the "ALL operator".
The task is to identify and display the name, department, and price of products that have a higher price than all the products listed under the 'Industrial' department in the database table. 
The image shows a diagram related to SQL queries, specifically focusing on the use of operators in the WHERE clause. It is divided into three columns:
1. The first column lists operators used in the WHERE clause with "ALL":
   - price > ALL
   - < ALL
   - >= ALL
   - <= ALL
   - = ALL
   - <> ALL
2. The second column indicates that the structure of data the subquery must return is a "Single column" for each operator listed in the first column.
3. The third column lists operators used in the WHERE clause with "SOME":
   - > SOME
   - < SOME
   - >= SOME
   - <= SOME
   - = SOME
   - <> SOME
*/

--  note that the use  of max funcion is  correct here but for learning purpos we  will use "All" operator
-- (SELECT  MAX(price) FROM products   WHERE LOWER(department)='industrial')
SLECT  name,price,department FROM products 
WHERE  price > ALL  (SELECT   price  FROM products   WHERE LOWER(department)='industrial');

--  lecture 17
/* 
using SOME OPERATOR or any . 
note that "ANY" operator is ilias to the some operator.
hints for using some or any boperators : "at least , one of items, any of products  "
Both keywords are used to compare a value against a set of values returned by a subquery.
THE SOME  operator allows you to compare a value  against list of  values where if any vadlue  inside list of values  is > some,< some,or= some  to the compared value it returns true.
lets try to understand this  by an example.
instructions:
There is a text box with the instruction: "Show the name of products that are more expensive than at least one product in the 'Industrial' department."
*/
SELECT name, price FROM products
WHERE price > SOME  (SELECT price FROM products WHERE  LOWER(department) = 'industrial')

--  lecture 19,20
/*
The image shows a practice exercise for writing SQL subqueries. The task is to write a query that prints the name of all phones with a price greater than any phone made by Samsung. A table named "phones" is provided for reference, which includes columns for name, manufacturer, price, and units sold. The table contains the following entries:
*/
SELECT name,price FROM phones  
WHERE price >  ANY 
(SELECT price FROM phones WHERE LOWER(manufacturer) = 'samsung');

--  lecture 21
/*
 in this lecture we will study about the corelated queries.
lets try to understand this by solving a problem.
There is a task description that says: "Show the name, department, and price of the most expensive product in each department." Below this, there is a partially visible SQL query starting with "
SELECT name,price, department From 
(SELECT department, MAX(price)  FROM products  GROUP BY department)
look at the above query in our sub query we are catagorizing   departments since we have to find the name price, and department of the most expensive product.
now we can find the price of most expensive item in each department but the problem arises if you try to select name , price in our outer query since it is going to return only names  of departments and max price of each department item. To solve such proble problems we use corelated queries.
So corelated query is a  query in which a sub query access the outer row data.
lets try to understand this wiht smaller data set before moving to larger data set.
suppose we have to find the name, price , and department  name of the most expensive  item in the industrial department.
The image shows a database table labeled "products" with columns for id, name, department, price, and weight. The table includes the following entries:

1. Shirt, Industrial, 876, 3
2. Towels, Outdoors, 412, 16
3. Bacon, Grocery, 10, 6
4. Ball, Industrial, 328, 23
5. Fish, Industrial, 796, 10
6. Mouse, Grocery, 989, 11
7. Computer, Outdoors, 298, 2
SELECT name,price,department FROM products as p1  WHERE price = 
(SELECT MAX(p2.price) FROM products  as p2 WHERE LOWER(p2.department) = p1.department);
-- process of corelated query.
step 1 
selecting row 1 from table products alias as p1.
inside the where clause first the sub query is being executed  ( select max(p2.price) from products where p2.department  = p1.department)
in sub query selecting row 1 from products  table  and inside where clause checking if the its department is  equal to the "industrial" . since row one department is 'industrial' this row is  not drop , continueing this process for row 2 here its department is "outdoor" so droping that one , similarly droping  row 3,6 and 7 keeping only row  1, 4, and 5. Here finding the max price among these 2 rows which is  876 which is returned to outer query where clause .
now the outer where clause checks if p1.price (876) is   equal to the value  returned by the sub qury   (876) since it is true the outter query keep this row,
now the outer query is goin to take row 2 from the p1 table  and going to execute the sub query in where clause  here   p2.department for innerrow1 is "industrial' and p1.department is "outdoor"  this inner row is droped moving to row 2 this row is kept since its  department is "outdoor"  this process is repeated for the rest of inner rows keeping only those rows where  department is  'outdoor' after that filtering finding the max price and returning that  to the outer where clause wherr  it checks if the current row's.price is equal to the returned value of the sub query  if yes  keep that outer row otherwise drop that outer row .
this process is continued  for each outer row   where the where clause only keeps that row where its price value is matched to the returned subquery value.
So  corelated query is like  a query there is main loop which  takes  each row table outer table and inside the sub query we utilize that row's data , and for that row another  nested loop is executed which allows you to   execute the table .something like this happense here .
for row in table:
   for  innerRow in table:
   ... inner table has access to the outer row.
*/
SELECT name,price,department FROM products AS p1  WHERE p1.price = (SELECT  MAX(p2.price) FROM products AS p2  WHERE p2.department = p1.department)
--  lecture 22 
-- use of the corelated queries in select clause 
/*
Yes, the task mentioned in the image is to print the number of orders for each product without using a join or a group by. This means you need to find an alternative way to count how many times each product appears in the orders table.
def count_list(arr):
  numberOfTimes = dict()
  for row in arr:
    if row not in numberOfTimes:
      print(row)
      for inner_row in arr:
        if row == inner_row:
          if not  numberOfTimes.get(row):
            numberOfTimes[row]= 1
          else:
            numberOfTimes[row]= numberOfTimes.get(row) + 1
  return numberOfTimes

here i have written a python code that demonstrate how   your count function works internly .
*/
/*
SELECT  *FROM   orders  AS o1
WHERE   o1.product_id  = All 
(SELECT o2.product_id FROM orders  AS o2 WHERE  o1.product_id = o2.product_id)
--  approach 2

SELECT   p1.id,p1.name  FROM    products AS p1 
WHERE  p1.id  = ALL
(SELECT  COUNT(*) FROM orders  AS o2 WHERE  p1.id = o2.product_id) 
all the above approachs failed because  my sub query returned a counted row  for that product and i cant use where clause to compare product id with number of times a product appeared.
in order to fix this we use corelated query in select clause  
*/
SELECT p.name , ( SELECT  COUNT(*) FROM orders AS o WHERE o.product_id = p.id ) FROM products AS p;

--  lecture 23
/*
 in this lecture we will study about the  use of   sub query inside the  SELECT WITHOUT FROM  and JOIN CLAUSE .
 the rule for sub query inside the  select clause remains the same meaning  query should return only single row and column also known as scalor query.
  */
  SELECT (SELECT MAX(price) FROM products);

  --  lecture 24,25
  /*
  find the max,min, and average price of the phones  using the select sub query.
  */
  SELECT
  (SELECT MAX(price) FROM phones),
  (SELECT MIN(price) FROM phones),
  (SELECT AVG(price)FROM phones);