/*
52. Countries with suppliers or customers
Some Northwind employees are planning a business trip,
and would like to visit as many suppliers and customers
as possible. For their planning, they’d like to see a list of
all countries where suppliers and/or customers are based.
*/
Select Country From Customers
union 
Select  Country From Suppliers
Order by Country

/*
DISCUSSION
There are 2 ways of using the Union statement. One is a
simple Union as in the answer here. Using a simple
Union statement eliminates all the duplicates in the
resultset.
You can also use Union All. Try it and take a look at the
resultset:
Select distinct Country From Customers
Union All
Select distinct Country From Suppliers
Order by Country
Notice that within the individual SQL statements, I’ve
put a Distinct. However, there are still duplicates in the
final output, because we have Union All, which doesn’t
eliminate duplicates.

*/