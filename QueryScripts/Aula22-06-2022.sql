--VIEWS

create view v1 as select *from cidade where estado_id = 1;

show create view v1;

select * from v1;

drop view v1;

create view v2 as select funcionario.primeiro_nome, departamento.nome
from funcionario inner join 
departamento on departamento_id = de=partamento_id

select * from v2

alter view v2 as select funcinario.id, funcionario ... 


--STORED PROCEDURE
create procedure get p1()
begin 
select * from table;
end
//

--VARIÁVEIS 
declare nome_variavel data_type default


