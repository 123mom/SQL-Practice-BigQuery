/*Practice Questions on Loan Dataset:
1. Create a list of customers who have deposited money and
still have high credit card balance
2. Create a list of customers who have either deposite money or have high
credit card balance or both.
3. Create a list of customers who have high credit card balance
but not deposited any money.*/
use loans_db;

select d.CustID, d.DepositAmt, h.CCbalance
from depositcustomers d inner join highcreditcardbalancecustomers h on d.CustID= h.CustID ;

select CustID from depositcustomers
union 
select CustID from highcreditcardbalancecustomers;

select h.CustID from highcreditcardbalancecustomers h left join depositcustomers d on h.CustID=d.CustID
where d.CustID is null;


/*List of all the students playing either of the sports
 or both. Also, show the chess performance of the
 students who are playing. (In other words, show all
 the columns from the chess table and the bridge table)
*/
use student_db5;

alter table chess
add chees_perform int;

set SQL_SAFE_UPDATES=0;

update chess
set chees_perform = case
when ID=9801 then 98
when ID=9802 then 67
when ID=9803 then 78
when ID=9804 then 86
when ID=9805 then 92
end
where ID in (9801,9802,9803,9804,9805);

alter table bridge
add bp int;

set SQL_SAFE_UPDATEs=0;
update bridge
set bp=case
when ID = 9802 then 67
when ID=9804 then 89
when ID=9806 then 98
when ID= 9807 then 78
when ID=9808 then 63
end
where ID in (9802, 9804,9806,9807,9808);


select * from bridge b RIGHT JOIN chess c ON b.ID=c.ID;
/* Important Interview Questions:
1. Difference union vs Union All
union remove duplicates but union all merge two list and include duplicates. Union all is faster beacause it doesn't remove duplicates.

2. Difference between Union vs Full Outer Join
- The common rows will be shown with all the columns
of both the tables, without any repetition.
full outer join combine rows while union join column, Full outer join doesn't need equal no of columns unlike union.

3. What is full anti join (Left Anti U Right Anti Join)
nothing common in two table show anti full join 
*/

/*From School_db*/
/*Students who are playing both the games*/
use student_db5;
select *
from chess c inner join bridge b on c.ID=b.ID;

/*Students who are playing only chess, but not bridge*/
select c.ID, c.FullName
from chess c left join bridge b on c.ID=b.ID
where b.ID is null;

/*Students who are playing any of the two games or all the students from
bridge table or chess table or both*/
select ID, FullName, chees_perform from chess
union
select ID, FullName, bp from bridge;
-- Show all the players playing chess or bridge or both
-- also, show their BP and CP