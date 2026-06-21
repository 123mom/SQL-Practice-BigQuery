use student_db5;
select * from `student_raw_tranformed_with time`;
select * from music;

/*IN, NOT, BETWEEN AND, Like Queries:
Find the students who have IDs in the following set – 1,5,9*/
select FullName
from `student_raw_tranformed_with time`
where ID RegExp "[1,5,9]";

/*List the names of the students who are playing a musical instrument (Hint: refer to Music and Student tables both)*/
select s.FullName, m.Type
from music as m inner join `student_raw_tranformed_with time` as s on m.ID=s.ID;

/*List the students who were born on Wednesday or Saturdays (Hint: Use WeekDay(DOB) function, which returns the day of the week 
(in number format between 1 & 7) corresponding to a given date – Eg – 1 means Sunday)*/

select FullName, weekday(str_to_date(DOB, "%c-%e-%Y")) as week_dob
from `student_raw_tranformed_with time`
where weekday(str_to_date(DOB, "%c-%e-%Y"))= 2 or weekday(str_to_date(DOB, "%c-%e-%Y"))=5;


/*List the students who were not born in January, March, and June (Hint: Use Month(DOB) function)*/
select FullName 
from `student_raw_tranformed_with time`
where Month(str_to_date(DOB, "%c-%e-%Y")) =01 or  Month(str_to_date(DOB, "%c-%e-%Y")) =03 or Month(str_to_date(DOB, "%c-%e-%Y")) =06;

/*List the students who have scored between 70 and 80 and 90 and 100.*/
select FullName
from `student_raw_tranformed_with time`
where MTest between 70 and 80 and 90 and 100;

/*List the students whose names contain E*/
select FullName
from `student_raw_tranformed_with time`
where FullName like "%e%";

/*List the students who come from Districts ending with T*/
select FullName
from `student_raw_tranformed_with time`
where binary DCode RegExp "t$";

/*List the students whose names contain B as the second last letter*/
select FullName
from `student_raw_tranformed_with time`
where binary FullName like "%b_";

/*List the students who come from districts with M as the third character*/
select FullName
from `student_raw_tranformed_with time`
where binary DCode like "__m%";


/*List the students who come from districts that contain Y in the district name*/
select FullName
from `student_raw_tranformed_with time`
where DCode like "%y%";

/*List the students who are playing instruments that contain letter "p" somewhere.*/
select s.Fullname 
from music as m inner join `student_raw_tranformed_with time` as s on m.ID=s.ID
where Type like "%p%";

/*List the instruments played by students whose names start with letter capital "A". */
select Type
from music 
where Type like "a%";

/*List the students whose name contain small case "u" as the second letter.*/
select FullName
from `student_raw_tranformed_with time`
where  FullName like "_u%";

/*List the students whose name contain "u" or "r" somewhere */
select FullName
from `student_raw_tranformed_with time`
where FullName regexp"[ur]";

/*List the students who don’t contain ‘A’ and ‘R’ in their names. */
select FullName
from `student_raw_tranformed_with time`
where binary FullName not regexp "[AR]";

/*List the students whose names contain only these characters - “A” or “B” or “C” or “D” (eg – names like “dada” “baba” “caba”)*/
select FullName
from `student_raw_tranformed_with time`
where FullName regexp"^[ABCD]+$";

/*List the students whose names don’t contain t, o, r anywhere*/
select FullName
from `student_raw_tranformed_with time`
where FullName not regexp"[tor]";

/*List the students whose names contain only three characters and must contain at least one of the following characters: a, e, u*/
select FullName
from `student_raw_tranformed_with time`
where FullName regexp"^...$" and FullName regexp "[aeu]";


