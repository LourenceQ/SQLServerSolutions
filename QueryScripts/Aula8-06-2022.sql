-- Aula sobre cria��o de integridade referencial

CREATE TABLE table_qualquer
  (
     id              INT IDENTITY PRIMARY KEY NOT NULL,
     descricao       VARCHAR(30),
     departamento_id INT FOREIGN KEY REFERENCES departamento(id)
	 ON UPDATE cascade 
	 ON DELETE set null
  )  

  -- criar usu�rio 
  create user 'lourence'@'localhost' identified with sqlser_