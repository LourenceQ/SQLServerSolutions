/*
44. Late orders vs. total orders - missing
employee
There's an employee missing in the answer from the
problem above. Fix the SQL to show all employees who
have taken orders.

Expected Result
EmployeeID LastName AllOrders LateOrders
----------- -------------------- ----------- -----------
1 Davolio 123 3
2 Fuller 96 4
3 Leverling 127 5
4 Peacock 156 10
5 Buchanan 42 NULL
6 Suyama 67 3
7 King 72 4
8 Callahan 104 5
9 Dodsworth 43 5
(9 row(s) affected)
*/

;With LateOrders as 
(
	Select EmployeeID, TotalOrders = Count(*)
	From Orders
	Where RequiredDate <= ShippedDate
	Group By EmployeeId
)
, AllOrders as 
(
	Select EmployeeID, TotalOrders = Count(*)
	From Orders
	Group By EmployeeID
)

Select	employees.employeeid
		, LastName
		, AllOrders = AllOrders.TotalOrders
		, LateOrders = LateOrders.TotalOrders
		From Employees
		Join AllOrders ON AllOrders.EmployeeId = Employees.EmployeeID
		Left Join LateOrders on LateOrders.EmployeeID = Employees.EmployeeID