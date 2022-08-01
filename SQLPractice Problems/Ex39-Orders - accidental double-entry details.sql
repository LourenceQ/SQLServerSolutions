/*
39. Orders - accidental double-entry details
Based on the previous question, we now want to show
details of the order, for orders that match the above
criteria.

Expected Result
OrderID ProductID UnitPrice Quantity Discount
----------- ----------- --------------------- -------- -------------
10263 16 13.90 60 0.25
10263 30 20.70 60 0.25
10263 24 3.60 65 0
10263 74 8.00 65 0.25
10658 60 34.00 55 0.05
10658 21 10.00 60 0
10658 40 18.40 70 0.05
10658 77 13.00 70 0.05
10990 34 14.00 60 0.15
10990 21 10.00 65 0
10990 55 24.00 65 0.15
10990 61 28.50 66 0.15
11030 29 123.79 60 0.25
11030 5 21.35 70 0
11030 2 19.00 100 0.25
11030 59 55.00 100 0.25
(16 row(s) affected)
*/


SELECT	OD.OrderId
		,ProductId
		,UnitPrice
		,Quantity
		,Discount
FROM [Order Details] as OD
join(	SELECT DISTINCT OrderId
From	[Order Details]
WHERE	Quantity >= 60
GROUP BY	OrderId
			,Quantity
HAVING	COUNT(*) > 1)
PotentialProblemOrders
ON	PotentialProblemOrders.OrderId = OD.OrderId
ORDER BY OrderId, ProductId

  