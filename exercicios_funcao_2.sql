USE carrosbd;

-- Exercício 1 — Cálculo de desconto
-- Crie uma função chamada `calculaDesconto` que receba:
-- - o valor original de um veículo;
-- - o percentual de desconto a ser aplicado.
-- A função deverá calcular e retornar o preço final do veículo após a aplicação do desconto.
-- Em seguida, faça uma consulta na tabela `carros` que apresente a marca, o valor original
-- e o preço com 20% de desconto.

DELIMITER $$
CREATE FUNCTION calculaDesconto(id_carrop INT, valorp INT, desconto FLOAT)
RETURNS INT
NO SQL 
BEGIN
	DECLARE valor_original INT;
	DECLARE valor_final INT;
	SELECT valor INTO valor_original FROM carros WHERE id = id_carrop;
	SET valor_final = valor_original - (valor_original * desconto) / 100;
	RETURN valor_final;
END $$
DELIMITER ;

SELECT calculaDesconto(1, 145000, 20);

-- Exercício 2 — Valor total de vendas por marca
-- Crie uma função chamada `valorTotalVendasPorMarca` que receba o nome de uma
-- marca. A função deverá consultar a tabela `carros`, multiplicar o valor de cada veículo pelo
-- respectivo número de vendas e retornar a soma desses valores para a marca informada.
-- Em seguida, utilize a função para consultar o valor total das vendas da marca `Fiat`.

DELIMITER $$
CREATE FUNCTION valorTotalVendasPorMarca(marcap VARCHAR(50))
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE valor_total INT;
	SELECT SUM(valor * numero_Vendas) INTO valor_total FROM carros WHERE marca =
	marcap;
	RETURN valor_total;
END$$

DELIMITER ;

SELECT valorTotalVendasPorMarca("Fiat");

-- Exercício 3 — Quantidade de carros por modelo
-- Crie uma função chamada `contarCarrosPorModelo` que receba o nome de um modelo de veículo.
-- A função deverá contar e retornar quantos registros desse modelo existem na tabela `carros`.
-- Em seguida, utilize a função para consultar a quantidade de carros do modelo `Mobi`.

DELIMITER $$

CREATE FUNCTION contarCarrosPorModelo(modelop VARCHAR(50))
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE quantidade INT;
	SELECT COUNT(*) INTO quantidade FROM carros WHERE modelo = modelop;
	RETURN quantidade;
END $$

DELIMITER ;

INSERT INTO carros (id, marca, modelo, ano, valor, cor, numero_Vendas)
VALUES (20, 'Fiat', 'Mobi', 2024, 75000.00, 'Branco', 150);

SELECT contarCarrosPorModelo("Mobi");

-- Exercício 4 — Nome do proprietário
-- Crie uma função chamada `nomeProprietario` que receba o identificador de um proprietário.
-- A função deverá consultar a tabela `proprietario` e retornar o nome correspondente ao identificador informado.
-- Em seguida, utilize a função para consultar o nome do proprietário de identificador `3`.

DELIMITER $$

CREATE FUNCTION nomeProprietario(id_proprietariop INT)
RETURNS VARCHAR(50)
READS SQL DATA
	BEGIN
	DECLARE nome_proprietario VARCHAR(50);
	SELECT nome INTO nome_proprietario FROM proprietario WHERE id = id_proprietariop;
	RETURN nome_proprietario;
END $$
	
DELIMITER ;

SELECT nomeProprietario(3);