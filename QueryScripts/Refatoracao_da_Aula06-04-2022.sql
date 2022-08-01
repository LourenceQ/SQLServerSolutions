SELECT * FROM INFORMATION_SCHEMA.TABLES;

DROP DATABASE Locadora2; 
Create Database Locadora2;
use Locadora2;

DROP TABLE IF EXISTS album
	, artista
	, cds
	, cidade
	, estado
	, local_compra
	, musicas
	, rel_local_compra_cds
	, rel_musicas_artista;

CREATE TABLE album (
  id int identity (1,1) primary key,
  name varchar(30) DEFAULT NULL) 

SET IDENTITY_INSERT album OFF
INSERT INTO album VALUES ('Album 2022');
SET IDENTITY_INSERT album OFF

DROP TABLE IF EXISTS artista;

CREATE TABLE artista (
  id int identity (1,1) primary key,
  name varchar(30) DEFAULT NULL
);

DROP TABLE IF EXISTS cds;

CREATE TABLE cds (
  id int identity (1,1) primary key,
  codigo varchar(10) DEFAULT NULL,
  nome varchar(50) DEFAULT NULL,
  valor_pago decimal(6,2) DEFAULT NULL,
  album_id INT FOREIGN KEY REFERENCES album(id)); 
  
INSERT INTO cds VALUES ('123456','Thiller',12.50,1);
SET IDENTITY_INSERT cds OFF

DROP TABLE IF EXISTS estado;

CREATE TABLE estado (
  id int identity (1,1) primary key,
  name varchar(30) DEFAULT NULL,
  sigla varchar(2) DEFAULT NULL);

INSERT INTO estado VALUES ('Minas Gerais','MG'),('São Paulo','SP');

DROP TABLE IF EXISTS cidade;

CREATE TABLE cidade (
  id int identity (1,1) primary key,
  name varchar(30) DEFAULT NULL,
  fk_estado int foreign key references estado(id));

INSERT INTO cidade VALUES ('Teófilo Otoni',1),('Ipatinga',1);

DROP TABLE IF EXISTS local_compra;

CREATE TABLE local_compra (
  id int identity (1,1) primary key,
  rua varchar(30) DEFAULT NULL,
  bairro varchar(20) DEFAULT NULL,
  fk_cidade int foreign key references cidade(id));

INSERT INTO local_compra VALUES ('Rua teste','Bairro teste',1),('Segunda Loja','Bairro de lá',2);

DROP TABLE IF EXISTS musicas;

CREATE TABLE musicas (
  id int identity (1,1) primary key,
  numero int DEFAULT NULL,
  nome varchar DEFAULT NULL,
  fk_cd int foreign key references cds (id),
  tempo time DEFAULT NULL)

CREATE TABLE rel_local_compra_cds (
	fk_cds int NOT NULL,
	fk_local_compra int NOT NULL,
	PRIMARY KEY(fk_cds, fk_local_compra), 
	CONSTRAINT rel_local_compra_cds_ibfk_1 FOREIGN KEY (fk_cds) REFERENCES cds (id),
	CONSTRAINT rel_local_compra_cds_ibfk_2 FOREIGN KEY (fk_local_compra) REFERENCES local_compra (id),
	data_compra date
); 


CREATE TABLE rel_musicas_artista (
	fk_musicas int NOT NULL,
	fk_artista int NOT NULL,
	PRIMARY KEY (fk_musicas,fk_artista),
	CONSTRAINT rel_musicas_artista_ibfk_1 FOREIGN KEY (fk_musicas) REFERENCES musicas (id),
	CONSTRAINT rel_musicas_artista_ibfk_2 FOREIGN KEY (fk_artista) REFERENCES artista (id)
);

--------------------------------------------------------------------------------------------------

