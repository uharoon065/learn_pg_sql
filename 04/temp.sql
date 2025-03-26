--  the join statement allows you to join 2 different tables based on some criteria.
SELECT username,contents  FROM comments JOIN users ON users.id = comments.user_id;
--  finding the  comments on the photos.
SELECT contents, url   FROM photos JOIN  comments ON  photos.id = comments.photo_id;
--  exercise solution
SELECT authers.name,books.title FROM books JOIN  authers ON authers.id = books.auther_id;
--  Order of joining tables and  join types.
--  normally when we join the tables the order  doesnt matter,  and the  joinhappen based on some criteria define.but imagin what happen when we  have some row where the join criteria does not match that row is dropped. In the following exampole we have a photo that doesnot belong to any user and it is dropped.
INSERT INTO photos (url,user_id) VALUES ('example.png',NULL);
--  by default we we use a join called Inner join. In that type of join the rows from the source tabl and joining table must match otherwise they are dropped.
--  left outer join
--  in left  outer join  the source table keeps all the rows  even they dont match the joining table. e.g in our below example the user with id 6 does not have any photos, but the the user still appear in the result set, wityh url column set to null.
SELECT users.id, url,username FROM users LEFT OUTER JOIN  photos ON users.id = photos.user_id;
--  in this example we keep  all the photos since they were in our source table and dont match any user.
SELECT photos.user_id, username, url FROM  photos LEFT OUTER JOIN users  ON photos.user_id = users.id;
--  right outer join
--  the right outer join is the opposite of the left outer join, instead of including all the rows from the source table, it includes all the rows from the joining table. In our below example, instead of including all the rows from the source table(photos)  it includes all   the row from the user table.
SELECT photos.user_id, username, url FROM  photos  RIGHT OUTER JOIN users  ON photos.user_id = users.id;
--  full join
--  the  full join returns all the rows  from both the source and joining tables irrespect   they meet the criteria.
SELECT  username,url,users.id AS uid,photos.user_id FROM photos  FULL JOIN  users ON photos.user_id = users.id;
--  exercise
SELECT title,authors.name FROM authors LEFT JOIN  books ON authors.id = books.author_id;
--  where with the join.
--   first joining the  photos and their relevent comments, then finding the users that have commented on thier own photos.
SELECT  url,contents FROM comments JOIN photos ON  photos.id = comments.photo_id WHERE  photos.user_id=comments.user_id;
--  three way join.
--  here we have to find the username who have commented on his own post.
--  so the stragety  we are taking is that first we are finding all the photos and their relavent comments then we will join the user table based on the condition that both  photo.user_id and comments.user_id should match  the  users.id  This is to match the person who have created the photo and then to check if it the same person who had commented on the photo.
SELECT url,contents,username FROM comments JOIN  photos ON comments.photo_id = photos.id  JOIN users ON users.id = photos.user_id AND users.id = comments.user_id;

--  exercise
--  first finding all the rviews for the relevent books.
SELECT books.id, reviews.book_id,  review, title, reviews.author_id FROM reviews JOIN books ON reviews.book_id = books.id;
--  now my target is that finding those authors who himself had reviewed there books. So after finding all the books and their relevent reviews, just gotta join the authors tqable with the imaginary table reviewsWithBooks with the authors table where the books.author_id and reviews.author_id are same to the authors.id.
SELECT books.id, reviews.book_id,  review, title, authors.name  FROM reviews JOIN books ON reviews.book_id = books.id JOIN  authors ON authors.id = books.author_id AND  reviews.author_id = authors.id;
