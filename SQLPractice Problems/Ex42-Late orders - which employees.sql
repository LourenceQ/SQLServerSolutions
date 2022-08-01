/*
42. Late orders - which employees?
Some salespeople have more orders arriving late than
others. Maybe they're not following up on the order
process, and need more training. Which salespeople have
the most orders arriving late?

Expected Result
EmployeeID LastName TotalLateOrders
----------- -------------------- ---------------
4 Peacock 10
3 Leverling 5
8 Callahan 5
9 Dodsworth 5
7 King 4
2 Fuller 4
1 Davolio 3
6 Suyama 3
(8 row(s) affected)
*/

SELECT * FROM Employees
SELECT * FROM Orders

SELECT	E.EmployeeId
		,E.LastName
		,TotalLateOrders = Count(*)
FROM	Orders as O

Join	Employees as E
On		E.EmployeeId = O.EmployeeId	
WHERE	RequiredDate <= ShippedDate

GROUP BY	E.EmployeeID
			,E.Lastname

ORDER BY TotalLateOrders DESC