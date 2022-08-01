/*
24. Customer list by region
A salesperson for Northwind is going on a business trip
to visit customers, and would like to see a list of all
customers, sorted by region, alphabetically.
However, he wants the customers with no region (null in
the Region field) to be at the end, instead of at the top,
where you’d normally find the null values. Within the
same region, companies should be sorted by CustomerID.

Expected Results
CustomerID CompanyName Region
---------- ---------------------------------------- ---------------
OLDWO Old World Delicatessen AK
BOTTM Bottom-Dollar Markets BC
LAUGB Laughing Bacchus Wine Cellars BC
LETSS Let's Stop N Shop CA
HUNGO Hungry Owl All-Night Grocers Co. Cork
GROSR GROSELLA-Restaurante DF
SAVEA Save-a-lot Markets ID
ISLAT Island Trading Isle of Wight
LILAS LILA-Supermercado Lara
THECR The Cracker Box MT
RATTC Rattlesnake Canyon Grocery NM
... (skipping some rows)
SANTG Santé Gourmet NULL
SEVES Seven Seas Imports NULL
SIMOB Simons bistro NULL
SPECD Spécialités du monde NULL
SUPRD Suprêmes délices NULL
TOMSP Toms Spezialitäten NULL
TORTU Tortuga Restaurante NULL
VAFFE Vaffeljernet NULL
VICTE Victuailles en stock NULL
VINET Vins et alcools Chevalier NULL
WANDK Die Wandernde Kuh NULL
WARTH Wartian Herkku NULL
WILMK Wilman Kala NULL
WOLZA Wolski Zajazd NULL
(91 row(s) affected)
*/

USE northwind;

SELECT *
FROM   customers;

SELECT companyname
FROM   customers
ORDER  BY region;

SELECT T.customerid,
       T.companyname,
       T.region
FROM   (SELECT customerid,
               companyname,
               region,
               --case when Region is null then 1 else 0 end as SortField
               CASE
                 WHEN region IS NULL THEN 1
                 ELSE 0
               END AS SortField
        FROM   customers) AS T
ORDER  BY T.sortfield,
          T.region,
          T.customerid;

SELECT customerid,
       companyname,
       region,
       CASE
         WHEN region IS NULL THEN 1
         ELSE 0
       END
FROM   customers

SELECT t.customerid,
       t.companyname,
       t.region
FROM  (SELECT customerid,
              companyname,
              region,
              CASE
                WHEN region IS NULL THEN 1
                ELSE 0
              END AS sortfield
       FROM   customers) AS t
ORDER  BY t.sortfield,
          t.region,
          t.customerid 