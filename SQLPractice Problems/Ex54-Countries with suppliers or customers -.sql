/*
54. COUNTRIES WITH SUPPLIERS OR CUSTOMERS - VERSION 3
The output of the above is improved, but it’s still not
ideal
What we’d really like to see is the country name, the total
suppliers, and the total customers.
*/
use Northwind

select * from suppliers
select * from customers

select country, count(supplierId) from suppliers where country = 'usa' group by country;
select country, count(customerid) as totalcustomers 
from customers where country = 'usa' group by country;
------------------------------------------------------------------
------------------------------------------------------------------
select companyname, country from suppliers;

select country, count(country) as total from suppliers group by country
union 
select country, count(country) as total from customers group by country;
------------------------------------------------------------------
------------------------------------------------------------------
with suppliersCount 
as 
(select country, count(country) as total from suppliers group by country)
, customersCount 
as 
(select country, count(country) as total from customers group by country)

select	country = isnull(suppliersCount.country, customersCount.country)
		, totalSuppliers = isnull(suppliersCount.total, 0)
		, totalCustomers = isnull(customersCount.total, 0)
from suppliersCount
full join customersCount
on customersCount.country = suppliersCount.country
------------------------------------------------------------------
------------------------------------------------------------------
with suppliersCount 
as 
(select country, count(country) as total from suppliers group by country)
, customersCount 
as 
(select country, count(country) as total from customers group by country)

select	country = isnull(suppliersCount.country, customersCount.country)
		, suppliersCount.total as totalSuppliers
		, customersCount.total as totalCustomers
from suppliersCount
full join customersCount
on customersCount.country = suppliersCount.country