// lecture 1
--  this section is about the  miscilinious    operators in  in postgress.
/*
 the first one we are going to study is GREATEST function.
the greatest function  allows you to find the greatest value among the list.
SELECT GREATEST(2,500,22,0,10); -> 500.
lets see a more useful example of this.
suppose we have to  calculate the cost of shippin each item.
2. "Shipping is the maximum of (weight * $2) or $30."
the formula suggest that the minimum shipping cost is 30 otherwise multiple that product weight * 2.

SELECT name, price  , GREATEST(weight*2, 30  )AS shippingCost  FROM products;

-- lecture 2
/* 
  LEAST(...[ arguements ])
  least function is  opposite to the greatest function.
  */
  select least(3,9,0,2,);
--    find the minimun discounted price by multiplyin it with the price of the product by 0.5  if the price is greater then 400 then slect 400, if less then that price.
  SELECT  name , price , LEAST(price *0.5,400) AS sale_price FROM  products;
  
  Lecture 3
  /* in this lecutlecture we will study aobut the case keyword 
  syntax:
  select column_list, case
  when condtioncondition_1  then do something here 
  when condition_2 then  do something here 
   else default _condition 
   end
   from table_name.
   */
   SELECT name , price , CASE
   WHEN  price > 800 THEN 'high'
   WHEN  price > 500 THEN 'medium'
   ELSE 'low'
   END AS    my_price 
   FROM products;