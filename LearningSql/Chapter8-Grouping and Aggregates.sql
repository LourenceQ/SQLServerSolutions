--Chapter 8. Grouping and Aggregates
use sakila

select	customer_id
		, count(*) as number_of_rents 
	from rental 
		group by customer_id
		order by number_of_rents desc

select	customer_id
		, count(*) as number_of_rents 
	from rental 
		group by customer_id
		having count(*) >= 40

SELECT customer_id,
 MAX(amount) max_amt,
 MIN(amount) min_amt,
 AVG(amount) avg_amt,
 SUM(amount) tot_amt,
 COUNT(*) num_payments
 FROM payment
 GROUP BY customer_id;Select	Count(customer_id) num_rows		,Count(Distinct customer_id) nums_customers	from paymentSelect max(datediff(d,rental_date,return_date))	from rentalselect	fa.actor_id, f.rating, count(*)	from film_actor fa		inner join film f		on fa.film_id = f.film_id	group by fa.actor_id, f.rating	order by 1,2select	extract(year from rental_date) year,		count(*) how_many	from rental	group by extract(year from rental_date)SELECT fa.actor_id, f.rating, count(*)
 FROM film_actor fa
 INNER JOIN film f
 ON fa.film_id = f.film_id
 GROUP BY fa.actor_id, f.rating WITH cube
 ORDER BY 1,2;SELECT fa.actor_id, f.rating, count(*)
 FROM film_actor fa
 INNER JOIN film f
 ON fa.film_id = f.film_id
 GROUP BY fa.actor_id, f.rating WITH rollup
 ORDER BY 1,2;

select	fa.actor_id, f.rating, count(*)
	from film_actor fa
		inner join film f
		on fa.film_id = f.film_id
	where f.rating in ('G', 'PG')
	group by fa.actor_id, f.rating
	having count(*) > 9