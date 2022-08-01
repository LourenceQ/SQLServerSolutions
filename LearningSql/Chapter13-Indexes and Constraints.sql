--INDEXES AND CONSTRAINTS

--CONSTRAINTS
ALTER TABLE customer
ADD CONSTRAINT fk_customer_address FOREIGN KEY (address_id)
REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE customer
ADD CONSTRAINT fk_customer_store FOREIGN KEY (store_id)
REFERENCES store (store_id) ON DELETE RESTRICT ON UPDATE CASCADE;

select * from customer where address_id = 123
select * from address where address_id = 123

select c.first_name, c.last_name, c.address_id, a.address
from customer as c
inner join address as a
on c.address_id = a.address_id
where a.address_id = 123;

delete from address where address_id = 123;

