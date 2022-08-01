select * from information_schema.tables

select * from marcas;
select * from veiculo;
select * from modelos;
select * from departamentos;
select * from clientes;
select * from vendas;
select * from comissoes_vendedores;
select * from vendedor;

drop table marcas;
drop table veiculo;
drop table modelos;
drop table departamentos;
drop table clientes;
drop table vendas;
drop table comissoes_vendedores;
drop table vendedor

delete from marcas where nome = 'honda'; 
delete from veiculo; 
delete from modelos where id = 1

update vendas set fk_veiculo = 2 where id between 5 and 8

insert into vendas values(4, 3 , 4, 2, '6-12-2022 00:00:00')
select * from comissoes_vendedores

insert	into comissoes_vendedores (valor_comissao) 
		values (
			select max(vendas.id), veiculo.valor *(0.10) as comissa_10 from veiculo 
				inner join vendas 
					on  veiculo.id = vendas.fk_veiculo
				group by veiculo.valor

				inner join vendedor
					on vendedor.id = vendas.fk_vendedor				
				group by veiculo.valor

		)


		select max(vendas.id), veiculo.valor *(0.10) as comissa_10 from veiculo 
				inner join vendas 
					on  veiculo.id = vendas.fk_veiculo
				group by veiculo.valor




				select max(vendas.id), veiculo.valor *(0.10) as comissa_10 from veiculo 
				inner join vendas 
					on  vendas.fk_veiculo = veiculo.id
				group by veiculo.valor

				select veiculo.valor *(0.10) as comissa_10 from veiculo 
				inner join vendas 
					on  vendas.fk_veiculo = veiculo.id
				group by veiculo.valor
				

				


		select * from veiculo
		select* from vendas
		select * from comissoes_vendedores
		select * from vendedor
		
		select * from INFORMATION_SCHEMA.TABLES

		SELECT IDENT_CURRENT('vendas') 

CREATE TRIGGER trabalho_avaliativo.comissao_10 
	ON comissoes_vendedores
	AFTER INSERT 
	AS 
	BEGIN
		SET NOCOUNT ON;
		INSERT INTO comissoes_vendedores (
			valor_comissao
			, fk_vendedor
			, fk_venda
			, data_comissao
		) 
		SELECT	veiculo.valor*(0.10)
				, vendedor.id
				, vendas.id
				, vendas.data_venda
		FROM veiculo
		INNER JOIN vendas
		ON veiculo.id = vendas.fk_veiculo
		INNER JOIN vendedor
		ON vendas.fk_vendedor = vendedor.id