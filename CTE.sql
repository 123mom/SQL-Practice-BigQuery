/*Students with Unique Names
Identify students who have a unique name in the student table, then from
this unique list, filter those who belong to house 'R'.
Hint:
Start by creating a CTE that identifies unique names. Then, in the main
query, filter for students belonging to house 'R'.*/
select HCode from `student_raw_tranformed_with time`;
use student_db5;
with unique_name as( select Fullname from `student_raw_tranformed_with time` group by FullName having count(*)=1)
select s.FullName , s.HCode from unique_name u join  `student_raw_tranformed_with time`  s where s.HCode='r';

/*Musical Achievers
First, identify students who have an MTest score above 85. Then, from
this filtered list, determine those who play the "Guitar".
Hint:
Create a CTE to filter students based on MTest scores. Then, join
with the music table to filter for guitar players.*/
with highscore as( 
select ID, FullName, MTest
from `student_raw_tranformed_with time` 
where MTest>85)
select * from highscore  h inner join music m on h.ID=m.ID where m.Type='Guitar';

/* Guitarists
Identify the students born after 2005 who play the "Guitar".
Hint:
Use a CTE to filter students based on DOB. Then, join with the music
table in the main query to filter for guitar players.*/
with born_after05 as(
select ID, FullName
 from`student_raw_tranformed_with time`
 where Year(str_to_date(DOB,'%m-%e-%Y'))>2005)
select * 
from born_after05 b
 inner join music m 
 on b.ID=m.ID 
 where m.Type='Guitar';
 
select * from `student_raw_tranformed_with time`;

/*Identify students who play an instrument and are in the class '1st Grade'. From this list, filter out those who have an MTest score
 below 70.
: Start with a CTE that joins the student and music tables, filtering for '
1st Grade  ' students. In the main query, select those with an MTest score of 70 or above.*/
with grade1 as 
(select s.ID, s.FullName, s.MTest, m.Type 
 from `student_raw_tranformed_with time` s inner join music m on s.ID=m.ID 
 where s.Class='1A')
select * from grade1 where Mtest>70;


/*Find pairs of students who play the same instrument. List their names and the instrument they play.
: Create a CTE that lists student names along with their instruments. Then, in the main query, join the CTE with itself on the
 instrument column to find pairs, ensuring to filter out pairs of the same student.*/
 with instrument as
 (select s.FullName,m.* 
 from music m inner join `student_raw_tranformed_with time` s on m.ID = s.ID )
 select *
 from instrument i inner join instrument j on i.Type=j.Type
 where i.ID <j.ID;

/*Intermediate Questions:

Top Scoring Musicians
Determine the top 3 students with the highest MTest scores, and then list
the instruments they play.
Hint:
Create a CTE to identify the top 3 students based on MTest scores.
Join this CTE with the music table to get their respective
instruments.*/
with highscore as (select ID, FullName, MTest from `student_raw_tranformed_with time` order by Mtest DESC limit 3)
select h.*, m.Type from highscore h inner join music m on h.ID=m.ID;

/*Multi-Skilled Students
Identify students who both play an instrument and have an MTest score above
90.
Hint:
Create a CTE that lists students with MTest scores above 90. Join
this CTE with the music table in the main query.*/
with highscore as (select ID, FullName, MTest from `student_raw_tranformed_with time` where MTest>90)
select h.*, m.Type from highscore h inner join music m on h.ID=m.ID;

/*Instrument Popularity Among Top Scorers
First, identify the top 50% of students based on MTest scores. Then, determine which instrument is most popular among these top-scoring
students.
Hint:Use a CTE to filter the top 50% students based on MTest scores. In the main query, join with the music table and use
 GROUP BY to count instrument popularity.*/
with top50 as ( select ID, FullName, Mtest from `student_raw_tranformed_with time` order by Mtest Desc limit 9)
select  m.Type,count(m.Type) from top50 t inner join music m on t.ID=m.ID group by m.Type;
