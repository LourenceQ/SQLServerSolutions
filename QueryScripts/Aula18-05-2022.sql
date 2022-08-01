--7 errada
select departamento.nome
	   , funcionario.primeiro_nome 
from funcionario
	inner join funcao 
		on funcionario.funcao_id = funcao.id 
	inner join departamento
		on funcionario.departamento_id = departamento.id

--7 segunda solução
select departamento.nome
	   , funcionario.primeiro_nome as gerente 
from funcionario 
	inner join funcao
		on funcionario.funcao_id = funcao_id and funcao.descricao = 'gerente'
	right join departamento 
		on funcionario.departamento_id = departamento.id
		--where funcao.descricao = 'gerente%'
--7 terceira solucao com case
select departamento.nome
	case 
		when funcionario.primeiro_nome isnull then "sem gerente"
		else funcionario.primeiro_nome
		end
from funcionario 
	inner join funcao
		on funcionario.funcao_id = funcao_id and funcao.descricao = 'gerente'
	right join departamento 
		on funcionario.departamento_id = departamento.id

--9
select departamento.nome, funcionario.primeiro_nome from funcionario 
	inner join departamento 
		on funcionario.departamento_id = departamento.id
	inner join funcao
		on funcionario.funcao_id = funcao.id
	where funcao.descricao like '%supervisor'

--igual a 7
select departamento.nome
	   , funcionario.primeiro_nome as gerente 
from funcionario 
	inner join funcao
		on funcionario.funcao_id = funcao_id and funcao.descricao = 'gerente'
	right join departamento 
		on funcionario.departamento_id = departamento.id

--13 
select concat(primeiro_nome, '', segundo_nome, '', ultimo_nome) as nome completo 
from funcionario

where seungo_nome isnull or LENGTH(segundo_nome) == 0;

--14
select departamento.nome, funcionario.nome 
from departamento, 
	left join  funcionario
	on funcioanrio.departamento_id = departamento.id
		order by departamento, funcionario

--15
select funcionario.nome from funcionario
	inner join funcao 
		on funcao.id = funcionario.funcao_id 
	inner join cidade
		on funcionario.cidade_id =  estado.id 
	inner join estado 
		on estado.id = cidade.estado_id
		where estado.uf = 'BA'
		and funcao.descricao='telefonista'


--16
select funcionario.primeiro_nome from funcionario
inner join departamento
	on departamento.id = funcionario.departamento_id 
	where departamento.nome = 'rh'

--17
select funcionario.primeiro_nome, departamento.nome from funcionario
	inner join departamento on funcionario.departamento_id = departamento.id
	where funcionario.salario >(
		select funcionario.salario 
			from funcionario
			inner join funcao 
			on funcionario.funcao_id = funcao.id 
		where funcao.descricao='gerente')

--CONCEITO DE SUBQUERIES

-- funcionario que ganahm mais que a media emrpesarial

select funcinario.primeiro_nome, funcionario.slario 
from funcionario where salario > (
select avg(salario) from funcionario)


--union & union all
select primeiro_nome from funcionario where  id = 1
union 
select primeiro_nome from funcionario where id = 2
--obs: a quantidade de colunas devem ser iguais no union

--
select departamento.nome
from departamento
inner join funcionario
	on funcinario.departamento_id = departamento.id
	where departamento.nome notextist