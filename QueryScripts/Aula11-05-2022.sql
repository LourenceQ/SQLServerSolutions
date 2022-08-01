create database empresa
use empresa;

create table departamento(id int identity primary key not null,
	nome varchar(30),
	localizacao varchar(10));

create table funcao (id int identity primary key not null,
	descricao varchar(30));


create table cidade (id int identity primary key not null,
	nome varchar(30),
	estado_id int foreign Key references estado(id));

create table estado (id int identity primary key not null,
	sigla varchar(2));

create table funcionario( id int identity primary key not null,
	primeiro_nome varchar(15),
	segundo_nome varchar(15),
	ultimo_nome varchar(15),
	data_nascimento date,
	cpf varchar(11),
	rg varchar(10),
	rua varchar(30),
	numero varchar(5),
	complemento varchar(30),
	bairro varchar(30),
	cep varchar(9),
	cidade_id int foreign key references cidade(id),
	fone varchar(15),
	departamento_id int foreign key references departamento(id),
	funcao_id int foreign key references funcao(id),
	salario decimal(7,2));



select * from INFORMATION_SCHEMA.tables

insert into funcionario(primeiro_nome,  segundo_nome, ultimo_nome, data_nascimento,
	cpf, rg,numero, complemento, bairro, cep,
	salario) values ('Lourence', 'Queiróz', 'Fófano', 24/05/1989, 
	'09790089643', '15795419', '50', 'casa', 
	'horto florestal', '36773536', '5000');

--TRABALHO
--1 
select primeiro_nome,segundo_nome, ultimo_nome from funcionario order by ultimo_nome;
select concat(primeiro_nome,segundo_nome, ultimo_nome) as nome_completo from funcionario order by ultimo_nome;

--2
select * from funcionario inner join cidade on cidade.id = funcionario.cidade_id order by cidade.nome

--3
select concat(primeiro_nome, segundo_nome, ultimo_nome) as nome_completo 
	from funcionario
	where funcionario.salario > 1000 order by nome_completo

--4
select data_nascimento, primeiro_nome from funcionario order by data_nascimento desc;

--5
select sum(salario) as fola_de_pagamento from funcionario

--6
select funcionario.primeiro_nome, departamento.nome as departamento, funcao.descricao as funcao 
	from departamento
	inner join funcionario on funcionario.departamento_id = departamento.id
	inner join funcao on funcionario.funcao_id = funcao.id

--7
select departamento.nome
	   , funcionario.primeiro_nome as gerente 
from departamento 
	left join funcionario
		on funcionario.departamento_id = departamento.id
	right join funcao 
		on funcionario.funcao_id = funcao.id
		where (select funcao.descricao from funcao) like 'gerente%'
		
--8
select sum(salario), departamento.nome from funcionario
	inner join departamento 
		on funcionario.departamento_id = departamento.id
	group by departamento.nome

--9
select departamento.nome, funcionario.primeiro_nome from funcionario 
	inner join departamento 
		on funcionario.departamento_id = departamento.id
	inner join funcao
		on funcionario.funcao_id = funcao.id
	where funcao.descricao like '%supervisor'

--10
select count(*)as total_funcionario from funcionario

--11
select sum(salario) / count(funcao.id) as total 
from funcionario, funcao 

--12
select min(salario), departamento.nome from funcionario
	inner join departamento
		on funcionario.departamento_id = departamento.id

group by departamento.departamento.id


