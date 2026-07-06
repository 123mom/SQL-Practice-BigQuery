/*Set 1: Join Practice Exerices: using Loans_Dataset
1. Customers' gender and the amount of loan
they have applied for.*/
use loans_db;
select custID, custName, gender, loanAmount
from customers2 inner join loans;
/*2. Find the list of married customers
whose loans were rejected.*/
select cus.custID 
from customers cus inner join loans as l
where cus.Married ='Yes' and i.loan_status = 'No';
/*3. Show the loan application date, loan status for all
the self employed customers with dependents.*/
select l.ApplicationDate, l.loan_status
from customers c inner join loans l on  c.Loan_ID=l.Loan_ID
where c.self_employed='Yes' and c.Dependents='Yes';

/*Set 2:
1. List of all the customers who have high credit card
balance. Also, show the list of amount of deposit they have
made (if any).*/
select h.CustID,h.CCBalance
from highcreditcardbalancecustomers h left join depositcustomers d on h.CustID=d.CustID
order by CCBalance desc;

/*2. List the customers who have both high cc balance as well
as deposited money.*/
select h.CustID, h.CCBalance, d.DepositAmt
from highcreditcardbalancecustomers h left join depositcustomers d on h.CustID=d.CustID
where DepositAmt>0;
/*3. List all the deposit customers. Show they credit card
balance amount also if they have.*/
select d.CustID, d.DepositAmt,h.CCBalance 
from highcreditcardbalancecustomers h right join depositcustomers d on h.CustID=d.CustID;

/*4. List all the customers and the loanAmount they have taken.
Also, show their deposit amount and credit card balance, if any.
*/
select c.CustID, l.LoanAmount, d.DepositAmt, h.CCBalance
from customers c left join loans l on c.Loan_ID=l.Loan_ID left join highcreditcardbalancecustomers h on c.CustID=h.CustID
left join depositcustomers d on c.CustID=d.CustID;