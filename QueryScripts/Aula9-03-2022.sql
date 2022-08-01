/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [id]
      ,[nome]
      ,[nascimento]
      ,[email]
      ,[cpf]
      ,[martricula]
      ,[rua]
      ,[numero]
      ,[bairro]
      ,[complemento]
      ,[cidade]
      ,[estado]
      ,[cep]
  FROM [projeto_db].[dbo].[estudante]

  insert into estudante (nome, nascimento, email) values ('Ecneruol', '1991-06-07', 'ecner@gmail.com')

  alter table estudante add novoCampo varchar(5) not null;
  alter table estudante set cep = cep varchar(8) not null;

  ALTER TABLE estudante 
ALTER COLUMN cep varchar(50) null;

alter table	[dbo].[estudante]
	add		novaColuna varchar(30) null;

select * from estudante

alter table estudante
	drop column novaColuna;

ALTER TABLE estudante
ALTER COLUMN cep varchar(20)

exec sp_columns estudante

exec sp_help estudante
