-- lecture 1
/*
in  this lecture we will  focus on the posts, and going to  add new features to our  posts table.
the instagram post contains  3 additional features that we are going to add.
a post contains some text called caption describing the post. 
second feature is the location , we may add  a location for our post  where it was posted.
the third feature is tags, tags allows you to link the post to another user. besides the linking , when you add a tag to a post , you  have  a ability to add a tag to specific part of the tag.
*/
--  lecture 2
/* 
in this lecture we wil only going to add  3 new columns lat,lng,and caption.
create table posts (id serial primary key ,
user_id references users(id),
title text not null,
url text not null,
caption text not null,
lat real,
lng real,
createdAt timestamp  default current_timestamp,
updatedAt timestamp  default  current_timestamp
)

--  lecture 3
/* in this lecture we have discussed how are wegoing to store the tagged people and their placement.
we have discussed  that we may create a new table called tags where we may store the information like and user_id and use some data structure to  store the position of the tagged people.
CREATE TABLE tags (
id serial primary key,
post_id int references posts(id),
user_id int references users(id),
coordinates text );
*/
--  lecture 4
/* in this lecture we have discussed   what approach we may take to  differentiate between posts that may have picture  where people have been tagged or if it is a just a caption post where we have tagged people.
first approach we we discussed was where we have a tag table from our previous table  where in case of the  caption tagged people we just set the coordinates to null.
this apporoach seems good abut  if we are quarying our sigle table alot that has a performance hit.
the second approach we discussed was to create a seperate tables for   photos_tag and caption_tag. That would make  querrying the tagged users in photos and caption more efficient and easy.
*/
--  lecture 5
t