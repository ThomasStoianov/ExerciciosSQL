USE ecommerce_bd;

-- Parte A — Consultas fundamentais
-- Questão 1
-- A equipe comercial pretende desenvolver uma campanha direcionada aos produtos de maior valor.
-- Quais produtos cadastrados possuem preço superior a R$ 100,00? 

SELECT nome, preco FROM produtos WHERE preco > 100.00;

-- Questão 2 A equipe de marketing deseja realizar uma campanha de boas-vindas para 
-- os consumidores que ingressaram recentemente na plataforma. Quais clientes foram 
-- cadastrados durante o ano de 2026? 

SELECT nome FROM clientes WHERE YEAR(data_cadastro) = 2026;

-- Questão 3
-- A equipe responsável pelo estoque deseja identificar itens com risco de indisponibilidade. 
-- Quais produtos possuem menos de 10 unidades disponíveis em estoque? 

SELECT nome FROM produtos WHERE estoque < 10;

-- Questão 4
-- A equipe financeira deseja analisar as vendas de maior valor registradas na plataforma. Quais
-- pedidos, desconsiderando os cancelados, possuem valor total superior a R$ 500,00?

SELECT id_pedido FROM pedidos WHERE valor_total > 500 AND status <> "Cancelado";

	-- Questão 5
	-- A equipe comercial precisa visualizar os produtos começando pelos itens de maior valor. 
	-- Qual é a relação de produtos cadastrados, ordenada do maior para o menor preço? 

SELECT nome, preco FROM produtos ORDER BY preco DESC;	

-- Questão 6
-- A equipe de planejamento deseja conhecer o padrão geral de preços praticado pela empresa. 
-- Qual é o preço médio dos produtos cadastrados? 

SELECT ROUND(AVG(preco), 2) AS média_produto FROM produtos;

-- Questão 7
-- A equipe comercial deseja identificar os extremos de preço existentes no catálogo. 
-- Quais são o maior e o menor preço entre os produtos cadastrados? 

SELECT MAX(preco) AS maior_valor, MIN(preco) AS menor_valor FROM produtos;

-- Questão 8
-- A equipe de marketing pretende analisar a distribuição geográfica da base de consumidores. 
-- Quantos clientes cadastrados existem em cada estado? 

SELECT estado, COUNT(id_cliente) AS quantidade
FROM clientes GROUP BY estado;

-- Questão 9
-- A equipe responsável pelo catálogo considera uma categoria amplamente representada quando ela
-- possui mais de três produtos cadastrados. Quais categorias atendem a esse critério? 

SELECT c.nome, COUNT(p.id_categoria) AS quantidade
FROM categorias c 
INNER JOIN produtos p
ON c.id_categoria = p.id_categoria
GROUP BY c.nome
HAVING COUNT(p.id_categoria) > 3;

-- Questão 10
-- A equipe financeira deseja conhecer o faturamento registrado pela plataforma. Qual é o 
-- valor total dos pedidos, desconsiderando aqueles que foram cancelados? 

SELECT SUM(valor_total) AS valor_total_pedidos FROM pedidos WHERE status <> "cancelado";

-- Parte B — Consultas com subqueries

-- Questão 11
-- A equipe comercial deseja identificar produtos posicionados acima do padrão geral de preços do
-- catálogo. Quais produtos possuem preço superior ao preço médio de todos os produtos
-- cadastrados? 

SELECT nome, preco FROM produtos WHERE preco > (
	SELECT AVG(preco) FROM produtos
);

-- Questão 12
-- A equipe de relacionamento deseja identificar os clientes com frequência de compra superior ao
-- comportamento médio dos consumidores que já realizaram pedidos. Quais clientes efetuaram uma
-- quantidade de pedidos superior à média de pedidos por cliente?

SELECT c.nome, COUNT(p.id_pedido) AS quantidade_pedidos
FROM clientes c
INNER JOIN pedidos p
ON c.id_cliente = p.id_cliente
GROUP BY p.id_cliente, c.nome
HAVING COUNT(p.id_pedido) > (
    SELECT AVG(quantidade)
    FROM (
        SELECT COUNT(*) AS quantidade
        FROM pedidos p
        GROUP BY p.id_cliente
    ) AS pedidos_por_cliente
);

-- Questão 13
-- A equipe responsável pelo catálogo deseja conhecer o item de maior valor em cada segmento. 
-- Qual é o produto mais caro de cada categoria que possui produtos cadastrados? 

SELECT c.nome AS categoria, p.nome AS produto, p.preco
FROM categorias c
INNER JOIN produtos p
ON c.id_categoria = p.id_categoria
WHERE p.preco = (
    SELECT MAX(p2.preco)
    FROM produtos p2
    WHERE p2.id_categoria = p.id_categoria
);

-- Questão 14
-- A equipe de relacionamento pretende identificar consumidores que já realizaram compras de
-- valor elevado. Quais clientes possuem pelo menos um pedido não cancelado cujo valor total 
-- seja superior à média dos pedidos não cancelados? 

SELECT c.nome
FROM clientes c
INNER JOIN pedidos p
ON c.id_cliente = p.id_cliente
WHERE p.status <> 'cancelado'
AND p.valor_total > (
    SELECT AVG(p2.valor_total)
    FROM pedidos p2
    WHERE p2.status <> 'cancelado'
);




















