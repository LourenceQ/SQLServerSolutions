/*
26. High freight charges - 2015
We're continuing on the question above on high freight
charges. Now, instead of using all the orders we have, we
only want to see orders from the year 2015.

Expected result
ShipCountry AverageFreight
--------------- ---------------------
Austria 178.3642
Switzerland 117.1775
France 113.991
(3 row(s) affected)
*/

USE northwind

SELECT TOP 3 shipcountry,
             Avg(freight) AS AverageFreight
FROM   orders
WHERE  Year(orderdate) = 1998
GROUP  BY shipcountry
ORDER  BY Avg(freight) DESC 
