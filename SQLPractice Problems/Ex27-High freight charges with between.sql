/*
27. High freight charges with between

Another (incorrect) answer to the problem above is this:

Select Top 3
ShipCountry
,AverageFreight = avg(freight)
From Orders
Where
OrderDate between '1/1/2015' and '12/31/2015'
Group By ShipCountry
Order By AverageFreight desc;

Notice when you run this, it gives Sweden as the
ShipCountry with the third highest freight charges.
However, this is wrong - it should be France.
What is the OrderID of the order that the (incorrect)
answer above is missing?
Expected Result
(no expected results this time - we’re looking for a
specific OrderID)
*/

USE northwind;

SELECT TOP 3 shipcountry,
             AverageFreight = Avg(freight)
FROM   orders
WHERE  orderdate BETWEEN '1/1/1998' AND '12/31/1998'
GROUP  BY shipcountry
ORDER  BY averagefreight DESC; 

SELECT orderid,
       freight,
       shipcountry
FROM   orders
WHERE  Year(orderdate) = 1997
       AND orderid NOT IN (SELECT orderid
                           FROM   orders
                           WHERE  orderdate BETWEEN '1/1/1998' AND '12/31/1998')
; 