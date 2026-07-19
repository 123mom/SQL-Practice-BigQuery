/*exists and not exists*/
/*List the name of boys from district HHM if there exists at least one female in HHM*/
use student_db5;
select FullName from`student_raw_tranformed_with time` where DCode='HHM' and Sex='M'
and exists(select * from `student_raw_tranformed_with time` where Sex='F');

/*Fetch all the students from class !A if there exists a student in class 1A who plays a musical instrument*/
select FullName from`student_raw_tranformed_with time` where Class='1A'
and exists(select * from `student_raw_tranformed_with time` s inner join music m ON s.ID=m.ID );

/* List of students from District HHM if everyone has scored more than 80*/
select FullName from`student_raw_tranformed_with time` where DCode='HHM'
and not exists(select * from `student_raw_tranformed_with time` where MTest>80);