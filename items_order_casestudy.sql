create database item_customers_db;
use item_customers_db;

/*Practice Exercises 1 (Comparison Operators)  
1. From the items_ordered table, select a list of all items purchased for customerid 10449.  Display the customerid, item, and price for this customer. 
2. Select all columns from the items_ordered table for whoever purchased a Tent.
3. Select the customerid, order_date, and item values from the items_ordered table for any  items in the item column that 
start with the letter "S". 
4. Select the distinct items in the items_ordered table. In other words, display a listing of each  of the unique items 
from the items_ordered table.
*/
select item
from items_ordered
where customerid=10449;

select *
from items_ordered
where item like 'S%';

select customerid, order_date, item
from items_ordered
where customerid=10449;

select Distinct item
from items_ordered;

/*Practice Exercises 2 (Aggregate Functions)  
1. Select the maximum price of any item ordered in the items_ordered table. Hint: Select the  maximum price only. 
2. Select the average price of all of the items ordered that were purchased in the month of Dec.
3. What are the total number of rows in the items_ordered table? 
4. For all of the tents that were ordered in the items_ordered table, what is the price of the lowest  tent?
 Hint: Your query should return the price only. */
select max(price), item
from items_ordered
group by item;

/*Select the average price of all of the items ordered that were purchased in the month of Dec.*/
select item,avg(price) as avg_price
from items_ordered
where month(order_date)=12
group by item;

select count(customerid)
from items_ordered;

select min(price)
from items_ordered
where item ='Tent';

/*Practice Exercises 3 (Group By clause)  
1. How many people are in each unique state in the customers table? Select the state and display  the number of people in each.
 Hint: count is used to count rows in a column, sum works on  numeric data only. 
2. From the items_ordered table, select the item, maximum price, and minimum price for each  specific item in the table.
 Hint: The items will need to be broken up into separate groups. 
 3. How many orders did each customer make? Use the items_ordered table. 
 Select the  customerid, number of orders they made, and the sum of their orders.
 Click the Group By  answers link below if you have any problems. 
*/
select distinct state from `customers (2)`;

select item, max(price) as max_price, min(price) as min_price from items_ordered group by item;

select customerid, count(quantity) as no_of_items, sum(price) as total_amount from items_ordered group by customerid;

/*Practice Exercises 4 (HAVING clause) 
 
1. How many people are in each unique state in the customers table that have more than one  person in the state?
 Select the state and display the number of how many people are in each if  it's greater than 1.*/ 
 
select state, count(customerid)
from `customers (2)` 
group by state 
having count(customerid)>1;

/*2. From the items_ordered table, select the item, maximum price, and minimum price for each  specific item in the table.
 Only display the results if the maximum price for one of the items is  greater than 190.00. */
 select item, max(price)as max_price, min(price) as min_price
 from items_ordered
 group by item
 having max(price)>190.00;
 
/*3. How many orders did each customer make? Use the items_ordered table. Select the  customerid, number of orders they made,
 and the sum of their orders if they purchased more  than 1 item.
*/
select customerid, sum(quantity), sum(price) from items_ordered group by customerid having sum(quantity)>1;

/*Practice Exercises 5 (ORDER BY clause) 
1. Select the lastname, firstname, and city for all customers in the customers table. 
Display the  results in Ascending Order based on the lastname. 
2. Same thing as exercise #1, but display the results in Descending order. 
3. Select the item and price for all of the items in the items_ordered table that the price is greater  than 10.00.
 Display the results in Ascending order based on the price.
*/
select lastname, firstname, city from `customers (2)` order by lastname asc;

select item
from items_ordered
where customerid=10449
order by item desc;

select *
from items_ordered
where item like 'S%'
order by item desc;

select customerid, order_date, item
from items_ordered
where customerid=10449
order by item desc;

select Distinct item
from items_ordered
order by item desc;




select item, price from items_ordered where price>10.00 order by price asc;

/*Practice Exercises 6 (Combining Conditions & Boolean Operators) 
1. Select the customerid, order_date, and item from the items_ordered table for all items unless they are 'Snow Shoes' or
 if they are 'Ear Muffs'. Display the rows as long as they are not either of  these two items. 
2. Select the item and price of all items that start with the letters 'S' ,'P' , or 'F'.
*/
select customerid, order_date, item from items_ordered where item!='snow shoes' and item!='ear muffs';

select item, price from items_ordered where item like 's%' or item like'p%' or item like'f%';

/*Practice Exercises 7 (IN & Between) 
1. Select the date, item, and price from the items_ordered table for all of the rows that have a  price value ranging from 10.00 to 80.00. 
2. Select the firstname, city, and state from the customers table for all of the rows where the state  value is 
either: Arizona, Washington, Oklahoma, Colorado, or Hawaii.
*/
select order_date, item, price
from items_ordered
where price between 10 and 80;

select firstname, city, state
from `customers (2)`
where state in ('Arizona','Washington','Oklahoma','Colorado','Hawaii');

/*Practice Exercises 8 (Mathematical Functions) 
1. Select the item and per unit price for each item in the items_ordered table. Hint: Divide the  price by the quantity. 
*/
select item, price, quantity, price/quantity as price_item
from items_ordered;

/*Practice Exercises 9 (Table Joins) 
1. Write a query using a join to determine which items were ordered by each of the customers in  the customers table.
Select the customerid, firstname, lastname, order_date, item, and price for  everything each customer purchased in the items_ordered table. 
2. Repeat exercise #1, however display the results sorted by state in descending order.
*/
select c.customerid, c.firstname, c.lastname, i.order_date, i.item, i.price 
from `customers (2)` as c inner join items_ordered as i;

select i.item,  c.customerid
from items_ordered as i inner join `customers (2)` as c
where customerid=10449;

select *
from items_ordered as i inner join `customers (2)` as c
where item like 'S%';

select c.customerid, c.order_date, c.item
from items_ordered as i inner join `customers (2)` as c
where customerid=10449;

select Distinct i.item,c.customerid
from items_ordered as i inner join `customers (2)` as c;