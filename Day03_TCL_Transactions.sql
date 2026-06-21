Add Day 3 SQL transaction control practice using savepoints and rollback
1./* Create a new database: bank_db
2. Extract the female customers data from the loans_dataset's
customers table.
3. Using this, create table: female_customers in bank_db
4. Start the transaction and
    create a savepoint before_changes
5. Delete the female customers whose income is less than
1000.
6. rollback the changes
7. Remove the female customers whose income is more than
5000.
8. Commit the changes.
*/
create database bank_db;
use bank_db;

create table female_customers
select * from loans_db.customers
where Gender='Female';

start transaction;

SAVEPOINT before_changes;

set SQL_SAFE_UPDATEs=0;

delete from female_customers
where ApplicantIncome<1000;

select * from female_customers;

Rollback to before_changes;

delete from female_customers
where ApplicantIncome>5000;

commit;
