/*
43. Late orders vs. total orders
Andrew, the VP of sales, has been doing some more
thinking some more about the problem of late orders. He
realizes that just looking at the number of orders arriving
late for each salesperson isn't a good idea. It needs to be
compared against the total number of orders per
salesperson. Return results like the following:

Expected Result
EmployeeID LastName AllOrders LateOrders
----------- -------------------- ----------- -----------
1 Davolio 123 3
2 Fuller 96 4
3 Leverling 127 5
4 Peacock 156 10
6 Suyama 67 3
7 King 72 4
8 Callahan 104 5
9 Dodsworth 43 5
(8 row(s) affected)
*/
USE Northwind;

select * FROM [Order Details]
SELECT * FROM Orders

;WITH lateorders
     AS (SELECT employeeid,
                TotalOrders = Count(*)
         FROM   orders
         WHERE  requireddate <= shippeddate
         GROUP  BY employeeid),

     allorders
     AS (SELECT employeeid,
                TotalOrders = Count(*)
         FROM   orders
         GROUP  BY employeeid)

SELECT employees.employeeid,
       lastname,
       AllOrders = allorders.totalorders,
       LateOrders = lateorders.totalorders
FROM   employees
       JOIN allorders
         ON allorders.employeeid = employees.employeeid
       JOIN lateorders
         ON lateorders.employeeid = employees.employeeid 

/*retornar a quantidade de pedidos que vinet fez com empregado 5*/
SELECT	 O.CustomerId
		 ,COUNT(O.CustomerId) as TotalOfOrders		 
FROM	 Orders as O
GROUP BY	O.CustomerId
ORDER BY	O.CustomerId ASC

SELECT	CustomerId FROM	Orders 
WHERE	CustomerId = 'VINET';





