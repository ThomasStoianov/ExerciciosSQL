-- Tema 1 — Biblioteca
USE biblioteca;

-- 1. Liste o título de cada livro, o nome de seu autor e o ano de publicação. 

SELECT * FROM livros AS L
LEFT JOIN autores AS A
ON L.id_autor = A.id_autor; 

-- 2. Liste o nome dos membros, os títulos dos livros emprestados, a data do empréstimo e a data
-- de devolução. 
SELECT L.titulo AS Titulo,
M.nome AS membro,
E.data_emprestimo,
E.data_devolucao
FROM emprestimos AS E
LEFT JOIN membros M ON E.id_membro = M.id_membro
LEFT JOIN livros L ON E.id_livro = L.id_livro;

-- 3. Liste o nome dos membros, os livros que pegaram emprestados e os respectivos autores
-- desses livros. 
SELECT M.nome AS membro,
L.titulo AS livro_emprestado,
A.nome AS autor
FROM emprestimos AS E
INNER JOIN membros M ON E.id_membro = M.id_membro
INNER JOIN livros L ON E.id_livro = L.id_livro
INNER JOIN autores A ON L.id_autor = A.id_autor;

-- Tema 2 — Clínica Veterinária
USE veterinaria;
-- 1. Liste o nome de cada cliente, o nome de seu pet, o tipo e a raça do animal. 
SELECT C.nome AS cliente,
P.nome AS nome_pet,
P.tipo AS tipo,
P.raca AS raca
FROM clientes AS C
LEFT JOIN pets P ON P.id_cliente = C.id_cliente;

-- 2. Liste o nome dos pets, a data do atendimento e a descrição do procedimento realizado
SELECT P.nome AS nome_pet,
A.data_atendimento,
A.descricao
FROM pets AS P
LEFT JOIN atendimentos A ON P.id_pet = A.id_pet;

-- 3. Liste o nome dos clientes, seus respectivos pets, os veterinários responsáveis e a
-- especialidade de cada veterinário. 
SELECT C.nome AS cliente,
P.nome AS nome_pet,
V.nome AS veterinario_resp,
V.especialidade AS veterinario_especialidade
FROM clientes AS C
LEFT JOIN pets AS P ON C.id_cliente = P.id_cliente
INNER JOIN atendimentos AS A ON P.id_pet = A.id_pet
INNER JOIN veterinarios AS V ON A.id_veterinario = V.id_veterinario;

-- Tema 3 — Carros
INSERT INTO historico_preco
(data_modificacao, id_carro, valor_anterior, valor_novo)
VALUES
('2026-08-25 20:00:00', 1, 50000.00, 55000.00),
('2026-08-25 20:05:00', 2, 70000.00, 75000.00);


USE carrosbd;
-- 1. Liste o nome dos proprietários e as informações dos seus veículos: marca, modelo, ano e cor.
SELECT P.nome AS proprietario,
C.marca, C.modelo, C.ano, C.cor
FROM proprietario AS P
INNER JOIN carros AS C ON P.id_carro = C.id;

-- 2. Liste a marca, o modelo e todas as alterações de preço registradas para cada veículo,
-- apresentando o valor anterior, o valor novo e a data da modificação. 
SELECT C.marca, C.modelo,
H.valor_anterior, H.valor_novo, H.data_modificacao
FROM carros AS C
INNER JOIN historico_preco AS H
ON C.id = H.id_carro;

-- 3. Liste o nome dos proprietários, a marca e o modelo de seus veículos e o histórico de
-- alterações de preço. 
SELECT P.nome, C.marca, C.modelo,
H.valor_anterior, H.valor_novo
FROM proprietario AS P
INNER JOIN carros AS C ON P.id_carro = C.id
INNER JOIN historico_preco AS H ON C.id = H.id_carro






