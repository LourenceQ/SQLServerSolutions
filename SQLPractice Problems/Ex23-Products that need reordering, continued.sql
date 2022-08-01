/*
23. Products that need reordering, continued
Now we need to incorporate these fields—UnitsInStock,
UnitsOnOrder, ReorderLevel, Discontinued—into our
calculation. We’ll define “products that need reordering”
with the following:
UnitsInStock plus UnitsOnOrder are less than or
equal to ReorderLevel
The Discontinued flag is false (0).

Expected Results
ProductID ProductName UnitsInStock UnitsOnOrder ReorderLevel
Discontinued
----------- ----------------------- ------------ ------------ ------------ ------------
30 Nord-Ost Matjeshering 10 0 15 0
70 Outback Lager 15 10 30 0
(2 row(s) affected)
*/

use Northwind;
select ProductID, 
	ProductName, 
	UnitsInStock, 
	UnitsOnOrder, 
	ReorderLevel, 
	Discontinued from Products
where UnitsInStock + UnitsOnOrder <= ReorderLevel
	and Discontinued = '0';
