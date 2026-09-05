USE carrosbd;

INSERT INTO historico_preco (id, data_modificacao, id_carro, valor_anterior, valor_novo)
VALUES (6,"2026-08-27 22:30:00", 1, 50000, 70000);

UPDATE carros
SET valor = 100000
WHERE id = 1;

INSERT INTO carros
(marca, modelo, ano, valor, cor, numero_Vendas)
VALUES
('Ford', 'Focus', 2020, 0, 'Prata', 3);