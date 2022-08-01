/*
18. Products with associated supplier names
We�d like to show, for each product, the associated
Supplier. Show the ProductID, ProductName, and the
CompanyName of the Supplier. Sort by ProductID.
This question will introduce what may be a new concept,
the Join clause in SQL. The Join clause is used to join
two or more relational database tables together in a
logical way.
Here�s a data model of the relationship between Products
and Suppliers.

Expected Results
ProductID ProductName Supplier
----------- ---------------------------------------- ------------------------------
1 Chai Exotic Liquids
2 Chang Exotic Liquids
3 Aniseed Syrup Exotic Liquids
4 Chef Anton's Cajun Seasoning New Orleans Cajun Delights
5 Chef Anton's Gumbo Mix New Orleans Cajun Delights
6 Grandma's Boysenberry Spread Grandma Kelly's Homestead
7 Uncle Bob's Organic Dried Pears Grandma Kelly's Homestead
8 Northwoods Cranberry Sauce Grandma Kelly's Homestead
9 Mishi Kobe Niku Tokyo Traders
10 Ikura Tokyo Traders
... (skipping some rows)
66 Louisiana Hot Spiced Okra New Orleans Cajun Delights
67 Laughing Lumberjack Lager Bigfoot Breweries
68 Scottish Longbreads Specialty Biscuits, Ltd.
69 Gudbrandsdalsost Norske Meierier
70 Outback Lager Pavlova, Ltd.
71 Flotemysost Norske Meierier
72 Mozzarella di Giovanni Formaggi Fortini s.r.l.
73 R�d Kaviar Svensk Sj�f�da AB
74 Longlife Tofu Tokyo Traders
75 Rh�nbr�u Klosterbier Plutzer Lebensmittelgro�m�rkte AG
76 Lakkalik��ri Karkki Oy
77 Original Frankfurter gr�ne So�e Plutzer Lebensmittelgro�m�rkte
AG
(77 row(s) affected)
*/

USE northwind;

SELECT productid,
       productname,
       companyname
FROM   products
       JOIN suppliers
         ON products.supplierid = suppliers.supplierid; 