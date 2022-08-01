/*
47. Late orders vs. total orders - fix decimal
So now for the PercentageLateOrders, we get a decimal
value like we should. But to make the output easier to
read, let's cut the PercentLateOrders off at 2 digits to the
right of the decimal point.

Expected Result
EmployeeID LastName AllOrders LateOrders PercentLateOrders
----------- -------------------- ----------- ----------- -------------------
1 Davolio 123 3 0.02
2 Fuller 96 4 0.04
3 Leverling 127 5 0.04
4 Peacock 156 10 0.06
5 Buchanan 42 0 0.00
6 Suyama 67 3 0.04
7 King 72 4 0.06
8 Callahan 104 5 0.05
9 Dodsworth 43 5 0.12
(9 row(s) affected)
*/
WITH lateorders
     AS (SELECT employeeid,
                totalorders = COUNT(*)
         FROM   orders
         WHERE  requireddate <= shippeddate
         GROUP  BY employeeid),

     allorders
     AS (SELECT employeeid,
                totalorders = COUNT(*)
         FROM   orders
         GROUP  BY employeeid)

SELECT employees.employeeid,
       lastname
	   , allorders = allorders.totalorders
	   , lateorders = ISNULL(lateorders.totalorders, 0)
	   , percentlateorders = CONVERT (DECIMAL(10, 2)
	   , (ISNULL(lateorders.totalorders, 0)* 1.00 ) /allorders.totalorders)
FROM   employees
       JOIN allorders
         ON allorders.employeeid = employees.employeeid
       LEFT JOIN lateorders
         ON lateorders.employeeid = employees.employeeid 

select * from INFORMATION_SCHEMA.tables;