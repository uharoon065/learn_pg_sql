--  agrigate functions docs
--  https://www.postgresql.org/docs/9.5/functions-aggregate.html
SELECT user_id  FROM comments GROUP BY user_id;
--  it is very important to remember the following steps when working with 'group by ' clause.
--   first of all the db selects all the rows from the table , then find the specified group by column . in our example the db selects all the table rows of comments   and then move to user_id.
--  after slecting specified group by column , it picks unique values from that column, and creates a group  for each unique value it selected. From all the commentes table rows the  db will look at user_id column , then pick unique values from that column, and create a group by that name.
--  after creating groups  it assigns each row to a group based on  the value of    group by column. our example it will go through each  comment row and look at the value inside the user_id column and  assign that row to a group where the group  value and the user_id matches.
--  note that inside our "select" statement we can  select columns by using agrigate functions  only,  and the agrigate function is applied on each group, not on   rows. e.g select count(user_id) as user_commented from comments group by user_id; here   we are counting how many times user_id appear in a group(lets say 4 tims) in group   4, so the user has commented 4 times  then the db will continue this  for next group and so on. the key thing is to remember is that operations are performed on groups.
SELECT STRING_AGG(content,', ') AS users_comments  ,user_id FROM comments GROUP BY user_id;

-- lecture 15 using "HAVING"   keyword
--  we use  "where" t filter out the rows from our query  but "having" is use to filter the groups.
--  the order of filter query with groups is "select columns from table_name join table_name where some_condition   ( that will filter out the joined table   rows ) Group by  some_column  having some_condition . (note you can use agrigate functions inside the "having" clause .);)"
SELECT    post_id, COUNT(*) AS numberOfComments FROM comments WHERE  comments.post_id < 3 GROUP BY  post_id HAVING COUNT(*)  >1;
SELECT  user_id, COUNT(*) AS numberOfUserComments FROM  comments  WHERE post_id < 3     GROUP BY USER_ID   HAVING COUNT(*)  > 1;
SELECT  user_id, COUNT(*) AS numberOfUserComments FROM  comments  WHERE post_id < 40      GROUP BY USER_ID   HAVING COUNT(*)  > 1;
--   ffind how many times the user 10 has   commented on user 3 posts 
 SELECT   comments.user_id , COUNT(*) FROM comments  JOIN  posts ON posts.id=comments.post_id   WHERE  posts.user_id =3    GROUP  BY  comments.user_id   HAVING comments.user_id=1;
--   finding out how many posts does user 3 has.
 SELECT    posts.user_id , COUNT(*) FROM comments  JOIN  posts ON posts.id=comments.post_id     WHERE posts.user_id =3  GROUP  BY  posts.user_id  ;

 SELECT
  posts.user_id,
  COUNT(*)
FROM
  comments
  JOIN posts ON posts.id = comments.post_id
GROUP BY
  posts.user_id
HAVING
  posts.user_id = 3;
  --  lecture 7  and 8 exercise
  SELECT author_id, COUNT(*)  AS numberOfBooks  FROM books GROUP BY author_id;
  --  lecture 9 and 10 exercise
   SELECT name,COUNT(*) AS   numberOfBooks   FROM  books JOIN authors  ON books.author_id = authors.id  GROUP BY  name;
-- last exercise for the havning clause
     
 SELECT manufacturer , SUM(price*units) AS totalRevinue  FROM phones GROUP BY manufacturer   HAVING  SUM(price*units ) <  2000000;
