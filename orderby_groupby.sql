/*Group By, Order By and TOP Queries:
List the number of girls of each district.*/
use student_db5;
select count(FullName), DCode
from `student_raw_tranformed_with time`
 where Sex='F' group by DCode;
 
/*List the max. and min. test score of Class 1 students of each district.*/
select DCode, max(MTest+PTest), min(MTest+PTest)
from `student_raw_tranformed_with time`
where class in ('1A','1B','1C') 
group by DCode;

/*List the average Math test score of the boys in each class. The list should not contain class with less than 3 boys.*/
select Class, avg(MTest)
from `student_raw_tranformed_with time`
where Sex='M' 
group by Class
having count(*)>=3;

/*List the boys of class 1A, sorted by their names.*/
select FullName from `student_raw_tranformed_with time`
where Class='1A' and Sex='M'
order by FullName;

/*List the 1B students by their residential district.*/
select FullName, DCode from `student_raw_tranformed_with time`
where Class='1B'
order by Dcode;

/*List the number of students of each district (in desc. order).*/
select count(FullName), DCode
from `student_raw_tranformed_with time` 
group by DCode
order by count(*) desc ;

/*List the boys of each house sorted by the classes. (2-level ordering)*/
select FullName ,HCode, Class 
from `student_raw_tranformed_with time`
where Sex='M'
order by Class,HCode;

/*List the top 10% scoring girls students in Maths*/
select FullName
from`student_raw_tranformed_with time`
where Sex='F'
order by MTest desc limit 2;

/*Print the name of the second highest scorer in Maths Test*/
with second_high as(select FullName , dense_rank() over(order by MTest desc) as ranking 
from `student_raw_tranformed_with time`)
select *  from second_high where ranking=2;

/*How many students have unique names*/
select  count(distinct FullName)
from `student_raw_tranformed_with time`;
 
/*How many dumbs and scholar students are there in the table (Scholar Criteria – Mtest > 95. Everyone else is dumb).*/
select count(*) as total_student, if(MTest>95,'Scholar','Dumb') as scholar_criteria
from `student_raw_tranformed_with time`
group by scholar_criteria;

/*Find the 4th lowest scorer in Maths and Phy test scores combined. */
select FullName , MTest+PTest as comb_score
from `student_raw_tranformed_with time`
order by MTest+Ptest asc
limit 3,1;

/*Assign a roll number to each student after sorting their name alphabetically within each class.*/
select *,row_number() over(partition by Class order by FullName) as roll_number
from `student_raw_tranformed_with time` ;
 
/*Categorize the students into 3 categories: 
Scholars - Students who have scored more than 95 in Maths
Average - Students who have scored between 90 and 94 in Maths
Dumbs - Students who have scored less than 90 */
select *,case  MTest
when MTest>95 then 'Scholar'
when MTest between 90 and 94 then 'Average'
else 'Dumb'
end as category
from `student_raw_tranformed_with time`;

/*Use user defined variable to find the total number of girls in the student table. Then, show 10% of total no. of girls.*/
select count(*) from `student_raw_tranformed_with time` where Sex='F' into @no_female;
select @no_female as total_female,@no_female*0.10 as ten_percent;

/*Please refer to the table below as reference and do the questions listed as 1 and 2: 
FullName                      Kaushal                Prateek
Mtest                         93                       99
Ptest                         96                       92
Higher of Mtest / Ptest       96                       99
1 Higher of Mtest and Ptest for each student
2 Among the higher values, find the highest scorer */

select *, greatest(MTest, PTest) as high_score
from `student_raw_tranformed_with time`;

select *, greatest(MTest, PTest) as high_score
from `student_raw_tranformed_with time`
order by high_score desc
limit 1;

/*Date questions: 
Find average age of all boys students*/
select avg(Year(curdate())-(Year(str_to_date(DOB,'%m-%e-%Y')))) as age
from `student_raw_tranformed_with time`
where Sex='M';

/*Create a monthly birthday frequency table*/
select month(str_to_date(DOB,'%m-%e-%Y')) as month,count( month(str_to_date(DOB,'%m-%e-%Y'))) as no_of_birth
from`student_raw_tranformed_with time` 
group by month(str_to_date(DOB,'%m-%e-%Y'))
order by month(str_to_date(DOB,'%m-%e-%Y'));