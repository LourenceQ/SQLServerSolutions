/*
40. Orders - accidental double-entry details,
derived table
Here's another way of getting the same results as in the
previous problem, using a derived table instead of a CTE.
However, there's a bug in this SQL. It returns 20 rows
instead of 16. Correct the SQL.

Problem SQL:
SELECT OrderDetails.OrderID,
       ProductID,
       UnitPrice,
       Quantity,
       Discount
FROM OrderDetails
JOIN
  (SELECT OrderID
   FROM OrderDetails
   WHERE Quantity >= 60
   GROUP BY OrderID,
            Quantity
   HAVING Count(*) > 1) PotentialProblemOrders ON PotentialProblemOrders.OrderID = OrderDetails.OrderID
ORDER BY OrderID,
         ProductID

Hint
Your first step should be to run the SQL in the derived table

SELECT OrderID
FROM OrderDetails
WHERE Quantity >= 60
GROUP BY OrderID,
         Quantity
HAVING Count(*) > 1

What do you notice about the results?
Hint
There are 2 rows for OrderID 10263, because there are 2
sets of rows that have the same, identical quantity, that's
60 or above.
When you do a join to a table that has duplicates, you
will get duplicates in the output as well, unless you take
steps to avoid it.
Find a single keyword that you can easily add to avoid
duplicates in SQL.
*/
USE	Northwind;
SELECT [Order Details].orderid,
       productid,
       unitprice,
       quantity,
       discount
FROM   [Order Details]
       JOIN (SELECT DISTINCT orderid
             FROM   [Order Details]
             WHERE  quantity >= 60
             GROUP  BY orderid,
                       quantity
             HAVING Count(*) > 1) PotentialProblemOrders
         ON PotentialProblemOrders.orderid = [Order Details].orderid
ORDER  BY orderid,
          productid 