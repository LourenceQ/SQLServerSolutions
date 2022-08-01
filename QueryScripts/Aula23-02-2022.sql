/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [id]
      ,[nome]
      ,[nascimento]
      ,[email]
      ,[cpf]
      ,[matricula]
      ,[rua]
      ,[numero]
      ,[bairro]
      ,[casa]
      ,[cidade]
      ,[estatdo]
      ,[cep]
  FROM [projeto_db].[dbo].[estudante]


  aler table stutendes change rua stret carchar 25 not null

  alter table estudante change rua street varchar(25) not null

  
create table estudante(
id int identity primary key, 
nome varchar(40),
nascimento date,
email varchar(40),
cpf varchar(40),
martricula varchar(40),
rua varchar(40),
numero varchar(40),
bairro varchar(40),
complemento varchar(40),
cidade varchar(40),
estado varchar(40),
cep varchar(40))


alter table estudantes 

select * from estudante

alter table estudante add teste int(1) after cpf

alter table estudante drop cep

desc table

sp_help estudante

insert into estudante(
nome,
nascimento ,
email ,
cpf ,
martricula ,
rua ,
numero ,
bairro ,
complemento ,
cidade ,
estado ,
cep )
values('Aluno 1',
'1990-05-06',
'aluno1@gmail.com',
'1234567891011',
'2022141',
'rua de teste',
'20',
'bairro teste',
'casa',
'cataguases',
'MG',
'36773536')

select * from estudante

drop table estudante
