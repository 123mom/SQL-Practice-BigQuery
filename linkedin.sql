create database linkedin;
use linkedin;

create table user(userID char(10) PRIMARY KEY, email char(100),
user_password char(10));

create table user_profile( user_id char(10) ,headline text, summary text, inductry text,FOREIGN KEY(user_id) REFERENCES user(userID));

create table post(
post_id int primary key AUTO_INCREMENT,
author_id int NOT NULL,
user_id varchar(100),
content text not null,
media_url varchar(225),
visiblity enum('connection','public') default 'connection',
created_at timestamp DEFAULT current_timestamp,
foreign key(user_id) references user(userID));

create table comments(
comment_id int primary key auto_increment,
userID varchar(100),
post_id int,
content text not null,
created_at timestamp default current_timestamp,
foreign key(userID) references user(userID),
foreign key(post_id) references post(post_id));

create table Reactions (
    reaction_id bigint auto_increment primary key,
    post_id int,
    userID char(100) ,
    reaction_type enum('like', 'celebrate', 'support', 'love', 'insightful', 'curious'),
    created_at timestamp default current_timestamp,
   foreign key (post_id) references post(post_id),
   foreign key(userID) references User(userID)
);

