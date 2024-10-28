--  lecture 1
/* this lecture we have studied about the importance of the   data validation . the instructor just gave some reasons why we need data validation. */
--  lecture 2
/*
 in this lecture we will study create a new db and create a new table and insert a new table  and insert a new row , then insert anew row with  invalid data and see how our data base lets us  do it without validation.
 */
 CREATE DATABASE shop;
 CREATE TABLE products (
id SERIAL  PRIMARY KEY,
name  VARCHAR(40),
price NUMERIC,
department  TEXT,
 weight NUMERIC 
 );


INSERT INTO products ("name", "department", "price", "weight") VALUES ('MANGO', 'fruits', 200, 1.00);
--  lecture 3
--  note that  it is very  very important to note that "SET" keyword is use to set properties of the column.
/* 
this lecture we will study about the NULL constraint.
*/
--  NOW INSERTING A WRONG VALUE
INSERT INTO  products (name,department,price) VALUES ('apple','fruit',-300);

INSERT INTO  products (name,department,price,weight) VALUES ('apple','fruit',-300,2);
INSERT INTO  products ( name,weight,department)  VALUES ('grapes',2,'fruits');
--  there are 2 ways to solve this problem.
--  first we can  apply the constraint while describing the schema.
--  the second option is to ulter the existing table and apply the constraint on it. but there is a problem , if you have data already like in our case the sql statement would failed.
ALTER TABLE products  ALTER COLUMN  price SET NOT NULL;
--  lecture  4
/* 
in this lecture we  will try to solve the gotcha we have with alter statement.
now what i did is that i set some really high price as a place holder   to all the items that has either null or negative price so i can update it as required.
*/
UPDATE products   SET price=9999 WHERE price IS NULL OR price < 0;
/* NOW applying the null constraint */
ALTER TABLE products ALTER COLUMN price  SET NOT NULL;
/* now trying to add a negative or null value. */
INSERT INTO products (name,department,weight) VALUES ('oranges','fruits',3);
/* another example */
ALTER TABLE  products  ALTER COLUMN weight SET  NOT NULL;

--  lecture 5
/* in this lecture we will study about the default values 
syntax 
ALTER TABLE YOUR_TABLE_NAME ALTER COLUMN COLUMN_NAME SET DEFAULT DEFAULT_VALUE_SAME_DATATYPE.
LETS SAY WE   have timestamp it is generally set to the timestamp when the products was added to the shop . 
*/
ALTER TABLE products ADD COLUMN creation_time TIMESTAMP DEFAULT  CURRENT_TIMESTAMP;
INSERT INTO products (name,price,department,weight ) VALUES ('anker soundcore  liberty  4 NC',100,'wireless earbuds',0.5);
--  lecture 6
/*
  inthis lecture we will  study about  adding the constraint to a column,
  syntax :
  ALTER  table table_nae add constraint constraint_name  some_constraint([columns]);
  the constraint   constraint_name is optional. it does help in finding and deleting the constraint. by default the postgress automatically assigns a constriant name to tht column.
  */
  ALTER TABLE products  ADD UNIQUE(name);
--    NOW  try to insert a row where name of the products already exist.
INSERT INTO products (name,department, price,weight) VALUES ('apple','fruits',619,2);
--  throws an error.
--  with named constriant
UPDATE products SET creation_time= creation_time + id::TEXT::interval;
--  to check the schema  \d table_name.
ALTER table  products ADD CONSTRAINT  unique_time UNIQUE(creation_time);
--  lecture 7
/* in this lecture we will study   how can we add multiple column  unique constraint . we will also see  how can we drop a constriant.
ALTER TABLE TABLE_NAME DROP CONSTRAINT  CONSTRAINT_NAME;
now the composit  unique constraint (a  constraint that consist of multiple columns    when applied   ensure that       for each  row either one of the column is unique.
forexample  if we have a  product name "samsumg earbuds 2" and department "earphones" , and  catagory is "wireless" , we cant have  product with same samsung earbuds 2 in department  earphones and catagory wireless. but we can have samsung earbuds 2 in department headphones and catagory wireless.

*/
--  A constraint which you have assigned name.
ALTER TABLE products DROP CONSTRAINT unique_time;
--  a constraint   which is automatically being assigned name.
ALTER TABLE  products DROP CONSTRAINT  products_name_key;
--  \d  removed both constriants.
--  adding composit costraint.
ALTER TABLE products  ADD COLUMN  catagory  TEXT ;
--   ADDING A PLACEHOLDER VALUE
UPDATE  products SET catagory='N/A';
--  ADDING NULL CONSTRAINT 
ALTER  TABLE products ALTER COLUMN catagory  SET NOT NULL;
INSERT INTO products  (name,department,catagory,price,weight) VALUES ('apple airpods pro','earphones','wireless',100,0.25);
--   now adding a constriant .
ALTER TABLE products ADD CONSTRAINT  unique_product UNIQUE(name,department,catagory);
--  trying to add the same product.
INSERT INTO products  (name,department,catagory,price,weight) VALUES ('apple airpods pro','earphones','wireless',100,0.25);
--  throws an error.
--  now changing the department .
INSERT INTO products  (name,department,catagory,price,weight) VALUES ('apple airpods pro','headphones','wireless',100,0.5);
--  lecture 8
--  inthis lecture we will see the use of the check constraint.  we can use  all comparisikon  operators inside check constraint.
*/
ALTER TABLE products ADD  CHECK(price> 0);
--  tryingto insert a negative price for a product.
INSERT INTO  products (name, department,catagory,price,weight) VALUES ('iphone 11','smartphones','phones and tablets',-333,1.5)
--  lecture 9
--  in this lecture we will use composit check constraint.
*/
CREATE TABLE orders  (
  id SERIAL  PRIMARY KEY ,
  product_name  VARCHAR(40) NOT NULL,
  est TIMESTAMP NOT NULL,
  order_time TIMESTAMP NOT NULL,
  CHECK(order_time < est)
);
INSERT INTO orders  ( product_name,order_time,est) VALUES ('apple','oct 24,2024 10:10:10'::TIMESTAMP ,'oct 10,2024'::TIMESTAMP);