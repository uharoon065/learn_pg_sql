--  exercise 1
SELECT COUNT( *) FILTER(WHERE paid =TRUE ) AS payed_orders, COUNT(*) FILTER(WHERE paid=FALSE) AS unpaid FROM orders  GROUP BY paid;
--  next exercise
SELECT  users.first_name,users.last_name,orders.paid  FROM orders JOIN users  ON users.id= orders.user_id ;