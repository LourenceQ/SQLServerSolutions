/*
49. Customer grouping - fix null
There's a bug with the answer for the previous question.
The CustomerGroup value for one of the rows is null.
Fix the SQL so that there are no nulls in the
CustomerGroup field.
Expected Result
(Including only a subset of the output)

CustomerID CompanyName TotalOrderAmount CustomerGroup
---------- ------------------------------- --------------------- -------------
LILAS LILA-Supermercado 5994.06 High
LINOD LINO-Delicateses 10085.60 Very High
LONEP Lonesome Pine Restaurant 1709.40 Medium
MAGAA Magazzini Alimentari Riuniti 1693.00 Medium
MAISD Maison Dewey 5000.20 High
MORGK Morgenstern Gesundkost 245.00 Low
NORTS North/South 45.00 Low
OCEAN Océano Atlántico Ltda. 3031.00 Medium
OLDWO Old World Delicatessen 5337.65 High
OTTIK Ottilies Käseladen 3012.70 Medium
PERIC Pericles Comidas clásicas 1496.00 Medium
PICCO Piccolo und mehr 4393.75 Medium
PRINI Princesa Isabel Vinhos 2633.90 Medium
QUEDE Que Delícia 1353.60 Medium
QUEEN Queen Cozinha 7007.65 High
QUICK QUICK-Stop 40526.99 Very High
RANCH Rancho grande 1694.70 Medium
RATTC Rattlesnake Canyon Grocery 21725.60 Very High
REGGC Reggiani Caseifici 4263.00 Medium
RICAR Ricardo Adocicados 7312.00 High
*/
WITH orders2016
     AS (SELECT customers.customerid,
                customers.companyname,
                TotalOrderAmount = Sum(quantity * unitprice)
         FROM   customers
                JOIN orders
                  ON orders.customerid = customers.customerid
                JOIN [order details]
                  ON orders.orderid = [order details].orderid
         WHERE  orderdate >= '19960101'
                AND orderdate < '19970101'
         GROUP  BY customers.customerid,
                   customers.companyname)
SELECT customerid,
       companyname,
       totalorderamount,
       CustomerGroup = CASE
                         WHEN totalorderamount >= 0
                              AND totalorderamount < 1000 THEN 'Low'
                         WHEN totalorderamount >= 1000
                              AND totalorderamount < 5000 THEN 'Medium'
                         WHEN totalorderamount >= 5000
                              AND totalorderamount < 10000 THEN 'High'
                         WHEN totalorderamount >= 10000 THEN 'Very High'
                       END
FROM   orders2016
ORDER  BY customerid 