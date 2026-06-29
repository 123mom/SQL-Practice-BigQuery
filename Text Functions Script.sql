/*Text Functions in MySQL - 
Typically used for cleaning the data after importing from an external system. 
Eg - 
a) You had to convert DOB column from text to Date using Str_To_Date() function
b) Suppose you want to remove extra spaces in a string. 
Trim()*/

/*Common Text Functions are: 
Formatting: 
- Trim(TextField) - removes any un-necessary space(s) in a string. It won't remove 
one space between two words in a string.
- Ucase(textfield) - Convert into Upper Case
- Lcase(textfield) - Converts into lower case

Extracting Characters: 
- Left(string,NoOfCharsToExtract) - will extract characters from the beginning. 
- Right(string,NoOfCharsToExtract) - Will extract characters from the end. 
- Mid(string,StartPosition,NoOfCharsToExtract) / Substr() - will extract characters from a defined position.
- Length() - Total number of  characters in a string (space is always counted as a character).

Finding Position of a char/string in another string: 
- Locate("StrToFind",OrigString,StartPosition) - helps us find the start position of a string in another string. 
- instr(OrigString, "strToFind") - similar to locate(), however, you can't change the start position. 
The start position in instr is fixed as 1, which means instr always starts looking for "StrToFind" from the first position onwards. 
- substring_index(String, "delimeter", occurance) - select substring_index("www.ivyproschool.com",".",2);

Replace string with another string: 
- Replace(String,"CharsToReplace","NewChars") - will replace part of the string with another string.

Concat() -> helps us to concatenate multiple strings together.
Eg: 
Concat("Ivy", " ", "Pro", " ", "School")

Please note: Space is always counted as a character.
*/
use student;

/*Trim:*/
select length("   Prateek Agrawal    "), 
length(rtrim("   Prateek Agrawal    ")),
length(trim("   Prateek Agrawal    "));

select ucase(trim(fullname)) as Trimmed
from student;

/*Total length (total no. of chars) of a string*/
select fullname, length(fullname)
from student;

/*Extract the first name using left function*/
select fullname, 
If(locate(" ",fullname, 1) > 0, 
		left(fullname, locate(" ", fullname, 1) - 1), fullname)
from student;

/*Find the position of " " in the fullname*/
select fullname, locate(" ", fullname, 1) as PositionOfSpace
from student;


select locate(" ","Prateek Agrawal",1);

select locate("Pro", "Ivy Pro School",1);

select fullname, 
mid(fullname, locate(" ",fullname, 1)+1, length(fullname) - locate(" ",fullname, 1))
from student;

/*Extract last name using Right function*/
select fullname, 
 right(fullname, length(fullname) - locate(" ", fullname, 1))
from student;


use creditcard_db;

/*To Extract characters from a string, we can use: 
Left(Field, NoOfCharsToExtractFromtheBeginning): Eg: Left("Prateek", 4) -> "Prat"
Right(Field, NoOfCharsToExtractFromTheEnding): Eg: Right("Prateek", 2) -> "ek"
Mid(Field, StartPositionToExtract,NoOfCharsToExtract): 
	Eg: mid("Prateek Agrawal", 9, 7) -> "Agrawal"
*/

select fullname, replace(lower(fullname), "a", "#")
from student;

select concat("Prateek", " ", "Agrawal");

use creditcard_db;
/*
1.  Find the position of first "a" in name of each customer. 
2.	Display the customers' entire name but the last character. 
Eg: Prateek -> Pratee
3.	Display the last two characters of the customers’ name 
4.	Select names containing a single “e”.  
*/

use school_db;

select concat("His/Her/Him", " ", fullname)
from student;

select "IVy Pro School", 
mid("Ivy Pro school", locate(" ","Ivy Pro School", 1)+1, 3);

/*
1- Use trim to remove any un-necessary space. 
2- Convert fullname into lower case
3- Find total no. of chars in the fullname
4- Extract first two chars from fullname
5- Extract last two chars from fullname
6- Extract only last name using Right
7- Extract only last name using Mid*/

SELECT FullName, trim(fullName) as Trm, lcase(fullName) as Lower,
Length(FullName) as TotalChars, Left(FullName, 2) as First2Chars,
Right(FullName, 2) as Last2Chars, 
Right(FullName, Length(FullName) - instr(FullName," "))  as LastName,
Mid(FullName, locate(" ",FullName, 1)+1, length(FullName)) as LastName
FROM Student;

SELECT FullName, Left(FullName, locate(" ", FullName, 1)-1) as FirstName,
Mid(FullName, locate(" ",FullName, 1)+1, length(FullName)) as LastName, 
Locate(" ", FullName, 1) as SpacePosn
FROM Student;

Use student;

/*Find the position of first "a"*/
SELECT FullName, Locate("a", FullName, 1) as FirstA_Position
FROM Student;

/*Find the position of Second "a"*/
SELECT FullName, Locate("a", FullName, 1) as FirstA_Position, 
		Locate("a", FullName, Locate("a",FullName,1)+1) as SecondA_Position
FROM Student;

/*Replace "a" with "#"*/
Select FullName, Replace(lower(fullName), "a", "") as Replcd 
FROM Student; 

/*How many "a"s are there in each FullName*/
SELECT FullName, 
length(FullName) - length(Replace(lower(fullName), "a", "")) as NoOfAs 
FROM Student;

/*Show the fullnames that contain single "e"*/
/*Use replace*/
SELECT FullName
FROM Student
WHERE length(FullName) - 
length(Replace(lower(fullName), "e", "")) = 1;

/*Using Like*/
SELECT FullName
FROM Student
WHERE fullName NOT Like "%e%e%" AND FullNAme Like "%e%";

/*Using locate()*/
SELECT FullName
FROM Student
WHERE locate("e", FullName, 1) > 0 
and Locate("e", FullName, Locate("e",FullName,1)+1)=0;

Select fullname 
from student 
where locate("e",fullname,1)-Locate("e", fullname,locate("e",fullname,1)+1) > 0;

/*Last name using Right*/
SELECt FullName, 
If(locate(" ",fullName, 1)>0,Right(FullName, length(FullName) - Locate(" ",fullName, 1)), "") as Ln
FROM Student;

SELECT FullName, Locate(" ",FullName,1) as PostnOfSpace, 
Right("Vishal Tri", length("Vishal Tri") - locate(" ","Vishal Tri", 1)) as LastName
FROM Student;

/*How to find the number of spaces in a string
Hint: replace space with Null char (""). 
Find the length of original string - length of replaced string.*/
SELECT Fullname, replace(fullName, " ","") as ReplacedString, 
Length(FullName) - Length(replace(fullName, " ","")) as NoOfSpaces
FROM Student;

/*Position of First space*/
SELECT FullName, Instr(FullName, " ") as FirstSpace, 
locate(" ",FullName, 1) as FirstSpaceusingLocate
FROM Student;

/*Position of Second space*/
SELECT FullName, locate(" ",FullName, 1) as FirstSpaceusingLocate,
locate(" ",fullname,instr(fullname," ")+1) as SecondSpace
FROM Student;


/*second position of "a" in fullName*/
SELECT fullName, Locate("a", fullName, locate("a",fullName,1)+1) as SecA
FROM Student;

SELECT FullName, length(Fullname), Left(fullName, locate(" ",fullName,1)-1) as FirstName
FROM Student;

SELECT FullName, Replace(FullName, " ","") 
FROM Student;

SELECT Fullname,Locate("a",FullName, 1) as FirstA, 
Locate("a", FullName, locate("a", fullName,1)+1) as SecA, 
IF(locate(" ",fullName, 1)>0,left(FullName, Locate(" ", FullName, 1)), fullName) as FirstName
FROM student; 

/*Total characters in name*/
SELECT length(FullName) as TotalChars
FROM Student;

SELECT FullName, replace(lcase(fullName),"a", "") as Rplce
FROM Student;

/*List the students who contain a single e*/
SELECT FullName, Replace(lcase(FullName),"e","") as ReplacedString 
FROM student
WHERE LENGTH(FullName) - LENGTH(replace(lcase(FullName), "e", "")) = 1;

/*1. List the first initial of all the students coming from YMT*/
use student_db5;
select * from `student_raw_tranformed_with time`;

select FullName
from `student_raw_tranformed_with time`
where left(ucase(FullName),1) like "Y%" or left(ucase(FullName),1) like "M%" or left(ucase(FullName),1) like "T%" ;

/* Display the entire name but the last character of students*/
select left(FullName,(length(FullName)-1))
from `student_raw_tranformed_with time`
;
/*3. Display the last two characters of the students’ name*/
select right(FullName,2)
from `student_raw_tranformed_with time`
;
/*4. Do the second question using Mid function*/
select mid(FullName,1,(length(FullName)-1))
from `student_raw_tranformed_with time`
;
/*5. Do the third question using Mid function*/
select mid(FullName,(length(FullName)-1))
from `student_raw_tranformed_with time`
;
/*6. Show the fullname in Upper Case.*/
select ucase(FullName)
from `student_raw_tranformed_with time`
;

/*7. Select students whose name contain a single “e”. */ 
select FullName
from `student_raw_tranformed_with time`
where locate("e",FullName) and not locate('e',FullName, locate("e",FullName)+1);

/*8. Find the position of second “e” in fullnames*/
select FullName, locate('e',FullName,locate('e',FullName)+1)
from`student_raw_tranformed_with time`;
