/*
14. How many customers?
How many customers do we have in the Customers table?
Show one value only, and don’t rely on getting the
recordcount at the end of a resultset.

Expected Results
TotalCustomers
--------------
91
(1 row(s) affected)
*/

use Northwind;
SELECT Count([customerid]) AS TotalCustomers
FROM   [Northwind].[dbo].[customers]; 