--1) O diagrama abaixo representa a base de dados de uma Auto Escola de condutores. Para as questões desta avaliação, o diagrama abaixo deverá ser considerado.
create database prova04072022
use prova04072022
CREATE TABLE curso(id int identity primary key
					, nome varchar(30));

insert into curso(nome) values ('curso1'), ('curso2'),('curso3')
select * from curso

CREATE TABLE estado(id int identity primary key
					, nome varchar(30));
insert into estado(nome) values ('mg'), ('sp'),('rj')
select * from estado

CREATE TABLE cidade(id int identity primary key
					, nome varchar(30)
					, fk_estado int foreign key references estado(id) ON DELETE CASCADE);
insert into cidade(nome, fk_estado) values ('Cataguases', 1), ('Santos', 2),('macaé', 3)
select * from cidade

CREATE TABLE aluno(id int identity primary key
					, rg varchar(14)
					, cpf varchar(15) 
					, nome varchar(30)
					, sexo varchar(1)
					, fk_cidade int foreign key references cidade(id) ON DELETE CASCADE);
insert into aluno(rg, cpf, nome, sexo, fk_cidade) 
	values ('rg1','cpf1','aluno1', 'm', 1)
			, ('rg2','cpf2','aluno2', 'f', 2)
			, ('rg3','cpf3','aluno3', 'm', 3)
select * from aluno


CREATE TABLE isntrutor(id int identity primary key
					, cpf varchar(15) 
					, nome varchar(30)
					, sexo varchar(1)
					, tipo_instrutor varchar(1)
					, salario decimal(6,2));
insert into isntrutor(cpf, nome, sexo, tipo_instrutor, salario)
	values ('cpf1', 'isntrutor1', 'm', 'a',2000 )
		, ('cpf2', 'isntrutor2', 'f', 'b',2000 )
		, ('cpf3', 'isntrutor3', 'm', 'c',2000 )
select * from isntrutor

CREATE TABLE aluno_has_curso(fk_curso int foreign key references curso(id)
					, fk_aluno int foreign key references aluno(id) ON DELETE CASCADE);
insert into aluno_has_curso(fk_curso, fk_aluno) 
	values (1, 1), (2, 2), (3, 3)
select * from aluno_has_curso

CREATE TABLE instrutor_has_curso(fk_curso int foreign key references curso(id)
					, fk_instrutor int foreign key references isntrutor(id) ON DELETE CASCADE);
insert into instrutor_has_curso(fk_curso, fk_instrutor) 
	values (1,1), (2,2), (3,3)
select * from instrutor_has_curso

CREATE TABLE tipo_veiculo(id int identity primary key
						, nome varchar(30));
insert into tipo_veiculo(nome) 
	values ('veiculo1'), ('veiculo2'), ('veiculo3')
select * from tipo_veiculo

CREATE TABLE aulas(id int identity primary key
					, fk_aluno int foreign key references aluno(id)
					, fk_instrutor int foreign key references isntrutor(id) ON DELETE CASCADE
					, fk_veiculo int foreign key references tipo_veiculo(id) ON DELETE CASCADE
					, fk_curso int foreign key references curso(id)); 
insert into aulas(fk_aluno, fk_instrutor, fk_veiculo, fk_curso) 
	values (1,1,1,1), (2,2,2,2), (3,3,3,3)
select * from aulas



CREATE TABLE marca_veiculo(id int identity primary key
					, nome varchar(30));
insert into marca_veiculo(nome) 
	values ('marca1'), ('marca2'), ('marca3')
select * from marca_veiculo

CREATE TABLE veiculo(id int identity primary key
					, placa varchar(9)
					, descricao varchar(20)
					, ano_fabricacao date
					, fk_tipo int foreign key references tipo_veiculo(id) ON DELETE CASCADE
					, fk_marca int foreign key references marca_veiculo(id) ON DELETE CASCADE);
insert into veiculo(placa, descricao, ano_fabricacao, fk_tipo, fk_marca) 
	values ('placa1', 'desc1', '02-01-1989', 1, 1)
			, ('placa2', 'desc2', '02-01-1988', 2, 2)
			, ('placa3', 'desc3', '02-01-1987', 3, 3)
select * from veiculo

CREATE TABLE comissao_instrutor(id int identity primary key
								, fk_instrutor int foreign key references isntrutor(id) 
								,fk_aula int foreign key references aulas(id) 
								, valor decimal(7,2));
insert into comissao_instrutor(fk_instrutor, fk_aula, valor) 
	values (1, 1, 200), (2, 2, 300),(3, 3, 300);
select * from comissao_instrutor

select * from INFORMATION_SCHEMA.tables

drop table comissao_instrutor
drop table veiculo
drop table marca_veiculo
drop table aulas
drop table tipo_veiculo
drop table instrutor_has_curso
drop table aluno_has_curso
drop table isntrutor
drop table aluno
drop table cidade
drop table estado
drop table curso





--2) Crie uma view que liste: o nome do aluno, cidade, estado e os cursos da qual ele faz parte
CREATE VIEW aluno_info AS
SELECT	aluno.nome AS aluno_nome
		, cidade.nome AS cidade
		, estado.nome AS estado
		, curso.nome AS curso
	FROM aluno
		INNER JOIN cidade
		ON cidade.id = aluno.fk_cidade
		INNER JOIN estado 
		ON cidade.fk_estado = estado.id
		INNER JOIN aluno_has_curso
		ON aluno.id = aluno_has_curso.fk_aluno
		INNER JOIN curso
		ON aluno_has_curso.fk_curso = curso.id

SELECT * FROM aluno_info;


--3) Crie uma view que liste o nome do instrutor e quantidade de aulas que cada instrutor realizou.
CREATE VIEW instrutor_info AS
SELECT	isntrutor.nome AS instrutor_nome
		, count(aulas.id) as total_aulas
	FROM isntrutor
		INNER JOIN aulas
		ON isntrutor.id = aulas.fk_instrutor
		group by isntrutor.nome
select * from instrutor_info

SELECT * FROM aluno_info;

select * from isntrutor

select * from aulas



