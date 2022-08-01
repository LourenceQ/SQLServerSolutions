/*
35. Month-end orders
At the end of the month, salespeople are likely to try
much harder to get orders, to meet their month-end
quotas. Show all orders made on the last day of the
month. Order by EmployeeID and OrderID

Expected Result
EmployeeID OrderID OrderDate
----------- ----------- -----------------------
1 10461 2015-02-28 00:00:00.000
1 10616 2015-07-31 00:00:00.000
2 10583 2015-06-30 00:00:00.000
2 10686 2015-09-30 00:00:00.000
2 10989 2016-03-31 00:00:00.000
2 11060 2016-04-30 00:00:00.000
3 10432 2015-01-31 00:00:00.000
3 10806 2015-12-31 00:00:00.000
3 10988 2016-03-31 00:00:00.000
3 11063 2016-04-30 00:00:00.000
4 10343 2014-10-31 00:00:00.000
4 10522 2015-04-30 00:00:00.000
4 10584 2015-06-30 00:00:00.000
4 10617 2015-07-31 00:00:00.000
4 10725 2015-10-31 00:00:00.000
4 10807 2015-12-31 00:00:00.000
4 11061 2016-04-30 00:00:00.000
4 11062 2016-04-30 00:00:00.000
5 10269 2014-07-31 00:00:00.000
6 10317 2014-09-30 00:00:00.000
7 10490 2015-03-31 00:00:00.000
8 10399 2014-12-31 00:00:00.000
8 10460 2015-02-28 00:00:00.000
8 10491 2015-03-31 00:00:00.000
8 10987 2016-03-31 00:00:00.000
9 10687 2015-09-30 00:00:00.000
(26 row(s) affected)
*/

select * from orders

select	EmployeeId
		,OrderId
		,OrderDate
from	Orders 

where	OrderDate = 
		dateadd(
		month, 1+ datediff(
		month, 0, OrderDate), -1)

-- where	OrderDate = EOMONTH(OrderDate)

Order by	EmployeeID
			,OrderId
