--12
SELECT AVG(tempo)FROM muicas;

--13
SELECT COUNT(*) AS qtd_musicas FROM cds;

--14
SELECT	musicas.name
		, artista.name
		, musicas.id 
FROM	musicas
		, artista
		, rel_musicas_artista 
WHERE	rel_musicas_artista.fk_musicas = muicas.id
		and rel_musicas_artista.fk_artista = artista.id
		and artista.name = 'alok'

--15
select cds.id cds.nome count(musicas.id) from msucias, cds where musicas.fk = cd.id, group by cds.id

--16 nome de todos cds comprado no submarino
select cds.nome 
from cds, rel_local_compra_cds, local_compra
where rel_local_compra_cds.fk-local_compra = local_compra.id
and rel_local_compra_cds.fk_cds = cds.id
and local_compra.nome = "submarino";

--17nome do cde nome da primeira musica de tiodos cds



