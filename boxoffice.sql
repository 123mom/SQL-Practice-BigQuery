/*
Please write SQL queries to find answers to the following business questions on the Boxoffice Collection data:

1. Show the list of movies released in 2020.
2. List the top 5 movies which grossed the highest collections across all years. 
3. List the name of the producers who has produced comedy movies in 2019. 
4. Which movie in 2020 had the shortest duration?
5. List the movie with the highest opening weekend. Is this the same movie which had the highest overall collection?
6. List the movies which had the weekend collectio same as the first week collection
7. List the top 3 movies with the highest foreign collection. 
8. List the movies that were released on a non-weekend day. 
9. List the movies by Reliance Entertainment which were non comedy.
10. List the movies produced in the month of October, November, and December that were released on the weekends.
*/
create database boxoffice_db;
use boxoffice_db;
select * from movie_commercials;
select * from movie_details;

/*Show the list of movies released in 2020.*/
select movie_name, Year(str_to_date(release_date,"%d-%b-%Y")) as Yr
from movie_details
where Year(str_to_date(release_date,"%d-%b-%Y"))=2020
;

/*List the top 5 movies which grossed the highest collections across all years.*/
select movie_name
from movie_commercials
order by movie_total_worldwide DESC
LIMIT 5;

/*List the name of the producers who has produced comedy movies in 2019.*/
select DISTINCT producer
from movie_details
where movie_genre="Comedy" and Year(str_to_date(release_date, "%d-%b-%Y"))=2019
;

/*Which movie in 2020 had the shortest duration?*/
select movie_name
from movie_details
where Year(str_to_date(release_date, "%d-%b-%Y"))=2020
order by runtime DESC
Limit 1;

/*List the movie with the highest opening weekend. Is this the same movie which had the highest overall collection?*/
select movie_name into @mw
from movie_commercials
order by movie_weekend DESC
limit 1;
select movie_name into @mtw
from movie_commercials
order by movie_total_worldwide DESC
limit 1;
select @mw, @mtw, if (@mw=@mtw ,"same","Not same");

/*List the movies which had the weekend collection same as the first week collection */
select movie_name
from movie_commercials
where movie_weekend= movie_firstweek;

/*List the top 3 movies with the highest foreign collection.*/
select movie_name
from movie_commercials
order by movie_total_worldwide
LIMIT 3;

/*List the movies that were released on a non-weekend day. */
select movie_name, weekday(str_to_date(release_date,"%d-%b-%Y")) as day
from movie_details
where weekday(str_to_date(release_date,"%d-%b-%Y"))!=6 or weekday(str_to_date(release_date,"%d-%b-%Y"))!=5;

/* List the movies by Reliance Entertainment which were non comedy.*/
select movie_name
from movie_details
where movie_genre!='Comedy';

/*List the movies produced in the month of October, November, and December that were released on the weekends.
*/
select movie_name, weekday(str_to_date(release_date,"%d-%b-%Y")) as day, Month(str_to_date(release_date,"%d-%b-%Y")) as month
from movie_details
where (weekday(str_to_date(release_date,"%d-%b-%Y"))=6 or weekday(str_to_date(release_date,"%d-%b-%Y"))=5)
and (Month(str_to_date(release_date,"%d-%b-%Y"))=10 or Month(str_to_date(release_date,"%d-%b-%Y"))=12 
or Month(str_to_date(release_date,"%d-%b-%Y"))=11);

/*Let's analyze the data a little bit:
1. The list of drama movies.
2. The list of movies with runtime > 2.5 hours
3. Sort the data by runtime column in descending order
4. Top 2 shortest movies.
5. List of action movies which are shorter than
140 minutes.
*/
select movie_name
from movie_details
where movie_genre='Drama';

select movie_name
from movie_details
where runtime>2.5;

select movie_name
from movie_details
order by runtime DESC;

select movie_name
from movie_details
order by runtime DESC
Limit 2;

select movie_name
from movie_details
where movie_genre='Action'
and runtime<140;