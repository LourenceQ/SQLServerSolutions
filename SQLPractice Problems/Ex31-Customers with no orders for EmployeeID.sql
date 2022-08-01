/*
31. Customers with no orders for EmployeeID 4
One employee (Margaret Peacock, EmployeeID 4) has
placed the most orders. However, there are some
customers who've never placed an order with her. Show
only those customers who have never placed an order
with her.
Expected Result
CustomerID CustomerID
---------- ----------
SEVES NULL
THEBI NULL
LAZYK NULL
GROSR NULL
PARIS NULL
FISSA NULL
SPECD NULL
LAUGB NULL
PRINI NULL
VINET NULL
FRANR NULL
CONSH NULL
NORTS NULL
PERIC NULL
DUMON NULL
SANTG NULL
(16 row(s) affected)
*/



SELECT C.customerid,
		O.customerid
FROM   Orders AS O
       right JOIN Customers AS C
              ON O.customerid = C.customerid
                 AND O.employeeid = 4
WHERE  O.customerid IS NULL 

SELECT C.customerid,
       O.customerid
FROM   customers AS C
       LEFT JOIN orders AS O
              ON O.customerid = C.customerid
                 AND O.employeeid = 4
WHERE  O.customerid IS NULL 


SELECT customerid
FROM   customers
WHERE  customerid NOT IN (SELECT customerid
                          FROM   orders
                          WHERE  employeeid = 4)

SELECT customerid
FROM   customers
WHERE  NOT EXISTS (SELECT customerid
                   FROM   orders
                   WHERE  orders.customerid = customers.customerid
                          AND employeeid = 4) 

						
select customerid
from	customers
where	customerid not in (select customerid
							from orders
							where employeeid = 4)


select customerid
from	customers
where	not exists (select customerid
					from	orders
					where	orders.customerid = customers.customerid
								and employeeid = 4)


select customerid
from	customers
where	not exists (select customerid
					from	Orders
					where	orders.customerid = customers.customerid
							and employeeid = 4)