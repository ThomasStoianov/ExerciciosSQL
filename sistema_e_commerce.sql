-- =========================================================
-- ATIVIDADE 1 — SISTEMA DE E-COMMERCE
-- SCRIPT COMPLETO: DDL, DML E DQL (Consultas, Subqueries e JOINs)
-- Compatível com MySQL / Workbench (Safe Mode)
-- =========================================================

-- PARTE 0: CRIAÇÃO DO BANCO E POPULAÇÃO
DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255)
);

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    cidade VARCHAR(100),
    estado VARCHAR(2),
    data_cadastro DATE NOT NULL
);

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    data_pedido DATE NOT NULL,
    status VARCHAR(30),
    valor_total DECIMAL(10,2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- INSERÇÃO DE DADOS
INSERT INTO categorias (nome, descricao) VALUES
('Eletrônicos', 'Acessórios e gadgets'),
('Informática', 'Hardware e periféricos'),
('Casa', 'Utensílios domésticos'),
('Livros', 'Literatura e técnicos'),
('Esportes', 'Equipamentos esportivos'),
('Papelaria', 'Material de escritório'); -- Categoria sem produtos (para JOIN)

INSERT INTO clientes (nome, email, cidade, estado, data_cadastro) VALUES
('Ana Souza', 'ana@email.com', 'São Paulo', 'SP', '2026-01-10'),
('Bruno Lima', 'bruno@email.com', 'Campinas', 'SP', '2026-01-15'),
('Carla Mendes', 'carla@email.com', 'Rio', 'RJ', '2026-02-03'),
('Daniel Rocha', 'daniel@email.com', 'Niterói', 'RJ', '2026-02-18'),
('Eduarda Alves', 'eduarda@email.com', 'BH', 'MG', '2026-03-05'),
('Felipe Costa', 'felipe@email.com', 'Uberlândia', 'MG', '2026-03-21'),
('Gabriela Martins', 'gabriela@email.com', 'Curitiba', 'PR', '2026-04-02'),
('Henrique Gomes', 'henrique@email.com', 'Londrina', 'PR', '2026-04-17'),
('Isabela Ferreira', 'isabela@email.com', 'Salvador', 'BA', '2026-05-06'),
('João Ribeiro', 'joao@email.com', 'Recife', 'PE', '2026-05-20');

INSERT INTO produtos (nome, preco, estoque, categoria_id) VALUES
('Fone Bluetooth', 199.90, 35, 1),
('Smartwatch', 850.00, 20, 1),
('Câmera Profissional', 2500.00, 2, 1),
('Caixa de Som', 150.00, 15, 1), -- 4º produto para Eletrônicos (DQL 9)
('Teclado Mecânico', 289.90, 5, 2),
('Mouse Sem Fio', 129.90, 40, 2),
('Monitor 4K', 1800.00, 10, 2),
('Webcam HD', 210.00, 12, 2), -- 4º produto para Informática (DQL 9)
('Cafeteira', 249.90, 18, 3),
('Jogo de Panelas', 399.90, 8, 3),
('Fritadeira Elétrica', 450.00, 5, 3),
('Mixer', 120.00, 20, 3), -- 4º produto para Casa (DQL 9)
('Livro SQL', 89.90, 50, 4),
('Livro Python', 119.90, 30, 4),
('Tapete Yoga', 79.90, 25, 5),
('Garrafa Térmica', 69.90, 45, 5),
('Produto Nunca Vendido', 50.00, 10, 2); -- Para subquery 5

INSERT INTO pedidos (cliente_id, data_pedido, status, valor_total) VALUES
(1, '2026-06-01', 'Entregue', 0),
(1, '2026-06-15', 'Entregue', 0),
(1, '2026-06-20', 'Entregue', 0), -- Cliente 1 com 3 pedidos (acima da média para Subquery 2)
(2, '2026-06-03', 'Entregue', 0),
(2, '2026-06-25', 'Entregue', 0), -- Cliente 2 com 2 pedidos
(3, '2026-06-08', 'Processando', 0),
(4, '2026-06-12', 'Enviado', 0),
(5, '2026-06-18', 'Entregue', 0),
(6, '2026-06-23', 'Cancelado', 0),
(7, '2026-07-01', 'Enviado', 0);

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 199.90), (1, 6, 1, 129.90),
(2, 3, 1, 2500.00),
(3, 1, 1, 289.90),
(4, 5, 1, 249.90),
(5, 9, 1, 289.90),
(6, 11, 1, 249.90),
(7, 2, 2, 399.90),
(8, 4, 1, 850.00),
(9, 7, 1, 1800.00),
(10, 8, 3, 69.90);

-- ATUALIZAÇÃO DO VALOR TOTAL (Com WHERE id > 0 para Safe Mode)
UPDATE pedidos
SET valor_total = (
    SELECT SUM(ip.quantidade * ip.preco_unitario)
    FROM itens_pedido ip
    WHERE ip.pedido_id = pedidos.id
)
WHERE id > 0;

-- Liste todos os produtos com preço superior a R$ 100,00
SELECT preco_unitario AS preco
FROM itens_pedido
WHERE preco_unitario > 100;

-- Liste os clientes cadastrados no ano de 2026
SELECT nome as clientes
FROM clientes
WHERE  YEAR(data_cadastro) = 2026;

-- Liste os produtos com estoque inferior a 10 unidades
SELECT nome, estoque AS quantidade
FROM produtos
WHERE estoque < 10;

-- Liste os pedidos cujo valor total seja superior a R$ 500,00
SELECT *
FROM pedidos
WHERE valor_total > 500;

-- Exiba os produtos ordenados do maior para o menor preço
SELECT nome as produto, preco
FROM produtos
ORDER BY preco DESC;

-- Calcule o valor médio dos produtos cadastrados
SELECT AVG(preco)
FROM produtos;

-- Informe o maior e o menor preço entre os produtos
SELECT MAX(preco) AS maior_preco, MIN(preco) AS menor_preco
FROM produtos;

-- Liste a quantidade de clientes cadastrados por estado
SELECT estado, COUNT(*) AS quantidade_clientes
FROM clientes
GROUP BY estado;

-- Liste as categorias que possuem mais de três produtos
SELECT categoria_id, COUNT(*) AS quantidade_produtos
FROM produtos
GROUP BY categoria_id
HAVING COUNT(*) > 3;

-- Calcule o valor total vendido em todos os pedidos. 
SELECT SUM(valor_total) AS valor_total
FROM pedidos;

-- CONSULTAS AVANÇADAS SUBQUERY
-- 1. Liste os produtos cujo preço está acima do preço médio dos produtos. 
SELECT nome, preco
FROM produtos
WHERE preco > ( 
	SELECT AVG(preco)
    FROM produtos	
);

-- 2. Liste os clientes que realizaram mais pedidos do que a média de pedidos por cliente. 
SELECT clientes.nome, COUNT(pedidos.id) AS quantidade_pedidos
FROM clientes
INNER JOIN pedidos
    ON clientes.id = pedidos.cliente_id
GROUP BY clientes.id, clientes.nome
HAVING COUNT(pedidos.id) > (
    SELECT AVG(quantidade_pedidos)
    FROM (
        SELECT COUNT(*) AS quantidade_pedidos
        FROM pedidos
        GROUP BY cliente_id
    ) AS pedidos_por_cliente
);

-- Encontre o produto mais caro de cada categoria.    
SELECT categoria_id, nome, preco
FROM produtos p
WHERE preco = (
    SELECT MAX(preco)
    FROM produtos
    WHERE categoria_id = p.categoria_id
);

-- 4. Liste os clientes que realizaram pelo menos um pedido acima da média geral dos pedidos. 
SELECT DISTINCT clientes.nome
FROM clientes
INNER JOIN pedidos
    ON clientes.id = pedidos.cliente_id
WHERE pedidos.valor_total > (
    SELECT AVG(valor_total)
    FROM pedidos
);

-- 5. Liste os produtos que nunca foram vendidos. 
SELECT nome
FROM produtos
WHERE id NOT IN (
    SELECT produto_id
    FROM itens_pedido
);

-- 6. Liste as categorias cuja média de preço dos produtos é superior à média geral de preços. 
SELECT categoria_id, AVG(preco) AS media_categoria
FROM produtos
GROUP BY categoria_id
HAVING AVG(preco) > (
    SELECT AVG(preco)
    FROM produtos
);

-- 7. Encontre o cliente que realizou o pedido de maior valor. 
SELECT clientes.nome, pedidos.valor_total
FROM clientes
INNER JOIN pedidos
    ON clientes.id = pedidos.cliente_id
WHERE pedidos.valor_total = (
    SELECT MAX(valor_total)
    FROM pedidos
);

-- JOIN

-- 1. Liste o nome do produto e o nome de sua categoria. 
SELECT produtos.nome AS produto,
       categorias.nome AS categoria
FROM produtos
INNER JOIN categorias
    ON produtos.categoria_id = categorias.id;
    
-- 2. Liste o número do pedido, nome do cliente, data do pedido e valor total. 
SELECT pedidos.id AS numero_pedido,
       clientes.nome AS cliente,
       pedidos.data_pedido,
       pedidos.valor_total
FROM pedidos
INNER JOIN clientes
    ON pedidos.cliente_id = clientes.id;
    
-- Liste todos os produtos presentes em pedidos, exibindo:
-- o número do pedido;
-- o produto;
-- o quantidade;
-- o preço unitário. 
SELECT pedidos.id AS numero_pedido,
       produtos.nome AS produto,
       itens_pedido.quantidade,
       itens_pedido.preco_unitario
FROM pedidos
INNER JOIN itens_pedido
    ON pedidos.id = itens_pedido.pedido_id
INNER JOIN produtos
    ON itens_pedido.produto_id = produtos.id;
    
-- 4. Liste o nome de cada cliente e os produtos que ele já comprou.
SELECT clientes.nome AS cliente,
       produtos.nome AS produto
FROM clientes
INNER JOIN pedidos
    ON clientes.id = pedidos.cliente_id
INNER JOIN itens_pedido
    ON pedidos.id = itens_pedido.pedido_id
INNER JOIN produtos
    ON itens_pedido.produto_id = produtos.id;


-- 5. Liste o nome da categoria, produto e quantidade vendida de cada produto.
SELECT categorias.nome AS categoria,
       produtos.nome AS produto,
       itens_pedido.quantidade
FROM categorias
INNER JOIN produtos
    ON categorias.id = produtos.categoria_id
INNER JOIN itens_pedido
    ON produtos.id = itens_pedido.produto_id;


-- 6. Liste todos os clientes e seus pedidos, incluindo clientes que ainda não realizaram nenhuma compra.
SELECT clientes.nome AS cliente,
       pedidos.id AS numero_pedido,
       pedidos.data_pedido,
       pedidos.valor_total
FROM clientes
LEFT JOIN pedidos
    ON clientes.id = pedidos.cliente_id;


-- 7. Liste todos os produtos e os pedidos nos quais aparecem, incluindo produtos que nunca foram vendidos.
SELECT produtos.nome AS produto,
       pedidos.id AS numero_pedido
FROM produtos
LEFT JOIN itens_pedido
    ON produtos.id = itens_pedido.produto_id
LEFT JOIN pedidos
    ON itens_pedido.pedido_id = pedidos.id;


-- 8. Liste todas as categorias e seus respectivos produtos, inclusive categorias que não possuem produtos cadastrados.
SELECT categorias.nome AS categoria,
       produtos.nome AS produto
FROM categorias
LEFT JOIN produtos
    ON categorias.id = produtos.categoria_id;


-- 9. Identifique os clientes que nunca realizaram pedidos utilizando LEFT JOIN.
SELECT clientes.nome
FROM clientes
LEFT JOIN pedidos
    ON clientes.id = pedidos.cliente_id
WHERE pedidos.id IS NULL;


-- 10. Identifique produtos que nunca foram vendidos.
SELECT produtos.nome
FROM produtos
LEFT JOIN itens_pedido
    ON produtos.id = itens_pedido.produto_id
WHERE itens_pedido.id IS NULL;


-- 11. Liste todos os produtos e suas categorias utilizando RIGHT JOIN.
SELECT produtos.nome AS produto,
       categorias.nome AS categoria
FROM categorias
RIGHT JOIN produtos
    ON produtos.categoria_id = categorias.id;


-- 12. Liste todos os pedidos e seus respectivos clientes utilizando RIGHT JOIN.
SELECT pedidos.id AS numero_pedido,
       clientes.nome AS cliente
FROM clientes
RIGHT JOIN pedidos
    ON clientes.id = pedidos.cliente_id;


-- 13. Utilize RIGHT JOIN para listar todos os produtos, mesmo que não estejam presentes em nenhum item de pedido.
SELECT produtos.nome AS produto,
       itens_pedido.pedido_id
FROM itens_pedido
RIGHT JOIN produtos
    ON itens_pedido.produto_id = produtos.id;


-- 14. Compare o resultado de uma consulta utilizando LEFT JOIN com sua equivalente utilizando RIGHT JOIN.

-- LEFT JOIN
SELECT produtos.nome AS produto,
       categorias.nome AS categoria
FROM produtos
LEFT JOIN categorias
    ON produtos.categoria_id = categorias.id;

-- RIGHT JOIN
SELECT produtos.nome AS produto,
       categorias.nome AS categoria
FROM categorias
RIGHT JOIN produtos
    ON produtos.categoria_id = categorias.id;

INSERT INTO produtos (id, nome, preco, estoque, categoria_id)
VALUES (18, 'Mouse Gamer', 0, 35, 1);

INSERT INTO clientes (id, nome, email, cidade, estado, data_cadastro)
VALUES (11, 'Ricardo Goulart', 'joao@gmail.com', 'São Paulo', 'SP', '2026-08-28');

UPDATE produtos
SET preco = 1650.00
WHERE id = 7;








