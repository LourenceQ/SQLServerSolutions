CREATE database trabalho_avaliativo
use trabalho_avaliativo

CREATE	TABLE marcas(
		id INT PRIMARY KEY IDENTITY (1,1) NOT NULL
		, nome VARCHAR (30)
	);


INSERT INTO marcas VALUES('volks'), ('honda');


CREATE	TABLE departamentos(
		id INT PRIMARY KEY IDENTITY (1,1) NOT NULL
		, nome VARCHAR(30)
	);

INSERT INTO departamentos VALUES('depVendas'), ('depOtica&Design'), ('depRH')
-------------------------------------------------

CREATE	TABLE vendedor(
		id INT PRIMARY KEY IDENTITY (1,1) NOT NULL
		, nome VARCHAR (30)
		, fk_departamento INT FOREIGN KEY REFERENCES departamentos(id)
		, salario DECIMAL(7,2)
	);

INSERT INTO vendedor 
		VALUES(
			'venderor1', 1, 2000)
			, ('venderor2', 1, 2000)
			, ('venderor3', 2, 2000)
			, ('venderor4', 3, 2000)		
-------------------------------------------------

CREATE	TABLE clientes(
		id INT PRIMARY KEY IDENTITY (1,1) NOT NULL
		, nome VARCHAR(30)
	);

INSERT INTO clientes VALUES('cliente1'), ('cliente2'), ('cliente3'), ('cliente4')
-------------------------------------------------

CREATE	TABLE modelos(
		id INT PRIMARY KEY IDENTITY (1,1) NOT NULL
		, nome VARCHAR(30)
	);

INSERT INTO modelos
		VALUES(
			'modeloDeVolks1')
			, ('modeloDeVolks2')
			, ('modeloDeVolks3')
			, ('modeloDeHonda1')
			, ('modeloDeHonda2')
			, ('modeloDeHonda3');
-------------------------------------------------

CREATE	TABLE veiculo(
		id INT PRIMARY KEY IDENTITY (1,1) NOT NULL
		, nome VARCHAR(30)
		, fk_modelo INT FOREIGN KEY REFERENCES modelos(id) ON DELETE CASCADE
		, fk_marca INT FOREIGN KEY REFERENCES marcas(id) ON DELETE CASCADE 
		, valor DECIMAL(9,2)
		, qtde_estoque int
	);

INSERT	INTO veiculo (
			nome, fk_modelo, fk_marca, valor, qtde_estoque)
		VALUES(
			'carroVolks', 1, 1, 20000, 5)
			, ('carroVolks', 1, 1, 20000, 5)
			, ('carroVolks', 1, 1, 20000, 5)
			, ('carroHonda', 4, 2, 30000, 5)
			, ('carroHonda', 4, 2, 30000, 5)
			, ('carroHonda', 4, 2, 30000, 5)
-------------------------------------------------

CREATE	TABLE vendas(
		id INT PRIMARY KEY IDENTITY (1,1) NOT NULL
		, fk_cliente INT FOREIGN KEY REFERENCES clientes(id)
		, fk_vendedor INT FOREIGN KEY REFERENCES vendedor(id)
		, fk_veiculo INT FOREIGN KEY REFERENCES veiculo(id)
		, qtde int
		, data_venda date
	);

INSERT INTO vendas 
		VALUES(
		 1, 1, 1, 2, '6-12-2022 00:00:00')
		 , (1, 1, 2, 2, '6-12-2022 00:00:00')
		 , (2, 2, 3, 2, '6-12-2022 00:00:00')
		 , (2, 2, 4, 2, '6-12-2022 00:00:00')
		 , (3, 3, 5, 2, '6-12-2022 00:00:00')
		 , (3, 3, 6, 2, '6-12-2022 00:00:00')
-------------------------------------------------

CREATE	TABLE comissoes_vendedores(
		id INT PRIMARY KEY IDENTITY (1,1) NOT NULL
		, valor_comissao DECIMAL(7,2)
		, fk_vendedor INT FOREIGN KEY REFERENCES vendedor(id)
		, fk_venda INT FOREIGN KEY REFERENCES vendas(id)
		, data_comissao date
	);

-------------------------------------------------
-------------------------------------------------

-- VIEWS
-- 1
CREATE VIEW veiculo_marcas_modelos AS
	SELECT	veiculo.id
			, veiculo.nome
			, veiculo.valor
			, veiculo.qtde_estoque 
			, marcas.nome AS marca
			, modelos.nome AS modelo
		from veiculo
			INNER JOIN marcas
			ON veiculo.fk_marca = marcas.id
			INNER JOIN modelos 
			ON veiculo.fk_modelo = modelos.id;	

SELECT * FROM veiculo_marcas_modelos;

--2
CREATE VIEW vendedores_departamento AS
	SELECT	vendedor.id		
			, vendedor.nome
			, vendedor.fk_departamento
			, vendedor.salario
			, departamentos.nome AS departamento
		FROM vendedor
			INNER JOIN departamentos
			ON vendedor.fk_departamento = departamentos.id

SELECT * FROM vendedores_departamento

--3
CREATE VIEW veiculo_mais_vendido AS
	SELECT	modelos.nome AS modelo
			, marcas.nome AS marca
			, vendas.qtde AS quanntidade_vendida
		FROM veiculo		
			INNER JOIN marcas 
			ON veiculo.fk_marca = marcas.id
			INNER JOIN modelos
			ON veiculo.fk_modelo = modelos.id
			INNER JOIN vendas
			ON veiculo.id = vendas.fk_veiculo
			GROUP BY modelos.nome, marcas.nome, vendas.qtde
			having qtde = (select max(qtde) AS quantide_vendida from vendas)	

SELECT * FROM veiculo_mais_vendido

--4
CREATE VIEW vendedor_total_vendas AS
	SELECT	vendedor.nome 
			,SUM(vendas.qtde) as quantidade_de_vendas
		from vendedor 
			INNER JOIN vendas
			ON vendas.fk_vendedor = vendedor.id
			GROUP BY vendedor.nome

SELECT * FROM vendedor_total_vendas

--5
CREATE VIEW clientes_compra_acima_30mil AS
	SELECT	clientes.nome
			, veiculo.valor
		FROM clientes
			INNER JOIN vendas
			ON clientes.id = vendas.fk_cliente
			INNER JOIN veiculo
			ON vendas.fk_veiculo = veiculo.id
			WHERE veiculo.valor >= 30000

SELECT * FROM clientes_compra_acima_30mil

--PROCERURES
/*
1- Crie uma procedure que exiba o total de vendas de cada vendedor feitas em uma
determinada data 
*/

CREATE PROCEDURE total_vendas
    @data date 
	AS      
    SELECT	vendedor.id
			, vendedor.nome 
			, SUM (vendas.qtde) as quantidade_de_vendas
		FROM vendedor
			INNER JOIN vendas
			ON vendedor.id = vendas.fk_vendedor
			WHERE vendas.data_venda = @data
			GROUP BY vendedor.id, vendedor.id
					, vendedor.nome   	
GO

EXEC total_vendas '2022-06-12'

/*
2- Faça uma procedure que exiba os veículos comprados por um determinado cliente,
juntamente com os respectivos vendedores.
*/
CREATE PROCEDURE exibir_veiculos_cliente
	@cliente varchar(10)
	AS
	SELECT	veiculo.nome AS carro
			, clientes.nome AS cliente
			, vendedor.nome AS venedor
		FROM clientes
		INNER JOIN vendas
		ON clientes.id = vendas.fk_cliente
		INNER JOIN vendedor
		ON vendas.fk_vendedor = vendedor.id
		INNER JOIN veiculo
		ON vendas.fk_veiculo = veiculo.id
		WHERE clientes.nome = @cliente
GO		

EXEC exibir_veiculos_cliente 'cliente1'

/*o
3- Por meio de uma procedure, exiba os nomes dos clientes que compraram um determinado
veículo.
*/

CREATE PROCEDURE exibir_veiculo
	@veiculo varchar(10)
	AS
	SELECT	clientes.nome AS cliente
		FROM clientes
		INNER JOIN vendas 
		ON clientes.id = vendas.fk_cliente
		INNER JOIN vendedor
		ON vendedor.id = vendas.fk_vendedor
		INNER JOIN veiculo 
		ON veiculo.id = vendas.fk_veiculo
		WHERE @veiculo = veiculo.nome 
GO

EXEC exibir_veiculo 'carroHonda'

/*
4- Crie uma procedure que exiba o total de de vendedores que recebe maior do que um
determinado salário fornecido pelo usuário.
*/

CREATE PROCEDURE exibir_vendedores
	@salario DECIMAL
	AS
	SELECT COUNT(*) as total_de_vendedores
		FROM vendedor
		WHERE @salario <= vendedor.salario 
GO
drop procedure exibir_vendedores

EXEC exibir_vendedores 3500

/*
5- Crie uma procedure que exiba os carros de maior custo, menor custo e a quantidade de
carros em estoque.
*/
CREATE PROCEDURE carros_info
	AS 
	SELECT	COUNT(*) as quantiade_veiculos
			, MAX(veiculo.valor) as valor_max
			, MIN(veiculo.valor) as valor_min
		FROM veiculo

GO

EXEC carros_info

/*
6- Crie uma procedure que calcule a comissão de todos os vendedores com base em um mês
informado (parâmetros de mês e ano).
*/		
