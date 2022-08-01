/*
CHAPTER 10. JOINS REVISITED
*/
--OUTER JOINS
use sakila

SELECT f.film_id,
       f.title,
       Count(*) num_copies
FROM   film f
       left JOIN inventory i
               ON f.film_id = i.film_id
GROUP  BY f.film_id,
          f.title--ORDER BY num_copies; 

SELECT f.film_id,
       f.title,
       Count(i.inventory_id) num_copies
FROM   film f
       LEFT OUTER JOIN inventory i
                    ON f.film_id = i.film_id
GROUP  BY f.film_id,
          f.title
--ORDER BY num_copies

SELECT f.film_id,
       f.title,
       i.inventory_id
FROM   film AS f
       LEFT JOIN inventory i
              ON f.film_id = i.film_id
WHERE  f.film_id BETWEEN 13 AND 15

--LEFT VERSUS RIGHT OUTER JOINS
SELECT f.film_id,
       f.title,
       i.inventory_id
FROM   inventory AS i
       RIGHT JOIN film AS f
               ON f.film_id = i.film_id
WHERE  f.film_id BETWEEN 13 AND 15 --THREE-WAY OUTER JOINSselect	f.film_id		, f.title		, i.inventory_id		, r.rental_dateFROM	film as F		LEFT JOIN inventory AS i		ON f.film_id = i.film_id		LEFT JOIN rental AS r		ON i.inventory_id = r.inventory_idWHERE	f.film_id BETWEEN 13 AND 15;--CROSS JOINSSELECT ones.num + tens.num + hundreds.num
FROM
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num) ones
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 10 num UNION ALL
SELECT 20 num UNION ALL
SELECT 30 num UNION ALL
SELECT 40 num UNION ALL
SELECT 50 num UNION ALL
SELECT 60 num UNION ALL
SELECT 70 num UNION ALL
SELECT 80 num UNION ALL
SELECT 90 num) tens
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 100 num UNION ALL
SELECT 200 num UNION ALL
 SELECT 300 num) hundreds; -- SELECT DATEADD(dd,'2020-01-01',
(ones.num + tens.num + hundreds.num))
dt  FROM
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num) ones
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 10 num UNION ALL
SELECT 20 num UNION ALL
SELECT 30 num UNION ALL
SELECT 40 num UNION ALL
SELECT 50 num UNION ALL
SELECT 60 num UNION ALL
SELECT 70 num UNION ALL
SELECT 80 num UNION ALL
SELECT 90 num) tens
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 100 num UNION ALL
SELECT 200 num UNION ALL
SELECT 300 num) hundreds
WHERE DATEADD(dd,'2020-01-01',
(ones.num + tens.num + hundreds.num))
< '2021-01-01'
ORDER BY 1;--SELECT days.dt, COUNT(r.rental_id) num_rentals
FROM rental r
RIGHT OUTER JOIN
(SELECT DATE_ADD('2005-01-01',
INTERVAL (ones.num + tens.num + hundreds.num)
DAY) dt
FROM
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num) ones
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 10 num UNION ALL
SELECT 20 num UNION ALL
SELECT 30 num UNION ALL
SELECT 40 num UNION ALL
SELECT 50 num UNION ALL
SELECT 60 num UNION ALL
SELECT 70 num UNION ALL
SELECT 80 num UNION ALL
SELECT 90 num) tens
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 100 num UNION ALL
SELECT 200 num UNION ALL
SELECT 300 num) hundreds
WHERE DATE_ADD('2005-01-01',
INTERVAL (ones.num + tens.num + hundreds.num)
DAY)
< '2006-01-01'
) days
ON days.dt = date(r.rental_date)
GROUP BY days.dt
ORDER BY 1;

--select customer_id , lower(concat( first_name, ' ', last_name)) AS full_name from customerselect customer_id from rentalselect * from INFORMATION_SCHEMA.tablesselect * from customerselect * from store select * from payment select * from category select * from customer_list select * from inventory