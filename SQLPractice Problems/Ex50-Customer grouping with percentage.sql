/*
50. Customer grouping with percentage
Based on the above query, show all the defined
CustomerGroups, and the percentage in each. Sort by the
total in each group, in descending order.
Expected Result

CustomerGroup TotalInGroup PercentageInGroup
------------- ------------ ---------------------------------------
Medium 35 0.432098765432
Low 20 0.246913580246
High 13 0.160493827160
Very High 13 0.160493827160
(4 row(s) affected)
*/

WITH orders2016
     AS (SELECT customers.customerid,
                customers.companyname,
                TotalOrderAmount = Sum(quantity * unitprice)
         FROM   customers
                JOIN orders
                  ON orders.customerid = customers.customerid
                JOIN [order details]
                  ON orders.orderid = [order details].orderid
         WHERE  orderdate >= '19960101'
                AND orderdate < '19970101'
         GROUP  BY customers.customerid,
                   customers.companyname)
, CustomerGrouping as (
SELECT customerid,
       companyname,
       totalorderamount,
       CustomerGroup = CASE
                         WHEN totalorderamount >= 0
                              AND totalorderamount < 1000 THEN 'Low'
                         WHEN totalorderamount >= 1000
                              AND totalorderamount < 5000 THEN 'Medium'
                         WHEN totalorderamount >= 5000
                              AND totalorderamount < 10000 THEN 'High'
                         WHEN totalorderamount >= 10000 THEN 'Very High'
                       END
FROM   orders2016
--ORDER  BY customerid
)
SELECT	CustomerGroup
		, TotalInGroup = COUNT(*)
		, PercentageInGroup = Count(*) *1.0/(
		SELECT COUNT(*) FROM CustomerGrouping)
		FROM CustomerGrouping
		GROUP BY CustomerGroup
		ORDER BY TotalInGroup DESC


/*
Discussion
In the answer we added an intermediate CTE called
CustomerGrouping. CustomerGrouping is referenced
twice - once to get the total number of customers in the
group, and once to get the total, as the denominator for
the percentage.
Notice that the Order by in the second CTE is commented
out. If you leave it in, you get this error:
Msg 1033, Level 15, State 1, Line 32
The ORDER BY clause is invalid in views, inline functions, derived tables,
subqueries, and common table expressions, unless TOP, OFFSET or FOR XML
is also specified

*/