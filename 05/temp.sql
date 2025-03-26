--   the group by clause allows you to  group  rows based on unique value in specified column. In select clause, you can only select the column that is used in group clause or use an agrigate function on the group. It is very important to note that the  the functions we apply are  entire  group and not only to the single row.
--  i can use the user_id because the user_id is used iniinside the group by clause.
SELECT user_id FROM comments GROUP BY user_id;
--  this will throw an error since the "contents " column is not used inside the group by clause .
SELECT user_id,contents FROM comments GROUP BY user_id;
--  using agrigate function on the  column that is not inside the  group by clause.
SELECT author_id,STRING_AGG(review,'^') FROM reviews GROUP BY  author_id;
--  another example
--  trying to find out how many photos each user have created.
SELECT users.username, COUNT(photos.user_id) FROM  photos JOIN  users ON  users.id = photos.user_id    GROUP BY users.username;

--  trying  to find out the comments for each photo.
SELECT   comments.photo_id, COUNT(*) FROM comments GROUP BY  comments.photo_id;
--  exercise
SELECT  books.author_id,COUNT(*) FROM books GROUP BY  Books.author_id;
--  EXERCISE 2
SELECT  authors.name, COUNT(*) FROM authors JOIN books ON  authors.id = books.author_id GROUP BY authors.name;
--  use of "HAVING".
--  the  "where " clause is used on the     indivusual rows , where as the "having keywordl is closely tight to the  groups,    so it is mostly used with the agrigate functions inside the group by clause.
-- Use  of "having" in where clause  is wrong.
SELECT  photos.id, COUNT(*) from  comments JOIN photos ON comments.photo_id = photos.id  WHERE   photos.id <3 AND   COUNT(*)  > 2;
 -- correct  query.
SELECT  photos.id, COUNT(*) FROM  comments JOIN photos ON comments.photo_id = photos.id WHERE  photos.id < 3  GROUP BY photos.id  HAVING  COUNT(*) > 2;
--  a bit more complex example.
/*
There is a diagram with a title "Find the users where the user has commented on the first 2 photos and the user added more than 2 comments on those photos." Below this, there are two sections labeled "Database." 
*/
--     first ii am selecting joining the comments and photos table since i need to know which comments belong to which photo.
-- SELECT  photos.id, comments.photo_id    FROM  comments JOIN photos ON comments.photo_id = photos.id    WHERE  photos.id < 3  ;
--  now i am  grouping the photos based on the comments made by  the users on each photo.
SELECT   comments.user_id, COUNT(*)  FROM  comments JOIN photos ON comments.photo_id = photos.id    WHERE  photos.id < 3    GROUP BY   comments.user_id;
--  s
SELECT  comments.user_id,COUNT(*)  FROM  comments JOIN photos ON photos.id= comments.photo_id WHERE photos.id < 3 GROUP BY comments.user_id HAVING  count(*) > 2;
--  the instructor solution.
SELECT  user_id, COUNT(*)  FROM comments WHERE comments.photo_id <3 GROUP BY comments.user_id HAVING COUNT(*) > 2;
--  exercise on "having"
SELECT manufacturer, SUM(price*units) FROM phones GROUP BY manufacturer HAVING  SUM(price*units) > 100000000;