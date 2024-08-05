CREATE TABLE posts (id SERIAL PRIMARY KEY,
url VARCHAR(255),
user_id INT REFERENCES  users ON DELETE  SET NULL );
-- user_id INT,
-- FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE );
INSERT INTO posts (url, user_id) VALUES
('http://example.com/post1', 1),
('http://example.com/post2', 2),
('http://example.com/post3', 3),
('http://example.com/post4', 4),
('http://example.com/post5', 5),
('http://example.com/post6', 1),
('http://example.com/post7', 2),
('http://example.com/post8', 3),
('http://example.com/post9', 4),
('http://example.com/post10', 5),
('http://example.com/post11', 1),
('http://example.com/post12', 2),
('http://example.com/post13', 3),
('http://example.com/post14', 4),
('http://example.com/post15', 5),
('http://example.com/post16', 1),
('http://example.com/post17', 2),
('http://example.com/post18', 3),
('http://example.com/post19', 4),
('http://example.com/post20', 5);

SELECT * FROM  posts WHERE user_id IS NULL;
CREATE TABLE COMMENTS (
  CONTENT TEXT,
  user_id INT REFERENCES users,
  post_id INT REFERENCES posts
);

INSERT INTO comments (content, user_id, post_id) VALUES
('Great post!', 1, 1),
('I agree with this!', 2, 2),
('Interesting perspective.', 3, 3),
('Well written!', 4, 4),
('Thanks for sharing!', 5, 5),
('I learned something new.', 6, 6),
('Couldn''t agree more.', 7, 7),
('This is very helpful.', 8, 8),
('I have a question.', 9, 9),
('Can you explain more?', 10, 10),
('This is insightful.', 11, 11),
('I found a typo.', 12, 12),
('Where did you find this?', 13, 13),
('Great explanation.', 14, 14),
('I have a different opinion.', 15, 15),
('Thanks for the info!', 16, 16),
('This is a great read.', 17, 17),
('Very informative.', 18, 18),
('I disagree with this.', 19, 19),
('What about this aspect?', 20, 20),
('Nice article!', 1, 2),
('Very interesting.', 2, 3),
('Good job!', 3, 4),
('Excellent write-up.', 4, 5),
('Helpful post!', 5, 6),
('I enjoyed reading this.', 6, 7),
('Keep it up!', 7, 8),
('Thanks for the insights.', 8, 9),
('This is cool.', 9, 10),
('Well done!', 10, 11),
('Nice insights.', 11, 12),
('This was useful.', 12, 13),
('Helpful information.', 13, 14),
('Well explained.', 14, 15),
('Very nice.', 15, 16),
('Great points.', 16, 17),
('Thanks for this.', 17, 18),
('Clear and concise.', 18, 19),
('Informative post.', 19, 20);

SELECT * FROM posts JOIN users ON users.id=posts.user_id;


-- setting schema for the auther table  and inserting data 
CREATE TABLE authers ( 
id SERIAL PRIMARY KEY,
name TEXT
);

INSERT INTO authers (name) VALUES
('J.K. Rowling'),
('George R.R. Martin'),
('J.R.R. Tolkien'),
('Agatha Christie'),
('Stephen King'),
('Jane Austen'),
('Mark Twain'),
('Charles Dickens'),
('Ernest Hemingway'),
('F. Scott Fitzgerald'),
('Leo Tolstoy'),
('H.G. Wells'),
('Isaac Asimov'),
('Arthur Conan Doyle'),
('Harper Lee'),
('Mary Shelley'),
('Bram Stoker'),
('Victor Hugo'),
('J.D. Salinger'),
('Herman Melville');

-- creating schema for the books table and inserting data into it

CREATE TABLE books (
id SERIAL PRIMARY KEY,
title TEXT,
auther_id INT,
FOREIGN KEY (auther_id) REFERENCES authers(id)
);

INSERT INTO books (title, auther_id) VALUES
('Harry Potter and the Sorcerer''s Stone', 1),
('A Game of Thrones', 2),
('The Hobbit', 3),
('Murder on the Orient Express', 4),
('The Shining', 5),
('Pride and Prejudice', 6),
('Adventures of Huckleberry Finn', 7),
('A Tale of Two Cities', 8),
('The Old Man and the Sea', 9),
('The Great Gatsby', 10),
('War and Peace', 11),
('One Hundred Years of Solitude', 12),
('Moby-Dick', 13),
('To Kill a Mockingbird', 14),
('Mrs Dalloway', 15),
('The Catcher in the Rye', 16),
('Foundation', 17),
('Ender''s Game', 18),
('Sherlock Holmes: The Complete Novels and Stories', 19),
('The Raven and Other Poems', 20),
('Harry Potter and the Chamber of Secrets', 1),
('A Clash of Kings', 2),
('The Lord of the Rings', 3),
('And Then There Were None', 4),
('It', 5),
('Sense and Sensibility', 6),
('The Adventures of Tom Sawyer', 7),
('Great Expectations', 8),
('For Whom the Bell Tolls', 9),
('Tender is the Night', 10),
('Anna Karenina', 11),
('Love in the Time of Cholera', 12),
('Bartleby, the Scrivener', 13),
('Go Set a Watchman', 14),
('Orlando', 15),
('Nine Stories', 16),
('I, Robot', 17),
('Speaker for the Dead', 18),
('The Hound of the Baskervilles', 19),
('The Tell-Tale Heart', 20);

-- exercise solution
SELECT authers.name AS auther_name,title FROM books JOIN  authers ON books.auther_id = authers.id;

SELECT
  p.url,
  c.content,
  p.id,
  c.post_id  AS post_id
FROM
  posts AS p
  JOIN COMMENTS AS c ON p.id = c.post_id;

  --  lecture 10 types of join
--  inner join or just join
  SELECT  p.user_id AS user_id,u.id, u.name,p.url FROM posts as p JOIN users AS u ON  u.id= p.user_id;
-- the left join include the rows where post.user_id would not match any users.id  . and would  fill empty columns with null. So the source table rows which doesnt match to dependent table  rows are included in left join.
  SELECT p.user_id AS user_id,u.id, url,name   FROM  posts AS p LEFT JOIN users AS u On p.user_id=u.id;

  -- in right join the dependent table rows  which even dont match  the source table  are included and  rest of the source table rows are droped.
  SELECT p.user_id AS  user_id, u.id,url,name FROM posts  AS p RIGHT JOIN users AS u ON  p.user_id=u.id;

--  in full join all the rows from source table  which match  the dependent table rows are included as well as   the rows which dont match any row in  dependent table are included . and  from dependent table the rows which dont   match any source table rows are also included so the full  join is combination of the right and left join.
SELECT p.user_id AS user_id, u.id,name,url FROM posts AS p FULL JOIN users AS u ON p.user_id=u.id;

-- lecture 12 order matters
--  joining the posts to users  using left join.
SELECT p.user_id AS user_id, u.id,name,url FROM posts AS p   LEFT JOIN users AS u ON p.user_id=u.id;
-- now switching the source and dependent tables.
SELECT p.user_id AS user_id, u.id,name,url FROM  users AS u  LEFT JOIN  posts AS p ON  u.id=p.user_id;
--  now we can abserve that in our first query the left join returns the posts besides the matching rows  from the source table     which dont match any rows to any dependent table  rows but when we flip our tables  instead of getting rows  which dont match any posts  we get  users.

-- lecture 13 and 14
-- exercise solution
SELECT books.id AS books_id, authers.id AS auther_id, name,title FROM  books  RIGHT JOIN  authers ON books.auther_id =authers.id;
--  solution 2
SELECT  name,title FROM authers LEFT JOIN  books ON authers.id= books.auther_id;

--  lecture 15 where with joins
--  the goal here is to find the users that have commented on their own posts.
--  select content, url from  comments  join posts on post.id=comments.post_id   where posts.user_id =comments.user_id
SELECT posts.user_id AS puid, comments.user_id AS cuid,  content,url FROM posts JOIN comments  ON posts.id=comments.post_id WHERE posts.user_id=comments.user_id  ;
--  lecture  16
--  multiple joins
-- use the joins to find the users along with  their posts who had commented on its own poost.

--  joining the posts table rows where comments table row   matches the post.id and comments.ost.post_id basically finding all the  comments for the particular post.
SELECT  posts.id AS PID,comments.post_id,comments.id AS CID, url,content,posts.user_id AS PUID,comments.user_id AS CUID  FROM posts  JOIN comments  ON posts.id=comments.post_id ORDER    BY PID;

--  this statement match the users rows     to the joined table rows of posts and comments matching on  users id and post.user_id.
SELECT users.id AS UUid,posts.user_id AS PUID, posts.id AS PID,comments.post_id,comments.id AS CID, url,content,name,comments.user_id AS CUID FROM posts JOIN comments  ON posts.id=comments.user_id JOIN  users ON posts.user_id=users.id;
--   finding the rows from joined table where the user has made comments.
SELECT comments.user_id AS CUID, users.id AS UID     , posts.id AS PID,comments.post_id,comments.id AS CID, url,content,name,posts.user_id AS PUID FROM posts JOIN comments  ON posts.id=comments.user_id JOIN  users ON  comments.user_id=users.id;
--  from joined comments and posts table  matchthe the posts.user_id to users.id that will give you the   posts of the user  now from comments match the comments.user_id to user.id  that will give you users where they have commented  and  if you combine these conditions you will get the users where they have commented themselves on their posts basically what it is  doing is that first find the post for the  user (post.user_id=user.id) and for  if that condition is true then for the same user   check in joined row if comment.user_id matches with  the user.id if that is true   then the we are saying post and comment is made by the same user.
SELECT users.id AS UID     ,  comments.user_id AS CUID, posts.user_id AS PUID,   url,content,name FROM posts JOIN comments  ON posts.id=comments.user_id JOIN  users ON posts.user_id=users.id AND   comments.user_id=users.id;
--  verifying that my join statement was correct.
SELECT  comments.user_id AS CUID, posts.user_id AS PUID,   url,content  FROM posts JOIN comments  ON posts.id=comments.user_id WHERE posts.user_id=comments.user_id ;

-- lecture 18 exercise
--  solution
SELECT books.id AS BOOKID, reviews.book_id,  authers.id AS auther_id, books.auther_id AS book_created  , reviews.auther_id AS review_user, name ,  title,review FROM books JOIN  reviews ON books.id=reviews.book_id  JOIN authers ON authers.id= books.auther_id AND authers.id=reviews.auther_id;

--  verification
SELECT books.id AS BOOKID, reviews.book_id, books.auther_id AS book_created  , reviews.auther_id AS review_user,   title,review FROM books JOIN  reviews ON books.id=reviews.book_id WHERE  books.auther_id=reviews.auther_id;