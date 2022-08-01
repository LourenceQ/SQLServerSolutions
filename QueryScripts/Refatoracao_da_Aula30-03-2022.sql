create table cities(
id int identity primary key, 
name varchar(30) DEFAULT NULL,
sigla varchar(2) DEFAULT NULL,
state_id INT FOREIGN KEY REFERENCES states(id))

SET IDENTITY_INSERT cities ON
INSERT INTO cities (name, sigla, state_id) VALUES
('Teófilo Otoni', 'TO', 1),
('Governador Valadares', 'GV', 1),
('Barueri', 'BU', 2),
('Salvador', 'SA', 3);
SET IDENTITY_INSERT cities OFF
--------------------------------
--------------------------------
SET IDENTITY_INSERT states ON
create table states(
id int identity primary key, 
name varchar(20) DEFAULT NULL,
sigla varchar(2) DEFAULT NULL)

INSERT INTO states (name, sigla) VALUES
('Minas Gerais', 'MG'),
('Sao Paulo', 'SP'),
('Bahia', 'BA');
 SET IDENTITY_INSERT states OFF;
--------------------------------
--------------------------------
create table students(
id int identity primary key, 
name varchar(30) DEFAULT NULL,
birthday date DEFAULT NULL,
email varchar(80) DEFAULT NULL,
cpf varchar(11) DEFAULT NULL,
matricula varchar(10) DEFAULT NULL,
created_at date);

INSERT INTO students (name, birthday, email, cpf, matricula, created_at) VALUES
('Aluno igual', '2005-10-16', 'email@gmail.com', '1234554', '654321', '2022-03-16 22:31:02'),
('Aluno 2', '1988-05-25', 'mais@gmail.com', '123', NULL, '2022-03-16 22:31:02'),
('Aluno 3', '1988-10-01', NULL, '1234', '654321', '2022-03-16 22:31:02'),
('Aluno 4', '2010-08-10', NULL, '12345', NULL, '2022-03-16 22:31:02'),
('Aluno 5', '2000-12-05', 'outroemail@teste.com', '123457', NULL, '2022-03-16 22:31:02'),
('Aluno 6', '2005-10-16', NULL, '1234570', '654321', '2022-03-16 22:31:02'),
('Aluno 7', '2007-03-25', NULL, NULL, NULL, '2022-03-16 22:32:28');
--------------------------------
--------------------------------
create table students_addresses(
id int identity primary key, 
street varchar(30) DEFAULT NULL,
number varchar(5) DEFAULT NULL,
neighborhood varchar(30) DEFAULT NULL,
complement varchar(15) DEFAULT NULL,
cep varchar(9) DEFAULT NULL,
city_id int DEFAULT NULL,
student_id INT FOREIGN KEY REFERENCES students(id));

INSERT INTO students_addresses (street, number, neighborhood, complement, cep, city_id, student_id) VALUES
('Rua teste', '12', 'Bairro nao sei', 'casa', '39800645', 1, 1),
('Israel Pinheiro', '25', 'nenhuma', 'Ap', '3980000', 2, 3),
('13 de março', '55', 'Novo bairro', 'casa', '39000-123', 3, 7),
('Novo endereco', '58', 'Felicidade', 'Casa', '39800058', 1, 1),
('13 de março', '55', 'Novo bairro', 'casa', '39000-123', 3, 7);
--------------------------------
--------------------------------

