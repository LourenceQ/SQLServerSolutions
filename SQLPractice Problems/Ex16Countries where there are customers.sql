/*
16. Countries where there are customers
Show a list of countries where the Northwind company
has customers.

Expected Results
Country
---------------
Argentina
Austria
Belgium
Brazil
Canada
Denmark
Finland
France
Germany
Ireland
Italy
Mexico
Norway
Poland
Portugal
Spain
Sweden
Switzerland
UK
USA
Venezuela
(21 row(s) affected)
*/

USE northwind;

SELECT DISTINCT( country ) AS Country
FROM   customers; 