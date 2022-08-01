/*
30. customers with no orders
there are some customers who have never actually
placed an order. show these customers.
expected results
customers_customerid orders_customerid
-------------------- -----------------
fissa null
paris null
(2 row(s) affected)
*/

use northwind

select customers.customerid,
       orders.customerid
from   customers
       left join orders
              on orders.customerid = customers.customerid
where  orders.customerid is null

use northwind

select c.customerid as customerid,
       o.customerid as ordersfromcustomer
from   customers as c
       left join orders as o
              on o.customerid = c.customerid
where  o.customerid is null

select customers_customerid = customers.customerid,
       orders_customerid = orders.customerid
from   customers
       left join orders
              on orders.customerid = customers.customerid
where  orders.customerid is null

select customerid
from   customers
where  customerid not in (select customerid
                          from   orders) 
