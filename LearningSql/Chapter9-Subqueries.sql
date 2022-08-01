/*
Chapter 9. Subqueries

Subqueries are a powerful tool that you can use in all four SQL data
statements. In this chapter, I’ll show you how subqueries can be used
to filter data, generate values, and construct temporary data sets.
After a little experimentation, I think you’ll agree that subqueries are
one of the most powerful features of the SQL language.
*/

USE sakila

SELECT customer_id, first_name, last_name
  FROM customer
  WHERE customer_id = (SELECT MAX(customer_id) FROM customer);

-- Noncorrelated SubqueriesSELECT	city_id, cityFROM	city		where country_id <>		(SELECT country_id FROM country WHERE country = 'India');select city_id, city from cityinner join country on city.country_id = country. country_idwhere country.country <> 'India'--Multiple-Row, Single-Column Subqueries--THE IN AND NOT IN OPERATORSSELECT	city_id, cityFROM	cityWHERE	country_id IN		(SELECT country_id FROM country 		WHERE country IN ('Canada', 'Mexico'));SELECT	city_id, cityFROM	cityWHERE	country_id NOT IN		(SELECT country_id FROM country 		WHERE country IN ('Canada', 'Mexico'));--THE ALL OPERATORSELECT	first_name, last_name	FROM	customerWHERE	customer_id NOT IN		(SELECT customer_id FROM payment WHERE amount = 0);SELECT	customer_id, count(*)		FROM rental		GROUP BY customer_id		HAVING count(*) > ALL(SELECT	count(*)FROM	rental		INNER JOIN customer		ON rental.customer_id = customer.customer_id		INNER JOIN address		ON customer.address_id = address.address_id		INNER JOIN city		ON address.city_id = city.city_id		INNER JOIN country 		ON city.country_id = country.country_idWHERE	country.country IN ('United States','Mexico','Canada')		GROUP BY rental.customer_id);--THE ANY OPERATORSELECT	customer_id AS customerId, SUM(amount) as totalSumFROM	payment		GROUP BY customer_id		HAVING SUM(amount) > ANY(SELECT SUM(payment.amount)FROM	payment		INNER JOIN  customer		ON payment.customer_id = customer.customer_id		INNER JOIN address		ON customer.address_id = address.address_id		INNER JOIN city		ON address.city_id = city.city_id		INNER JOIN country		ON city.country_id = country.country_id		WHERE country.country IN ('Bolivia','Paraguay','Chile')		GROUP BY country.country);--MULTICOLUMN SUBQUERIESSELECT fa.actor_id,
       fa.film_id
FROM   film_actor AS fa
WHERE  fa.actor_id IN (SELECT actor_id
                       FROM   actor
                       WHERE  last_name = 'MONROE')
       AND fa.film_id IN (SELECT film_id
                          FROM   film
                          WHERE  rating = 'PG');

--CORRELATED SUBQUERIESSELECT	c.first_name,		c.last_nameFROM	customer as cWHERE	20 = (SELECT count(*) FROM rental r
			 WHERE r.customer_id = c.customer_id)

SELECT	c.first_name, c.last_name
FROM	customer AS c
WHERE   (SELECT SUM(p.amount) 
		FROM payment p
		WHERE p.customer_id = c.customer_id)
		BETWEEN 180 AND 240;

--THE EXISTS OPERATORSELECT	c.first_name, c.last_nameFROM	customer cWHERE	EXISTS(SELECT 1			   FROM rental r			   WHERE r.customer_id = c.customer_id			   AND r.rental_date < '20050525');SELECT	a.first_name, a.last_nameFROM	actor AS aWHERE	NOT EXISTS		(			SELECT 1			FROM film_actor AS fa			INNER JOIN film f 			ON f.film_id = fa.film_id			WHERE fa.actor_id = a.actor_id			AND f.rating = 'R'		);--DATA MANIPULATION USING CORRELATED SUBQUERIESUPDATE	customer SET		customer.last_update = 		(			SELECT MAX(r.rental_date)			FROM rental r			WHERE r.customer_id = customer.customer_id		)		WHERE EXISTS		(			SELECT 1 FROM rental r			WHERE r.customer_id = customer.customer_id		);DELETE FROM customer
WHERE  365 < (SELECT Datediff(dd, Getdate(), r.rental_date)
              FROM   rental r
                     INNER JOIN customer
                             ON r.customer_id = customer.customer_id); --SUBQUERIES AS DATA SOURCESSELECT customer.first_name,
       customer.last_name,
       pymnt.num_rentals,
       pymnt.tot_payments
FROM   customer
       INNER JOIN (SELECT customer_id,
                          Count(*)    num_rentals,
                          Sum(amount) tot_payments
                   FROM   payment
                   GROUP  BY customer_id) pymnt
               ON customer.customer_id = pymnt.customer_id; --DATA FABRICATIONSELECT 'Small Fry' NAME,
       0           low_limit,
       74.99       high_limit
UNION ALL
SELECT 'Average Joes' NAME,
       75             low_limit,
       149.99         high_limit
UNION ALL
SELECT 'Heavy Hitters' NAME,
       150             low_limit,
       9999999.99      high_limit; --SELECT	pymnt_grps.name		, count(*) AS num_customersFROM	(SELECT customer_id				, count(*) AS num_rentals				, SUM(amount) tot_payments				FROM payment 				GROUP BY customer_id		) pymnt		INNER JOIN		(SELECT 'Small Fry' NAME,
			   0           low_limit,
			   74.99       high_limit
		UNION ALL
		SELECT 'Average Joes' NAME,
			   75             low_limit,
			   149.99         high_limit
		UNION ALL
		SELECT 'Heavy Hitters' NAME,
			   150             low_limit,
			   9999999.99      high_limit 		)pymnt_grps		ON pymnt.tot_payments			BETWEEN pymnt_grps.low_limit 			AND pymnt_grps.high_limit			GROUP BY pymnt_grps.name;--TASK-ORIENTED SUBQUERIESSELECT c.first_name,
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