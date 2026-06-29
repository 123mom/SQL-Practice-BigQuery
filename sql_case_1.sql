create database sql_case1_db;
use sql_case1_db;

select * from student;

/*1. a) List all the 2A students */
select * 
from student
where class="2B";

/* b) List the names and Math test scores of the 1B boys. */
select name, mtest
from student
where class="1B" and sex="M" ;

/*2. a) List the classes, names of students whose names contain the letter "e" as the third letter. */  
select class, name 
from student
where name like "__e%";
  
/* b) List the classes, names of students whose names start with "T" and do not contain "y". */   
select class, name 
from student
where name like "T%" and  name not like "%y%";  
/* c) List the names of 1A students whose Math test score is not 51, 61, 71, 81, or 91.*/    
select class, name ,mtest
from student
where  class ="1A" and mtest not in (51,61,71,81,91); 
/* d) List the students who were born between 22 March 1986 and 21 April 1986  */  
select name ,dob
from student
where str_to_date(dob,"%d-%m-%Y")>1986-03-22 and str_to_date(dob,"%d-%m-%Y")<1986-04-21;

/*3. a) Find the number of girls living in TST. */
 select count(sex)
 from student
 where sex='F' and dcode='TST'
 group by sex;
  
  
/* b) List the number of pass in the Math test of each class. (passing mark = 50)  */  
select class, count(class) as pass_in_test
from student
where mtest>=50
group by class;

 /*c) List the number of girls grouped by each class */ 
select class, count(sex) as no_of_girls
from student
where sex='F'
group by class;

  
/* d) List the number of girls grouped by the year of birth. */ 
select dob,count(str_to_date(dob,"%Y")) as year
from student
where sex='F'
group by dob;  
  
/* e) Find the average age of Form 1 boys. */ 
select avg(dob)
from student
where sex='M' 
group by sex;
  
/*4. a) Find the average mark of mtest for each class.*/ 
select avg(mtest)
from student
group by class;
  
  
/* b) Find the maximum mark of mtest for each sex. */ 
select max(mtest)
from student
group by sex;  
  
/* c) Find the average mark of mtest for all students.*/
select avg(mtest)
from student;

/*5. a) List the students who are common members of the Physics Club and the Chemistry Club.*/ 
select p.FullName
from phy as p inner join chem as c on p.FullName=c.FullName;
   
  
/* b) List the students who are common members of the Chemistry Club and Biology Club but not of  the Physics Club.*/  
select FullName from chem
where FullName IN (SELECT FullName FROM bio)
  and FullName NOT IN (SELECT FullName FROM phy);

/* 6.a) Produce a list of parts in ascending order of quantity.*/ 
select * 
from client 
order by qty; 
  
/* b) Produce a list of parts that consist of the keyword ‘Shaft’ in the description.  */ 
select part_no, Descript
from client
where Descript like '%Shaft%'; 
  
 /*c) Produce a list of parts that have a quantity more than 20 and are supplied by ‘China Metals Co.’ */ 
select *
from client
where qty>20 and supplier = 'China Metals Co.';
  
/* d) List all the suppliers without duplication. */   
select Distinct supplier
from client;
  
/* e) Increase the quantity by 10 for those parts with quantity less than 10.  */ 
SET SQL_SAFE_UPDATEs=0; 
Update client
set Qty=Qty+10
where Qty<10;
  
/* f) Delete records with part_no equal to 879, 654, 231 and 234  */  
 Delete  from client
 where part_no in (879,654,231,234);
  
/* g) Add a field “Date_purchase” to record the date of purchase.  */  
alter table client
add column Date_purchased date;

