/*
Chapter 9. Subqueries

Subqueries are a powerful tool that you can use in all four SQL data
statements. In this chapter, I�ll show you how subqueries can be used
to filter data, generate values, and construct temporary data sets.
After a little experimentation, I think you�ll agree that subqueries are
one of the most powerful features of the SQL language.
*/

USE sakila

SELECT customer_id, first_name, last_name
  FROM customer
  WHERE customer_id = (SELECT MAX(customer_id) FROM customer);

-- Noncorrelated Subqueries
       fa.film_id
FROM   film_actor AS fa
WHERE  fa.actor_id IN (SELECT actor_id
                       FROM   actor
                       WHERE  last_name = 'MONROE')
       AND fa.film_id IN (SELECT film_id
                          FROM   film
                          WHERE  rating = 'PG');

--CORRELATED SUBQUERIES
			 WHERE r.customer_id = c.customer_id)

SELECT	c.first_name, c.last_name
FROM	customer AS c
WHERE   (SELECT SUM(p.amount) 
		FROM payment p
		WHERE p.customer_id = c.customer_id)
		BETWEEN 180 AND 240;

--THE EXISTS OPERATOR
WHERE  365 < (SELECT Datediff(dd, Getdate(), r.rental_date)
              FROM   rental r
                     INNER JOIN customer
                             ON r.customer_id = customer.customer_id); 
       customer.last_name,
       pymnt.num_rentals,
       pymnt.tot_payments
FROM   customer
       INNER JOIN (SELECT customer_id,
                          Count(*)    num_rentals,
                          Sum(amount) tot_payments
                   FROM   payment
                   GROUP  BY customer_id) pymnt
               ON customer.customer_id = pymnt.customer_id; 
       0           low_limit,
       74.99       high_limit
UNION ALL
SELECT 'Average Joes' NAME,
       75             low_limit,
       149.99         high_limit
UNION ALL
SELECT 'Heavy Hitters' NAME,
       150             low_limit,
       9999999.99      high_limit; 
			   0           low_limit,
			   74.99       high_limit
		UNION ALL
		SELECT 'Average Joes' NAME,
			   75             low_limit,
			   149.99         high_limit
		UNION ALL
		SELECT 'Heavy Hitters' NAME,
			   150             low_limit,
			   9999999.99      high_limit 
       c.last_name,
       ct.city,
       Sum(p.amount) AS tot_payments,
       Count(*)      AS tot_rentals
FROM   payment AS p
       INNER JOIN customer AS c
               ON p.customer_id = c.customer_id
       INNER JOIN address AS a
               ON c.address_id = a.address_id
       INNER JOIN city AS ct
               ON a.city_id = ct.city_id
GROUP  BY c.first_name,
          c.last_name,
          ct.city 

--
SELECT customer_id,
       Count(*)    AS tot_rentals,
       Sum(amount) AS tot_payments
FROM   payment
GROUP  BY customer_id 

--
SELECT c.first_name,
       c.last_name,
       ct.city,
       pymnt.tot_payments,
       pymnt.tot_rentals
FROM  (SELECT customer_id,
              Count(*)    AS tot_rentals,
              Sum(amount) AS tot_payments
       FROM   payment
       GROUP  BY customer_id
	   ) AS pymnt
      INNER JOIN customer AS c
              ON pymnt.customer_id = c.customer_id
      INNER JOIN address AS a
              ON c.address_id = a.address_id
      INNER JOIN city AS ct
              ON a.city_id = ct.city_id

--COMMON TABLE EXPRESSIONS