-- Aula sobre criação de integridade referencial

CREATE TABLE table_qualquer
  (
     id              INT IDENTITY PRIMARY KEY NOT NULL,
     descricao       VARCHAR(30),
     departamento_id INT FOREIGN KEY REFERENCES departamento(id)
	 ON UPDATE cascade 
	 ON DELETE set null
  )  

  -- criar usuário 
  create user 'lourence'@'localhost' identified with sqlser_