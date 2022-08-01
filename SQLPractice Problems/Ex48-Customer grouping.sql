/*
48. Customer grouping
Andrew Fuller, the VP of sales at Northwind, would like
to do a sales campaign for existing customers. He'd like
to categorize customers into groups, based on how much
they ordered in 2016. Then, depending on which group
the customer is in, he will target the customer with
different sales materials.
The customer grouping categories are 0 to 1,000, 1,000 to
5,000, 5,000 to 10,000, and over 10,000.
A good starting point for this query is the answer from
the problem “High-value customers - total orders. We
don’t want to show customers who don’t have any orders
in 2016.
Order the results by CustomerID.

Expected Result
CustomerID companyname TotalOrderAmount CustomerGroup
---------- ---------------------------------------- --------------------- -------------
ALFKI Alfreds Futterkiste 2302.20 Medium
ANATR Ana Trujillo Emparedados y helados 514.40 Low
ANTON Antonio Moreno Taquería 660.00 Low
AROUT Around the Horn 5838.50 High
BERGS Berglunds snabbköp 8110.55 High
BLAUS Blauer See Delikatessen 2160.00 Medium
BLONP Blondesddsl père et fils 730.00 Low
BOLID Bólido Comidas preparadas 280.00 Low
BONAP Bon app' 7185.90 High
BOTTM Bottom-Dollar Markets 12227.40 Very High
BSBEV B's Beverages 2431.00 Medium
CACTU Cactus Comidas para llevar 1576.80 Medium
CHOPS Chop-suey Chinese 4429.40 Medium
... (skipping some rows)
SPLIR Split Rail Beer & Ale 1117.00 Medium
SUPRD Suprêmes délices 11862.50 Very High
THEBI The Big Cheese 69.60 Low
THECR The Cracker Box 326.00 Low
TOMSP Toms Spezialitäten 910.40 Low
TORTU Tortuga Restaurante 1874.50 Medium
TRADH Tradição Hipermercados 4401.62 Medium
TRAIH Trail's Head Gourmet Provisioners 237.90 Low
VAFFE Vaffeljernet 4333.50 Medium
VICTE Victuailles en stock 3022.00 Medium
WANDK Die Wandernde Kuh 1564.00 Medium
WARTH Wartian Herkku 300.00 Low
WELLI Wellington Importadora 1245.00 Medium
WHITC White Clover Markets 15278.90 Very High
WILMK Wilman Kala 1987.00 Medium
WOLZA Wolski Zajazd 1865.10 Medium
(81 row(s) affected)
*/

WITH orders2016 as (
	 SELECT customers.customerid
			, customers.companyname
			, totalorderamount = SUM(quantity * unitprice)
			FROM customers
			JOIN orders
			ON orders.customerid = customers.customerid
			JOIN [Order Details]
			ON orders.orderid = [Order Details].orderid
		WHERE 
			orderdate >= '20160101'
			and orderdate < '20170101'
		GROUP BY 
			customers.customerid
			, customers.companyname)
SELECT	customerid
		, companyname
		, totalorderamount
		, customergroup = 
			CASE
				WHEN totalorderamount between 0 AND 1000 THEN 'low'
				WHEN totalorderamount between 1001 AND 5000 THEN 'medium'
				WHEN totalorderamount between 5001 AND 10000 THEN 'high'
				WHEN totalorderamount > 10000 THEN 'very high'
			END
	FROM orders2016
	ORDER BY customerid