select * from INFORMATION_SCHEMA.tables;

/*
Join permite que os dados de várias tabels sejam combinados com base 
na relação existente entre elas.

Por meio dea cláusula, os dads de uma tabela são usadas para selecionar os dados pertencentes à outra tabela

com a cláusula JOIN, podemos especificar quais colunas das tabelas serão associadas.

Para isso, será preciso definir uma chave entrageira de uma tabela e a chave relacionada em outra tabela.

Os valores pertencentes às colunas da taelas associadas podem ser compradas entre si
por meio de um operador lógico.

tipo_de_associação: Permite identitifacr uma das seguintes associaões: outer join, inner join, cross join;

condição_de_associação: Define um critério ara avaliar duas linhas de dados que ja estão associadas.

INNER JOIN
a cláusula inner join permite usar operadores de comparação para comparar os valores de colunas provenientes de tabelas associadas.

LEFT JOIN
traz totods os resultados da tabela mais à esquerda

RIGHT JOIN

*/

select * from estado
select * from cidade
select cidade.name, sigla from cidade, estado where cidade.fk_estado = estado.id

insert into estado values('Rio de Janeiro', 'RJ')
insert into cidade values('Vassouras', 3)


select cidade.name, sigla from cidade inner join estado on cidade.fk_estado = estado.id

select artista.name, musicas.nome, musicas.id from musicas, artista, rel_musicas_artista where
rel_musicas_artista.fk_musicas = musicas.id and 
rel_artista.fk_artista = artista.id and artista.name = 'alok';

------------------------

select 
	artista.name,
	musicas.nome,
	musicas.id
from 
	musicas		
	inner join rel_musicas_artista on rel_musicas_artista.fk_artista = musicas.id
	inner join artista on rel_musicas_artista.fk_musicas= artista.id	
where
	artista.name = 'Alok';

------------------------

select 
	artista.name,
	musicas.nome,
	musicas.id
from 
	artista		
	inner join rel_musicas_artista on rel_musicas_artista.fk_artista = artista.id
	inner join musicas on rel_musicas_artista.fk_musicas= musicas.id	
where
	artista.name = 'Alok';

------------------------

select 
	estado.sigla,
	count(cidade.id)
from
	estado
	Inner join cidade on cidade.fk_estado = estado.id
group by
	estado.sigla

------------------------

select 
	estado.sigla,
	count(cidade.id)
from
	estado
	Inner join cidade on cidade.fk_estado = estado.id
group by
	estado.sigla
having 
	count(cidade.id) > 1
	TOP 1

------------------------

select 
	estado.name,
	estado.sigla
from
	estado
	Inner join cidade on cidade.fk_estado = estado.id



----------------------

select 
	estado.name,
	estado.sigla
from
	estado
	left join cidade on cidade.fk_estado = estado.id
group by 
	estado.sigla



