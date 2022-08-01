/*
34. High-value customers - with discount
Change the above query to use the discount when
calculating high-value customers. Order by the total
amount which includes the discount.

Expected Result
CustomerID CompanyName					TotalsWithoutDiscount    TotalsWithDiscount
---------- ------------------------------ --------------------- ----------------------
ERNSH Ernst Handel 42598.90 41210.6500244141
QUICK QUICK-Stop 40526.99 37217.3150024414
SAVEA Save-a-lot Markets 42806.25 36310.1097793579
HANAR Hanari Carnes 24238.05 23821.1999893188
RATTC Rattlesnake Canyon Grocery 21725.60
21238.2704410553
HUNGO Hungry Owl All-Night Grocers 22796.34
20402.119934082
KOENE Königlich Essen 20204.95 19582.7739868164
WHITC White Clover Markets 15278.90 15278.8999862671
FOLKO Folk och fä HB 15973.85 13644.0674972534
SUPRD Suprêmes délices 11862.50 11644.5999984741
BOTTM Bottom-Dollar Markets 12227.40 11338.5500488281
(11 row(s) affected)
*/

Select * from orders

Select * from [order details] order by Discount desc


select	c.customerId,
		c.CompanyName,
		TotalsWithDiscount = sum((quantity* unitPrice) * (1- discount)),
		TotalsWithoutDiscount = sum(quantity* unitPrice)
from Customers as c

join	Orders as o
		on o.customerid = c.customerid

join	[order details] as od
		on od.orderid = o.orderid

where	o.OrderDate >= '19970101'
		and OrderDate < '19980101'

group by	c.CustomerID,
			c.Companyname
having		sum((quantity*unitprice) * (1-discount)) > 15000
order by	TotalsWithDiscount desc;

