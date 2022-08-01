/*
15. When was the first order?
Show the date of the first order ever made in the Orders
table.

Expected Results
FirstOrder
-----------------------
2014-07-04 08:00:00.000
(1 row(s) affected)
*/

USE northwind;

SELECT Min (orderdate) AS FirstOrder
FROM orders; 