/*1.       Find
the 4th lowest scorer in Maths and Phy test scores combined.*/
use student_db5;
with low4rank as (select *,Rank()over(order by MTest+ PTest asc) as ranking from `student_raw_tranformed_with time`)
select * from low4rank where ranking=4;

/*2.       Assign
a roll number to each student after sorting their name alphabetically within
each class.*/
select *, row_number() over(partition by Class order by FullName asc) as roll_number from `student_raw_tranformed_with time` ;


/*3.       Categorize
the students into 3 categories:


Scholars
Students who have scored more than 95 in Maths

Average
Students who have scored between 90 and 94 in Maths

Dumbs -
Students who have scored less than 90.*/
select *, case
when MTest>=95 then 'scolar'
when MTest <=94 and MTest >=90 then 'Average'
else 'Dumb'
end as category
from `student_raw_tranformed_with time`;

/*Use the school database.
-Practice Questions: Rows between
/*
1. Show the total marks in Maths of three best students
at a time.*/
with best as(select *, rank()over(order by Mtest desc)as ranking from `student_raw_tranformed_with time`)
select * from best where ranking <4;
/*2. For every student, find whether that student performed better
than the previous roll number student.
*/
select ID, FullName, MTest,
if(MTest=max(MTest) over(order by ID asc rows between 1 preceding and current row),
 "current student hass the highest score","previous sctudent has the highest score") as result
 from `student_raw_tranformed_with time`;