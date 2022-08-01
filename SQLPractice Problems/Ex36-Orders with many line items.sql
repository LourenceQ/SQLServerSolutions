/*
36. Orders with many line items
The Northwind mobile app developers are testing an app
that customers will use to show orders. In order to make
sure that even the largest orders will show up correctly on
the app, they'd like some samples of orders that have lots
of individual line items. Show the 10 orders with the
most line items, in order of total line items.

Os desenvolvedores de aplicativos móveis da Northwind estão testando um aplicativo
que os clientes usarão para mostrar os pedidos. Para fazer
certeza de que mesmo os maiores pedidos aparecerão corretamente em
o aplicativo, eles gostariam de algumas amostras de pedidos com muitos
itens de linha individuais. Mostre as 10 ordens com a
maioria dos itens de linha, na ordem do total de itens de linha.

Expected Result
OrderID TotalOrderDetails
----------- -----------------
11077 25
10979 6
10657 6
10847 6
10845 5
10836 5
10714 5
10670 5
10691 5
10698 5
(10 row(s) affected)
*/

select * from orders
select * from [Order Details]


select top 10 orders.orderid, totalorderdetails = count(*)
from orders
join [order details]
on orders.orderid = [order details].orderid
group by orders.orderid
order by count(*) desc

select top  10 o.orderid, totalorderdateils = count(*)
from orders as o
join [order details] as od
on o.orderid = od.orderid
group by o.orderid
order by count(*) desc


SELECT TOP 10 WITH ties orders.orderid,
                        totalorderdetails = Count(*)
FROM   orders
       JOIN [order details]
         ON orders.orderid = [order details].orderid
GROUP  BY orders.orderid
ORDER  BY Count(*) DESC 