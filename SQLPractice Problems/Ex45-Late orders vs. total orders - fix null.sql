/*
45. Late orders vs. total orders - fix null
Continuing on the answer for above query, let's fix the
results for row 5 - Buchanan. He should have a 0 instead
of a Null in LateOrders.

Expected Result
EmployeeID LastName AllOrders LateOrders
----------- -------------------- ----------- -----------
1 Davolio 123 3
2 Fuller 96 4
3 Leverling 127 5
4 Peacock 156 10
5 Buchanan 42 0
6 Suyama 67 3
7 King 72 4
8 Callahan 104 5
9 Dodsworth 43 5
(9 row(s) affected)

Hint
Find a function to test if a value is null, and return a
different value when it is.
*/
;
WITH lateorders AS
(
    SELECT employeeid, totalorders = Count(*)
    FROM orders
    WHERE requireddate <= ShippedDate
    GROUP BY employeeid
)
, allorders AS
(
    SELECT employeeid, totalorders = Count(*)
    FROM orders
    GROUP BY employeeid
)
SELECT	employees.employeeid,
        lastname,
        allorders = allorders.totalorders,
        lateorders = IsNull(lateorders.totalorders, 0)
		FROM employees 
		join allorders ON allorders.employeeid = employees.employeeid
		LEFT JOIN lateorders ON lateorders.employeeid = employees.employeeid

/*
Discussion

Using a straightforward IsNull on LateOrder is the best
way to solve this problem.
Another way to write it would be using a Case statement

LateOrders =
Case
When LateOrders.TotalOrders is null Then 0
Else LateOrders.TotalOrders
End

But when you don’t need any other logic besides a test
for null, IsNull is the way to go.
*/
