Create DataBase projeto_db2;

use projeto_db2;

create table student_address(
		student_address_id INT IDENTITY PRIMARY KEY
		, street VARCHAR(30)
		, number VARCHAR(5)
		, district VARCHAR(30)
		, complement VARCHAR(15)
		, cep VARCHAR(9)
		, student_id INT FOREIGN KEY REFERENCES student(student_id))

create table states(
		state_id INT IDENTITY PRIMARY KEY
		, city_id INT FOREIGN KEY REFERENCES cities(city_id))

create table cities(
		city_id INT IDENTITY PRIMARY KEY
		, city_name VARCHAR(30)
		, sigla VARCHAR(5)
		, state_id INT FOREIGN KEY REFERENCES states(state_id))

create table student(
		student_id int identity primary key
		, first_name varchar(40)
		, birthday date
		, email varchar(40)
		, cpf varchar(40)
		, registration varchar(40))

/*
SET IDENTITY_INSERT Emp ON
INSERT INTO Emp (EmpNo 
				, Ename 
				, Job 
				, Mgr 
				, HireDate 
				, Sal 
				, Comm 
				,DptNo)
VALUES (7369, 'SMITH', 'CLERK', 7902 , null,800, null, 20),
(7499, 'ALLEN', 'SALESMAN', 7698,  null, 1600, 300, 30),
 (7521, 'WARD', 'SALESMAN', 7698,  null, 1250, 500, 30),
 (7566, 'JONES', 'MANAGER', 7839,  null, 2975, null, 20),
 (7654, 'MARTIN', 'SALESMAN', 7698,  null, 1250, 1400, 30),
 (7698, 'BLAKE', 'MANAGER', 7839,  null, 2850, null, 30),
 (7782, 'CLARK', 'MANAGER', 7839,  null, 2450, null, 10),
 (7788, 'SCOTT', 'ANALYST', 7566,  null, 3000,  null,20),
 (7839, 'KING', 'PRESIDENT',  null,  null, 5000, null, 10),
 (7844, 'TURNER', 'SALESMAN', 7698, null, 1500, 0, 30),
 (7876, 'ADAMS', 'CLERK', 7788,  null, 1100, null, 20),
 (7900, 'JAMES', 'CLERK', 7698,  null, 950,  null,30),
 (7902, 'FORD', 'ANALYST', 7566,  null, 3000, null, 20),
 (7934, 'MILLER', 'CLERK', 7782,  null, 1300, null, 10);
 SET IDENTITY_INSERT Dept OFF;
 */

 /*
 Criação das tabelas de cidade, estado, estudent_address
 CARDINALIDADE - 1 para 1 (escolhe a chave estrangeira)
				 1 pra muitos - vai pra muitos
				 muitos pra 1 - vai pra muitos
				 muitos pra muitos - tem que criar outra tabela com chave composta
 */

 /*
 later tavle add fereign key(state_id
 refences states (id) */