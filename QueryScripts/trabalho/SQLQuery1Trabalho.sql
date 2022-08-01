use aulabd
SELECT * FROM resposta;
exec sp_help alunos;
SELECT * FROM information_schema.TABLES;

create table resposta (
	numquestao INT IDENTITY (2,1) PRIMARY KEY
	, descresposta VARCHAR(500) NOT NULL);

create table professor (
	codigo INT IDENTITY (1,1) PRIMARY KEY
	, nome VARCHAR(20) NOT NULL
	, cpf VARCHAR(20) NOT NULL
	, email VARCHAR(20)
	, titulacao VARCHAR(20)
	, fone VARCHAR(20)
	, sexo VARCHAR(1) NOT NULL);	

INSERT INTO professor (nome, cpf, email, titulacao, fone, sexo)
VALUES ('Luiz', '09878656643', 'luiz@luiz.com', 'Professor', '32999878765', 'M');

INSERT INTO professor (nome, cpf, email, titulacao, fone, sexo)
VALUES ('Helder', '09768596643', 'helder@helder.com', 'Professor', '32987654765', 'M');

INSERT INTO resposta(descresposta) VALUES (
	'Uma chave primária é uma coluna ou uma coleção de colunas
	 cujo valor é um identificador único');

INSERT INTO resposta(descresposta) VALUES (
	'FOREIGN KEY é uma restrição para se certificar que dados em tabelas 
	relacionadas não fiquem irrelacionadas. É constiuída por uma ou mais colunas
	em uma tabela que se relacionam com a chave primária em outra tabela. Valores
	inseridos devem já exitir na chave primária da tabela que a FOREIGN KEY
	está referenciando.');

INSERT INTO resposta(descresposta) VALUES (
	'create table curso(id INT IDENTITY(1,1) PRIMARY KEY NOT NULL
	, descricao VARCHAR(11));');


INSERT INTO resposta(descresposta) VALUES (
	'create table alunos (id INT IDENTITY (1,1) PRIMARY KEY
	, nome VARCHAR(20) NOT NULL
	, matricula INT NOT NULL
	, estado VARCHAR(2)
	, sexo VARCHAR(1)
	, fk_curso INT FOREIGN KEY REFERENCES curso (id));');

INSERT INTO resposta(descresposta) VALUES ('alter table alunos add email VARCHAR(10);');

INSERT INTO resposta(descresposta) VALUES ('alter table professor drop column fone;')

INSERT INTO resposta(descresposta) VALUES ('update professor set sexo = "M" where sexo = "M";');

INSERT INTO resposta(descresposta) VALUES ('delete FROM professor where sexo = F;');

INSERT INTO resposta(descresposta) VALUES ('SELECT nome, matricula FROM alunos;');

INSERT INTO resposta(descresposta) VALUES ('SELECT nome FROM professor where sexo = M;');

INSERT INTO resposta(descresposta) VALUES ('SELECT alunos.nome, curso.descricao as curso FROM alunos, curso where fk_curso = curso.id;');

INSERT INTO resposta(descresposta) VALUES ('
	create table cidade (
	id INT IDENTITY (1,1) PRIMARY KEY
	, nome VARCHAR(20) NOT NULL
	, fk_estado INT FOREIGN KEY REFERENCES estado(id));

	create table estado (
	id INT IDENTITY (1,1) PRIMARY KEY
	, nome VARCHAR(2) NOT NULL);');

INSERT INTO resposta(descresposta) VALUES ('SELECT nome FROM cidade where nome like a%;');

INSERT INTO resposta(descresposta) VALUES ('SELECT cidade.nome, estado.nome FROM cidade, estado where estado.id = 1 and cidade.fk_estado = estado.id;');

INSERT INTO resposta(descresposta) VALUES ('SELECT cidade.nome, estado.nome FROM cidade, estado where cidade.fk_estado = estado.id;');

INSERT INTO resposta(descresposta) VALUES ('SELECT LOWER(nome) FROM cidade;');

INSERT INTO resposta(descresposta) VALUES ('SELECT UPPER(nome) FROM cidades;');

INSERT INTO resposta(descresposta) VALUES ('SELECT UPPER(nome) FROM cidade;');

INSERT INTO resposta(descresposta) VALUES ('SELECT count(*) as total_cidades FROM cidade;');