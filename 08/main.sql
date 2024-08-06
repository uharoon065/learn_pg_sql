--  lecture 1
--  " There is also a text box with the following instruction: "Find the 4 products with the highest price and the 4 products with the highest price/weight ratio."
--   FIRST finding all the products with highest price.
SELECT * FROM products  ORDER BY price DESC LIMIT 4;
--  now finding the products with highest price to weight ratio.
-- SELECT * FROM products ORDER BY  price/weight DESC  LIMIT 4;
--    joining these rows 
(SELECT *FROM  products ORDER BY price  DESC LIMIT 4 ) UNION (SELECT * FROM products ORDER BY price/weight limit 4);
--  note that thein both  queris the order in select [list of columns ] must match.
