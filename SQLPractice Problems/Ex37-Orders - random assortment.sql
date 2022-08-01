/*
37. Orders - random assortment
The Northwind mobile app developers would now like to
just get a random assortment of orders for beta testing on
their app. Show a random set of 2% of all orders.

Expected Result
(note - your results will be different, because we’re
returning a random set)
OrderID
-----------
11034
10400
10948
10931
10942
10604
10350
10499
10927
10896
10774
10932
10592
10706
10479
10782
10898
(17 row(s) affected)
*/

select * from orders

select	top 2 percent 
		orderid
from	orders
order by newId()