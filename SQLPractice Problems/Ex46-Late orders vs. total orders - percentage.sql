/*
46. Late orders vs. total orders - percentage

Now we want to get the percentage of late orders over
total orders.

Expected Result
EmployeeID LastName AllOrders LateOrders PercentLateOrders
----------- -------------------- ----------- ----------- -------------------
1 Davolio 123 3 0.0243902439024
2 Fuller 96 4 0.0416666666666
3 Leverling 127 5 0.0393700787401
4 Peacock 156 10 0.0641025641025
5 Buchanan 42 0 0.0000000000000
6 Suyama 67 3 0.0447761194029
7 King 72 4 0.0555555555555
8 Callahan 104 5 0.0480769230769
9 Dodsworth 43 5 0.1162790697674
(9 row(s) affected)

Hint
By dividing late orders by total orders, you should be
able to get the percentage of orders that are late.
However, there's a common problem people run into,
which is that an integer divided by an integer returns an
integer. For instance, if you run the following SQL to
divide 3 by 2:
select 3/2
You’ll get 1 instead of 1.5, because it will return the
closest integer.
Do some research online to find the answer to this issue.
*/

;With lateorders as 
(
	select employeeid, totalorders = count(*) 
	from orders 
	where requiredDate <= shippeddate
	group by employeeid
)
, allorders as 
(
	select employeeid, totalorders = count(*) 
	from orders 
	group by employeeid
)
select	employees.employeeid
		, lastname
		, allorders = allorders.totalorders
		, lateorders = isnull(lateorders.totalorders, 0)
		, percentlateorders = (isnull(lateorders.totalorders, 0) * 1.00)/ allorders.totalorders 
		from employees
		join allorders on allorders.employeeid = employees.employeeid
		left join lateorders on lateorders.employeeid = employees.employeeid
