/*
55. FIRST ORDER IN EACH COUNTRY
Looking at the Orders table—we’d like to show details
for each order that was the first in that particular country,
ordered by OrderID.
So, we need one row per ShipCountry, and CustomerID,
OrderID, and OrderDate should be of the first order from
that country.
*/

with ordersByCountry 
as 
(select	shipCountry
		, customerId
		, orderId, orderdate = convert(date, orderdate)
		, rowNumberPerCountry = ROW_NUMBER() 
		over (partition by shipcountry order by shipcountry, orderid)
from orders)

select shipCountry, customerId, orderId, orderDate 
from ordersByCountry
where rowNumberPerCountry = 1
order by shipCountry

--
;WITH firstorderpercountry
     AS (SELECT shipcountry,
                MinOrderID = Min(orderid)
         FROM   orders
         GROUP  BY shipcountry)
SELECT orders.shipcountry,
       customerid,
       orderid
FROM   firstorderpercountry
       JOIN orders
         ON orders.orderid = firstorderpercountry.minorderid
ORDER  BY orders.shipcountry 