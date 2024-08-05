SELECT  CASE  WHEN   paid = TRUE  THEN 'ordered'   ELSE  'not_ordered' END AS paid_status   , COUNT(*) AS numberOfOrders   FROM orders GROUP BY  paid;

