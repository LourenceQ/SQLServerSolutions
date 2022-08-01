/*
1. Which shippers do we have?
We have a table called Shippers. Return all the fields
from all the shippers

Expected Results
ShipperID CompanyName Phone
----------- ---------------------------------------- ------------------------
1 Speedy Express (503) 555-9831
2 United Package (503) 555-3199
3 Federal Shipping (503) 555-9931
(3 row(s) affected)
*/

use Northwind;

select * from shippers;