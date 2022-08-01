/*
53. COUNTRIES WITH SUPPLIERS OR CUSTOMERS,VERSION 2

The employees going on the business trip don’t want just
a raw list of countries, they want more details. We’d like
to see output like the below, in the Expected Results.

EXPECTED RESULT
SupplierCountry CustomerCountry
--------------- ---------------
NULL Argentina
Australia NULL
NULL Austria
NULL Belgium
Brazil Brazil
Canada Canada
Denmark Denmark
Finland Finland
France France
Germany Germany
NULL Ireland
Italy Italy
Japan NULL
NULL Mexico
Netherlands NULL
Norway Norway
NULL Poland
NULL Portugal
Singapore NULL
Spain Spain
Sweden Sweden
NULL Switzerland
UK UK
USA USA
NULL Venezuela
(25 row(s) affected)
*/
;WITH suppliercountries
     AS (SELECT DISTINCT country FROM   suppliers),
     customercountries
     AS (SELECT DISTINCT country FROM   customers)

SELECT SupplierCountry = suppliercountries .country,
       CustomerCountry = customercountries .country
FROM   suppliercountries
       FULL JOIN customercountries
	   ON customercountries.country = suppliercountries.country 


