create database book_portal_db;
use book_portal_db;

create table publishers (
    publisher_id int auto_increment primary key,
    fullname varchar(150) not null,
    country varchar(100),
    established_year int
);

create table authors(
author_id INT auto_increment,
fullName varchar(150) not null,
birth_date date,
nationality varchar(100),
constraint pk_authors primary key(author_id)
);

create table books(
book_id int auto_increment,
isbn13 varchar(15) not null,
title varchar(225) not null,
publication_date date,
language varchar(50) default 'English',
constraint pk_books primary key (book_id)
);

create table book_authors(
book_id int,
author_id int,
constraint pk_book_authors primary key (book_id, author_id),
constraint fk_ba_books foreign key(book_id)
references books(book_id)
on delete cascade
on update cascade,
constraint fk_ba_authors foreign key(author_id)
references authors(author_id)
on delete cascade
on update cascade
);

