/*1. Create a new database
School_db
2. Import the attached CSV files as new tables in the School_db.
3. Then, work on the following questions: (try to do as many as you can. You can skip Q3 in the first section and Q2 in the second section for now):
Join Basic Queries:
1. Find the list of players
playing both Chess and Bridge. Show their chessperformance data as well.*/
use student_db5;
select c.ID, c.FullName
from chess c inner join bridge b on c.ID=b.ID ;

/*2.List the students who are
playing Piano from each class. Do mention the instrument type.*/
select s.ID,s.FullName,s.Class,m.Type
from music m left join `student_raw_tranformed_with time` s on m.ID=s.ID/* both return same result but inner join is better for this question*/
where m.Type='Piano';

select s.ID,s.FullName,s.Class,m.Type
from music m inner join `student_raw_tranformed_with time` s on m.ID=s.ID
where m.Type='Piano';

/*3. Do you think the students who play Piano score better in Maths than the students who play Guitar?*/
select avg(s.MTest) into @piano
from music m inner join `student_raw_tranformed_with time` s on m.ID=s.ID
where m.Type ='Piano' 
;
select  avg(s.MTest) into @guitar
from music m inner join `student_raw_tranformed_with time` s on m.ID=s.ID
where m.Type='Guitar';
select if(@piano>@guitar,'Who play piano score better in math', 'who play guitar score better in math') as result;

select m.Type,avg(s.MTest)
from music m inner join `student_raw_tranformed_with time` s on m.ID=s.ID
where m.type='Piano' or m.Type='Guitar'
group by m.Type;

/*Join Queries:
1. Make a list of students and the instruments they learn. (Natural Join)*/
select s.FullName, m.Type
from music m inner join `student_raw_tranformed_with time` s on m.ID=s.ID;


/*2. Find the number of students learning piano in each class.*/
select count(ID) as piano_student
from music
where Type='Piano';

/*3. List the students who have not yet chosen an instrument. (No match)*/
select s.FullName, s.ID
from music m right join `student_raw_tranformed_with time` s on m.ID=s.ID
where m.Type is null;

/*4. Make a checking list of students and the instruments they learn. The
list should also contain the students without an instrument. (Outer Join)*/
select s.ID,s.FullName, m.Type
from `student_raw_tranformed_with time` s left join music m on s.ID=m.ID;

/*5.List the pair of students from the same class (without any repetitions
of the pairs). (Hint: Inner Join the Student table with itself)*/
select s.ID,  s.FullName,s.Class,st.ID,st.FullName,st.Class
from `student_raw_tranformed_with time` s inner join `student_raw_tranformed_with time` st on s.Class=st.Class
where s.ID < st.ID;