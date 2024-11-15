--  lecture 1
/*
in this lecture we hae discussed about the reuired to make a like system for instagram.
in instagram a user can like a post , dislike a post , and also like a comment. also we can add some kinda  reaction to a ccomment and post.
so we have to built such a system that allows the users to like a ost,  also like a comment as well as can add a reaction.
*/
--  lecture 2
/* 
in this lecture we will study about the   wrong way of designing the schema for like system, which will help us to avoid the mistakes .
ffirst of all not  to add a    like column in post table.
this is because  first of all   there is no way of knowing  who like the post.
secondly one person would be able to like one post unlimited times.
thirdly there would be no way of disliking the post.
 also we wouldnt be able to remove the like of the dedeleted users.
 */
--   lecture 3
/* in this lecture we will study  how to create a corect schema orfr the likes system.
note that we will add additional features in our like system but   in this lecutre weill  just built a base for the like system.
*/
CREATE TABLE  likes (
    id  SERIAL PRIMARY KEY,
    post_id INT REFERENCES posts(id),
    user_id INT REFERENCES  users(id),
    CHECK(user_id,post_id)

);
*/

--  lecture 4
/* inthis lecture we will study about how can we add a reaction to our like system.
we may  add additional column called reaction  which  contains the reaction of the user, but normally we have limited reactions so in that case we use a postgress data type calledccalled enum. we will im;implement this feature later in some lecture.
*/

--  lecture 5
/*
in this lecture we will look   couple of posible solutions to  trying to make our like system more dynamic , meaning using single like system to  like a post as well as  comments.
 the first posible solution we will look at is using the  polymorphic association.
 in our like table we will remove the post_id  and replace it with liked_id and add a additional column called liked_type.
 the liked_type will let us know what kinda like is it ? comment/post, and the liked_id would be the id of the  liked_type.
 this approach seems good but it has alot of flause.
 one of the main flause is that we lose data consistancy ,  we have no foreign key on like_id , since it is dynamic because the the type of like is decide at liking type and we cant define a foreign key before hand , like we cant tell it is a foreign key of post or comment.
 we also has a posibility of entering a liked_id that may not exist,  but it can be overcome programatically  but having a foreign key ensure  that id already exists.
 despite of its shortcomings the polymorphic associations still being used , specially in ruby on rails projects.
 */

--   lecture 6
/*
    in this lecture we will study about the alternatives to the polymorphic associations.
    we will also see the use of coalesce function. The COALESCE function returns always the  non null value if posible, if not then null.
    we will  add foreign keys for both comment_id and post_id but with the following checks.
    first both columns cant have null  value at the same time.
    both columns cant have values at the same time.
    only one of the column can hae value, and other null.
c1 = None 
c2 = "mango"
def check(c1,c2):
    if c1  or  c2:
        if   c1 and c2:
                print("both column cant have values")
        print(c1,c2)
    else:
        print("both columns cant be null")
        
        */
        CREATE TABLE  likes (
        id SERIAL PRIMARY KEY,
        user_id INT REFERENCES  users(id),
        post_id INT   REFERENCES posts(id),
        comment_id INT REFERENCES comments(id)
        CHECK(
        CASE
        WHEN   post_id IS  NOT NULL AND comment_id IS  NOT NULL THEN FALSE 
        WHEN post_id IS NULL  AND comment_id IS NULL THEN FALSE
        ELSE TRUE
        END
        )
        );
/* NOW lets try to insert a  wrong and correct rows and see if our validations works or not  */
/* the user 3 trying to like both the post 2 and comment 2 as well */
INSERT INTO  likes (user_id,post_id,comment_id) VALUES (3,2,2);
/* NOW  try to insert both null values */
INSERT INTO  likes (user_id) VALUES (2);
/* now try to like a post  */
INSERT  INTO   likes (user_id,post_id) VALUES (3,2);
/* the above solution was mine now the instructors solution. */
/* the check constraint required the  arguements either to  be true or false , so we type cast the return the returned result of the coalasce function into boolean . It is very important to note that when null is returned by coalesce function , you can't type cast into boolean or integer . To solve this provide this use a fallback value of zero, so incase of null IDs  zero is used. */
SELECT( (COALESCE(NULL,0)::BOOLEAN)::INTEGER  +   (COALESCE(63,0)::BOOLEAN)::INTEGER )=1;
/*
 the above COALESCE(post_id) + COALESCE(comment_id)
 met the following conditions.
 WHEN null is type cast into boolean it returns  "F" which intern when type cast into integer returns 0, similarly when   boolean is true is type cast into  integer it returns 1. 
 So the trick here is that if one is null and other is value then 1+0 =1 which we requires, and if both are values  then 1+1 =2 which fails and returns false and in case of both null  it returns 0 which it also fails and returns false to  the check constriant.
 */
/* now applying the solution. */
CREATE TABLE likes (
id SERIAL PRIMARY KEY,
user_id  INT REFERENCES users(id),
post_id int REFERENCES posts(id),
comment_id INT REFERENCES comments(id)
CHECK(
( (COALESCE(post_id,0)::BOOLEAN::INTEGER ) +   (COALESCE(comment_id,0)::BOOLEAN::INTEGER ))=1
)
);
/*  FIRST WITH both ids */
INSERT INTO likes (user_id,post_id,comment_id) VALUES  (1,2,2);
/* try otto insert both null values */
INSERT  INTO  likes (user_id) VALUES (2);
/* inserting a correct row now */
INSERT INTO likes (user_id,post_id) VALUES (2,1);

-- lecture 7
/* in this lecture we will study  another alternative to the   polymorphic association. 
second alternative is that we can add  seperate tables for   liked post and liked comments.
liked_post -> create table liked_post (
id serial primary key,
user_id int referes users(id),
post_id int posts(id)
)
comment_liked -> create table liked_comment (
id serial  primary key,
user_id int references  users(id),
post_id  int references posts(id),
comment_id int references comments(id)
);
*/

--  lecture 8
/* in this lecture we will decide what approach we will be taking to built our likes system and why  we take  one  approach then the other. 
we  will take the approach 1 because here    aren't any additional information to our like. It is simply a matter that someone either liked a comment or post.
it would be more   prefereable   to go with second approach, if we were adding some additional information to our liked post or comment e.g someone may have reacted to our post instead of liked.

*/
