--Chapter 11. Conditional Logic
use sakila
select	first_name, last_name, 
case
	when active = 1 then 'active'
	else 'inactive'
end 
from customer
--THE CASE EXPRESSIONselect c.first_name, c.last_name,case 	when active = 0 then 0	else 		(select count(*) from rental as r		Where r.customer_id = c.customer_id)end as num_rentalsfrom customer as c;--CASE EXPRESSION EXAMPLESselect datename(month, rental_date) as rental_month, count(*) as num_rentalsfrom rentalwhere rental_date between '2005-05-01' and '2005-08-01'group by datename(month, rental_date)--selectsum(case when datename(month, rental_date) = 'May' then 1	else 0 end) may_rentals,sum(case when datename(month, rental_date) = 'June' then 1	else 0 end) as june_rentals,sum(case when datename(month, rental_date) = 'July' then 1	else 0 end) as july_rentalsfrom rentalwhere rental_date between '2005-05-01' and '2005-08-01';--CHECKING FOR EXISTENCEselect a.first_name, a. last_name,
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

 --DIVISION-BY-ZERO ERRORSselect	c.first_name		, c.last_name		, sum(p.amount) as num_payments		, sum(p.amount) /		case 			when count(p.amount) = 0 then 1			else count(p.amount)		end as avg_paymentfrom customer as c		left join payment as p		on c.customer_id = p.customer_id	group by c.first_name, c.last_name;--CONDITIONAL UPDATESupdate customer set active = 	case 		when 90 <= (			select datediff(dd, getdate(), max(rental_date))			from rental as r			where r.customer_id = customer.customer_id			)		then 0	else 1end Where active = 1;--HANDLING NULL VALUESselect c.first_name, c.last_name,case 	when a.address is null then 'Unknown'	else a.addressend as address,case 	when ct.city is null then 'Unknown'	else ct.cityend as city,case	when cn.country is null then 'Unknown'	else cn.countryend as countryfrom customer as c	left join address as a	on c.address_id = a.address_id	left join city as ct	on a.city_id = ct.city_id	left join country as cn	on ct.country_id = cn.country_id;