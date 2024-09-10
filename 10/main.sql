--  lecture 1
/*
the DISTINCT keyword 
 the distinct keyword is used inside the select clause . It allows you to find unique values from the selected column.
 SELECT     DISTINCT department  FROM products;
 you can have multiple columns in select statement in that case  row is considered unique all the  selected columns    have uniqunique value. The postgress do something like this internely  for a query with multiple columns selected.
SELECT  name,price  FROM products;

 let unique_rows = [];

for (let row of table) {
    // Check if this combination of 'name' and 'price' already exists
    let column_exists = unique_rows.some(r => r.name === row.name && r.price === row.price);
    
    if (column_exists) {
        // Skip the row
        continue;
    } else {
        // Add the row to unique_rows if it's not a duplicate
        unique_rows.push(row);
    }
}
you can see  if any of columns value is different it is considered unique.
*/

-- lecture 2,3
/* count the unique manufacturer from phone table */
SELECT   DISTINCT    count(manufacturer )FROM  phones;
--  THE above soliutionstatement failed because you were applying distinct clause on the value returned by the count function instead of the   manufacturer column.

SELECT   count(DISTINCT  manufacturer )FROM  phones;
