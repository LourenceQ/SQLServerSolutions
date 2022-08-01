create database locadora
use locadora

create table cds(
	id int identity primary key
	, codigo varchar(10)
	, nome varchar(50)
	, data_compra timestamp 
	, valor_pago decimal(6,2)
	, album int);
	


create table cidade(
	id int identity primary key
	, name varchar(30)
	, fk_estado int FOREIGN KEY REFERENCES 

create tabçe estado(
	id int identity primary key,
	name varchar(30),
	sigla varchar(2)),

alter table cidade add 

create table algum (id int identity 


create table rel_local_compra_cds( 
	fk_cds int
	, fk_local_compra int
	, data_compra timestamp
	, primary key(fk_cds, fk_local_compra)
	, foreign key(fk_cds)references cds(id)
	, foreign key(fk_local_compra) references local_compra(id))

alter table cds drop data_compra

create table musicas(
	id int identity primary key
	, numero int
	,  nome varchar(30)
	, tempo time)
	, fk_cd int foreign key references cds(id))

create table artista(
	id int primary
	, name varchar(30))


create table rel_musicas_artitsta(
	fk_musicas int,
	fk_artista int,
	primary key(fk_musicas, fk_artista),
	foreign key(fk_musicas) references musicas(id);
	fore ign key


	