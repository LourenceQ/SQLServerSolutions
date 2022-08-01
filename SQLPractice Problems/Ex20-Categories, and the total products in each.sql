select * from categories
select * from Products

select CategoryName
	   , count(P.CategoryId) as totalProducts
from Categories as C
join Products as P
on	P.CategoryId = C.CategoryId


/*
20. Categories, and the total products in each
category
For this problem, we’d like to see the total number of
products in each category. Sort the results by the total
number of products, in descending order.

Expected Results
CategoryName TotalProducts
--------------- -------------
Confections 13
Beverages 12
Condiments 12
Seafood 12
Dairy Products 10
Grains/Cereals 7
Meat/Poultry 6
Produce 5
(8 row(s) affected)
*/
USE northwind;

SELECT C.categoryname,
       Count(p.productid) AS TotalProducts
FROM   products AS P
       JOIN categories AS C
         ON P.categoryid = C.categoryid
GROUP  BY C.categoryname
ORDER  BY Count (P.productid) DESC;

SELECT Count(productid) AS TotalProducts
FROM   products; 