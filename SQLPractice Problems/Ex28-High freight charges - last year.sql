/*
28. High freight charges - last year

We're continuing to work on high freight charges. We
now want to get the three ship countries with the highest
average freight charges. But instead of filtering for a
particular year, we want to use the last 12 months of
order data, using as the end date the last OrderDate in
Orders.
Expected Results
ShipCountry AverageFreight
--------------- ---------------------
Ireland 200.21
Austria 186.4596
USA 119.3032
(3 row(s) affected)
*/

USE northwind

SELECT TOP 3 shipcountry,
             Avg(freight) AS AverageFrieght
FROM   orders
WHERE  orderdate BETWEEN Dateadd(yy, -1, (SELECT Max(orderdate)
                                          FROM   orders)) AND
                         (SELECT Max(orderdate)
                          FROM   orders)
GROUP  BY shipcountry
ORDER  BY Avg(freight) DESC; 




select top 3 ShipCountry, avg(freight) as averageFreight
from orders
where orderdate between dateadd(yy, -1,(select max(orderdate) from orders)) and (select max(OrderDate) from orders)

group by ShipCountry

order by avg(freight) desc;

select * from orders



SELECT customerid,       
       (SELECT CONVERT(VARCHAR(10), orderdate, 23) AS orderdate)
FROM   orders
WHERE  orderdate BETWEEN Dateadd(yy, -1, (SELECT Max(orderdate)
                                          FROM   orders)) AND
                         (SELECT Max(orderdate)
                          FROM   orders) 
