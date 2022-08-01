/*
32. High-value customers
We want to send all of our high-value customers a special
VIP gift. We're defining high-value customers as those
who've made at least 1 order with a total value (not
including the discount) equal to $10,000 or more. We
only want to consider orders made in the year 2016.

Expected Result

CustomerID CompanyName OrderID TotalOrderAmount
---------- ---------------------------------------- ----------- ---------------------
QUICK QUICK-Stop 10865 17250.00
SAVEA Save-a-lot Markets 11030 16321.90
HANAR Hanari Carnes 10981 15810.00
KOENE Königlich Essen 10817 11490.70
RATTC Rattlesnake Canyon Grocery 10889 11380.00
HUNGO Hungry Owl All-Night Grocers 10897 10835.24
(6 row(s) affected)
*/

select * from orders
select * from customers
select * from [Order Details]
select count(UnitPrice) from [Order Details]


select	C.Customerid, 
		C.CompanyName, 
		O.OrderId, (
		select Count(OD.unitprice) as TotalOrdersAmount 
			from [Order Details] as OD) 

from	Customers as C
right join Orders as O on C.CustomerId
where	O.Orderid = C.CustomerId;

/***/

select	C.CustomerId, 
		C.CompanyName, 
		O.OrderId,
		TotalOrderAmount = Sum(Quantity * UnitPrice)

from	Customers as C

join	Orders as O 
		on O.CustomerId = C.CustomerId
join	[Order Details] as OD
		on O.OrderId = OD.OrderId

where	O.OrderDate >= '19970101'
	and OrderDate < '19980101'

group by	C.CustomerId,
			C.CompanyName,
			O.OrderId

having		sum(quantity*unitPrice) > 10000
order by	TotalOrderAmount Desc;
			

