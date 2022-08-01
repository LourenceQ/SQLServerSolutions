/*
21. Total customers per country/city
In the Customers table, show the total number of
customers per Country and City.

Expected Results
Country City TotalCustomer
--------------- --------------- -------------
UK London 6
Mexico M�xico D.F. 5
Brazil Sao Paulo 4
Brazil Rio de Janeiro 3
Spain Madrid 3
Argentina Buenos Aires 3
France Paris 2
USA Portland 2
France Nantes 2
Portugal Lisboa 2
Finland Oulu 1
Italy Reggio Emilia 1
France Reims 1
Brazil Resende 1
... (skipping some rows)
Canada Montr�al 1
Germany M�nchen 1
Germany M�nster 1
Germany Aachen 1
USA Albuquerque 1
USA Anchorage 1
Denmark �rhus 1
Spain Barcelona 1
Venezuela Barquisimeto 1
Italy Bergamo 1
Germany Berlin 1
Switzerland Bern 1
USA Boise 1
Sweden Br�cke 1
Germany Brandenburg 1
Belgium Bruxelles 1
(69 row(s) affected)
*/

USE northwind;

SELECT country,
       city,
       Count(customerid) AS TotalCustomers
FROM   customers
GROUP  BY country,
          city
ORDER  BY Count (customerid) DESC; 
