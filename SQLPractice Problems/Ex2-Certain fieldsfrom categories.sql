/*
2. Certain fields from Categories
In the Categories table, selecting all the fields using this
SQL:
Select * from Categories
…will return 4 columns. We only want to see two
columns, CategoryName and Description.

Expected Results
CategoryName Description
--------------- ----------------------------------------------------------
Beverages Soft drinks, coffees, teas, beers, and ales
Condiments Sweet and savory sauces, relishes, spreads, and seasonings
Confections Desserts, candies, and sweet breads
Dairy Products Cheeses
Grains/Cereals Breads, crackers, pasta, and cereal
Meat/Poultry Prepared meats
Produce Dried fruit and bean curd
Seafood Seaweed and fish
(8 row(s) affected)
*/

use Northwind;
select CategoryName, Description from Categories;