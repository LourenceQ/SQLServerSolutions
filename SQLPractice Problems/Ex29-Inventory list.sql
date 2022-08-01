/*
29. Inventory list
We're doing inventory, and need to show information like
the below, for all orders. Sort by OrderID and Product
ID.

Expected Results
EmployeeID LastName OrderID ProductName
Quantity
----------- -------------------- ----------- ---------------------------------------- --------
5 Buchanan 10248 Queso Cabrales 12
5 Buchanan 10248 Singaporean Hokkien Fried Mee 10
5 Buchanan 10248 Mozzarella di Giovanni 5
6 Suyama 10249 Tofu 9
6 Suyama 10249 Manjimup Dried Apples 40
4 Peacock 10250 Jack's New England Clam Chowder 10
4 Peacock 10250 Manjimup Dried Apples 35
4 Peacock 10250 Louisiana Fiery Hot Pepper Sauce 15
3 Leverling 10251 Gustaf's Kn�ckebr�d 6
3 Leverling 10251 Ravioli Angelo 15
3 Leverling 10251 Louisiana Fiery Hot Pepper Sauce 20
4 Peacock 10252 Sir Rodney's Marmalade 40
4 Peacock 10252 Geitost 25
4 Peacock 10252 Camembert Pierrot 40
3 Leverling 10253 Gorgonzola Telino 20
3 Leverling 10253 Chartreuse verte 42
3 Leverling 10253 Maxilaku 40
�
(total 2155 rows)
*/

USE northwind;

SELECT E.employeeid,
       E.lastname,
       O.orderid,
       P.productname,
       OD.quantity
FROM   employees AS E
       JOIN orders AS O
         ON O.employeeid = E.employeeid
       JOIN [order details] AS OD
         ON O.orderid = OD.orderid
       JOIN products AS P
         ON P.productid = OD.productid
ORDER  BY O.orderid,
          P.productid 