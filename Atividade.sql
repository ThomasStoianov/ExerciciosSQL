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

-- Parte C — Análise com relacionamentos entre tabelas
-- Questão 18
-- A equipe responsável pelo catálogo deseja produzir um relatório que associe cada produto ao seu
-- respectivo segmento. Qual é o nome de cada produto e de sua categoria?

SELECT p.nome, c.nome FROM produtos p
INNER JOIN categorias c
ON p.id_categoria = c.id_categoria;

-- USE ecommerce_bd;

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

-- Parte C — Análise com relacionamentos entre tabelas
-- Questão 18
-- A equipe responsável pelo catálogo deseja produzir um relatório que associe cada produto ao seu
-- respectivo segmento. Qual é o nome de cada produto e de sua categoria?

SELECT p.nome, c.nome FROM produtos p
INNER JOIN categorias c
ON p.id_categoria = c.id_categoria;

-- USE ecommerce_bd;

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

-- Parte C — Análise com relacionamentos entre tabelas
-- Questão 18
-- A equipe responsável pelo catálogo deseja produzir um relatório que associe cada produto ao seu
-- respectivo segmento. Qual é o nome de cada produto e de sua categoria?

SELECT p.nome, c.nome FROM produtos p
INNER JOIN categorias c
ON p.id_categoria = c.id_categoria;

-- Questão 19
-- A equipe financeira precisa consultar os dados gerais das compras registradas. Para cada pedido,
-- quais são o número do pedido, o nome do cliente, a data da compra e o valor total?

SELECT p.id_pedido, c.nome, p.data_pedido, p.valor_total FROM pedidos p
INNER JOIN clientes c
ON p.id_cliente = c.id_cliente;

-- Questão 20
-- A equipe responsável pela separação dos pedidos precisa visualizar os itens incluídos em cada
-- compra. Para cada item vendido, quais são o número do pedido, o nome do produto, a quantidade
-- adquirida e o preço unitário praticado?

SELECT pe.id_pedido, pr.nome, ip.quantidade, ip.preco_unitario
FROM pedidos pe
INNER JOIN itens_pedido ip
ON pe.id_pedido = ip.id_pedido
INNER JOIN produtos pr
ON ip.id_produto = pr.id_produto;

-- Questão 21
-- A equipe de marketing deseja analisar o histórico de consumo dos clientes. Quais produtos já foram
-- adquiridos por cada cliente que realizou pelo menos uma compra?

SELECT c.nome, pr.nome FROM clientes c
INNER JOIN pedidos pe
ON c.id_cliente = pe.id_cliente
INNER JOIN itens_pedido ip
ON pe.id_pedido = ip.id_pedido
INNER JOIN produtos pr
ON ip.id_produto = pr.id_produto;

-- Questão 22
-- A equipe de gestão deseja analisar o desempenho dos produtos em seus respectivos segmentos.
-- Para cada produto vendido, quais são sua categoria, seu nome e a quantidade total comercializada?

SELECT c.nome AS categoria, p.nome AS produto, SUM(ip.quantidade) AS quantidade_total FROM categorias c 
INNER JOIN produtos p 
ON c.id_categoria = p.id_categoria
INNER JOIN itens_pedido ip 
ON p.id_produto = ip.id_produto
GROUP BY c.nome, p.nome;

-- Questão 23
-- A equipe de relacionamento precisa visualizar toda a base de clientes, inclusive aqueles que ainda
-- não realizaram compras. Quais clientes estão cadastrados e quais pedidos estão associados a cada
-- um deles?

SELECT c.nome, p.id_pedido FROM clientes c 
LEFT JOIN pedidos p 
ON c.id_cliente = p.id_cliente;

-- Questão 24
-- A equipe de estoque deseja visualizar todos os produtos do catálogo, inclusive os que nunca foram
-- comercializados. Quais produtos estão cadastrados e em quais pedidos eles aparecem?

SELECT pr.nome AS produto, ip.id_pedido AS numero_pedido FROM produtos pr
LEFT JOIN itens_pedido ip 
ON pr.id_produto = ip.id_produto;

-- Questão 25
-- A equipe responsável pelo catálogo deseja verificar a ocupação das categorias existentes. Quais
-- categorias estão cadastradas e quais produtos estão associados a cada uma, incluindo as categorias
-- que ainda não possuem produtos?

SELECT c.nome AS categoria, p.nome AS produto FROM categorias c
LEFT JOIN produtos p 
ON c.id_categoria = p.id_categoria;

-- Questão 26
-- A equipe de marketing deseja criar uma campanha direcionada aos consumidores sem histórico de
-- compra. Quais clientes cadastrados nunca realizaram pedidos?

SELECT c.nome AS cliente FROM clientes c 
LEFT JOIN pedidos p 
ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;

-- Questão 27
-- A equipe comercial deseja identificar itens sem movimentação para avaliar a necessidade de
-- campanhas promocionais. Quais produtos nunca foram incluídos em um pedido?

SELECT p.nome AS produto FROM produtos p
LEFT JOIN itens_pedido ip 
ON p.id_produto = ip.id_produto
WHERE ip.id_produto IS NULL;

-- Parte D — Comparação entre tipos de JOIN

-- Questão 28
-- A equipe responsável pelo catálogo precisa de uma consulta que apresente todos os produtos e suas
-- respectivas categorias. Como essa relação pode ser obtida utilizando RIGHT JOIN, mantendo todos
-- os produtos no resultado?

SELECT c.nome AS categoria, p.nome AS produto FROM categorias c 
RIGHT JOIN produtos p 
ON c.id_categoria = p.id_categoria;

-- Questão 29
-- A equipe financeira deseja visualizar todos os pedidos e os clientes responsáveis por cada compra.
-- Como essa relação pode ser obtida utilizando RIGHT JOIN, garantindo a permanência de todos os
-- pedidos no resultado?

SELECT c.nome, p.id_pedido FROM clientes c 
RIGHT JOIN pedidos p 
ON c.id_cliente = p.id_cliente























