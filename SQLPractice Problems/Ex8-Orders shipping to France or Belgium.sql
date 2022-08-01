/*
8. Orders shipping to France or Belgium
Looking at the Orders table, there’s a field called
ShipCountry. Write a query that shows the OrderID,
CustomerID, and ShipCountry for the orders WHERE the
ShipCountry is either France or Belgium.

Expected Results
OrderID CustomerID ShipCountry
----------- ---------- ---------------
10248 VINET France
10251 VICTE France
10252 SUPRD Belgium
10265 BLONP France
10274 VINET France
10295 VINET France
10297 BLONP France
10302 SUPRD Belgium
10311 DUMON France
10331 BONAP France
10334 VICTE France
10340 BONAP France
10350 LAMAI France
10358 LAMAI France
... (skipping some rows)
10923 LAMAI France
10927 LACOR France
10930 SUPRD Belgium
10932 BONAP France
10940 BONAP France
10964 SPECD France
10971 FRANR France
10972 LACOR France
10973 LACOR France
10978 MAISD Belgium
11004 MAISD Belgium
11035 SUPRD Belgium
11038 SUPRD Belgium
11043 SPECD France
11051 LAMAI France
11076 BONAP France
(96 row(s) affected)
*/


SELECT OrderId, CustomerId, ShipCountry FROM orders
WHERE ShipCountry = 'France' or ShipCountry = 'Belgium';

SELECT OrderId, CustomerId, ShipCountry FROM orders
WHERE ShipCountry IN ('France','Belgium');