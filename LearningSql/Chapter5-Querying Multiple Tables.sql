/*
Chapter 5. Querying Multiple Tables
*/

select * from INFORMATION_SCHEMA.tables 

select * from category

select first_name, last_name from customer where last_name = 'ZIEGLER';
select * from customer

select * from language

SELECT distinct actor_id FROM film_actor ORDER BY actor_id;

create view cust_vw 
as select customer_id, first_name, last_name, active
from customer

select * from cust_vw

select first_name, last_name from cust_vw where active = 0

exec sp_help customer


SELECT c.first_name,
       c.last_name,
	   a.address
FROM   customer c
       INNER JOIN address a 
               ON c.address_id = a.address_id

 select * from address

 select * from customer


select c.first_name
	, c.last_name
	, a.address
	from customer c, address a
	where c.address_id = a.address_id

select c.first_name
	, c.last_name
	, a.address
	from customer c, address a
	where c.address_id = a.address_id
	and a.postal_code = 52137;

select c.first_name
	, c.last_name
	, a.address
	from customer c inner join address a
	on c.address_id = a.address_id
	where a.postal_code = 52137

-- Joining Three or More Tables
SELECT	customer.first_name
		, customer.last_name
		, city.city
FROM	customer 
		INNER JOIN address 
			ON customer.address_id = address.address_id
		INNER JOIN city
			ON address.city_id = city.city_id;

-- all three of these variantes return the same result

SELECT	customer.first_name
		, customer.last_name
		, city.city
	FROM city
		INNER JOIN address
			ON address.city_id = city.city_id
		INNER JOIN customer 
			ON customer.address_id = address.address_id;

SELECT	customer.first_name
		, customer.last_name
		, city.city
	FROM address 
		INNER JOIN city 
			ON address.city_id = city.city_id
		INNER JOIN customer 
			ON customer.address_id = address.address_id;

-- Using Subqueries As Tables
SELECT	customer.first_name
		, customer.last_name
		, addr.address
		,addr.city
	FROM customer 
		INNER JOIN (
			SELECT	address.address_id
					, address.address
					, city.city
				FROM address
					INNER JOIN city
						ON address.city_id = city.city_id
					WHERE address.district = 'California'
					) addr
			ON customer.address_id = addr.address_id;

-- without subquery
SELECT	address.address_id
		, address.address
		, city.city
	FROM address
		INNER JOIN city 
			ON address.city_id = city.city_id
		WHERE address.district = 'california'

-- Using the Same Table TwiceSELECT	film.title	FROM film		INNER JOIN film_actor			ON film.film_id = film_actor.film_id		INNER JOIN actor 			ON film_actor.actor_id = actor.actor_id		WHERE((actor.first_name = 'CATE' AND actor.last_name = 'MCQUEEN')			OR (actor.first_name = 'CUBA' AND actor.last_name = 'BIRCH'));
-- returns all movies in which either Cate McQueen and Cuba Birch both appeared.SELECT	film.title
	FROM film 
		INNER JOIN film_actor 
			ON film.film_id = film_actor.film_id

		INNER JOIN actor
			ON film_actor.actor_id = actor.actor_id

		INNER JOIN film_actor AS film_actor2
			ON film.film_id = film_actor2.film_id

		INNER JOIN actor AS actor2
			ON film_actor2.actor_id = actor2.actor_id

	WHERE (actor.first_name = 'CATE' AND actor.last_name = 'MCQUEEN')
		AND (actor2.first_name = 'CUBA' AND actor2.last_name = 'BIRCH');-- Self-Joins