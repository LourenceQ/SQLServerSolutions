select * from INFORMATION_SCHEMA.tables;

/*
Join permite que os dados de v�rias tabels sejam combinados com base 
na rela��o existente entre elas.

Por meio dea cl�usula, os dads de uma tabela s�o usadas para selecionar os dados pertencentes � outra tabela

com a cl�usula JOIN, podemos especificar quais colunas das tabelas ser�o associadas.

Para isso, ser� preciso definir uma chave entrageira de uma tabela e a chave relacionada em outra tabela.

Os valores pertencentes �s colunas da taelas associadas podem ser compradas entre si
por meio de um operador l�gico.

tipo_de_associa��o: Permite identitifacr uma das seguintes associa�es: outer join, inner join, cross join;

condi��o_de_associa��o: Define um crit�rio ara avaliar duas linhas de dados que ja est�o associadas.

INNER JOIN
a cl�usula inner join permite usar operadores de compara��o para comparar os valores de colunas provenientes de tabelas associadas.

LEFT JOIN
traz totods os resultados da tabela mais � esquerda

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



