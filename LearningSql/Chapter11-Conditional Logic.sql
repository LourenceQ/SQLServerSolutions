--Chapter 11. Conditional Logic
use sakila
select	first_name, last_name, 
case
	when active = 1 then 'active'
	else 'inactive'
end 
from customer
--THE CASE EXPRESSION
case 
	when exists(
		select 1 from film_actor as fa
		inner join film as f 
		on fa.film_id = a.actor_id
		and f.rating = 'G') then 'Y'
	else 'N'
end as g_actor,
case 
	when exists(
		select 1 from film_actor as fa
		inner join film as f 
		on fa.film_id = f.film_id
		where fa.actor_id = a.actor_id
		and f.rating = 'PG') then 'Y'
	else 'N'
end as pg_actor,
case 
	when exists(
		select 1 from film_actor as fa
		inner join film as f
		on fa.film_id = f.film_id
		where fa.actor_id = a.actor_id
		and f.rating = 'NC-17') then 'Y'
	else 'N'
end as nc17_actor
from actor as a
where a.last_name LIKE 'S%' or a.first_name like 'S%';
--
SELECT f.title,
  CASE (SELECT count(*) FROM inventory i
  WHERE i.film_id = f.film_id)
  WHEN 0 THEN 'Out Of Stock'
  WHEN 1 THEN 'Scarce'
  WHEN 2 THEN 'Scarce'
  WHEN 3 THEN 'Available'
  WHEN 4 THEN 'Available'
  ELSE 'Common'
  END film_availability
  FROM film f

 --DIVISION-BY-ZERO ERRORS