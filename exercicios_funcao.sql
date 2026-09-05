USE biblioteca;

-- Exercicio 1. Crie uma função que recebe o id_autor e retorna a idade do autor com base na data de nascimento.

DELIMITER $$

CREATE FUNCTION idade_autor(id_autorp INT(10))
RETURNS INT
READS SQL DATA
BEGIN

    DECLARE data_nascimento_autor DATE;
    SELECT data_nascimento INTO data_nascimento_autor FROM autores WHERE id_autor = id_autorp;

    RETURN TIMESTAMPDIFF(YEAR, data_nascimento_autor, CURDATE());

END $$

DELIMITER ;

DROP FUNCTION IF EXISTS idade_autor;

SELECT idade_autor(2);

-- 	Exercicio 2. Crie uma função que recebe o id_autor e retorna a quantidade de livros escritos por esse autor.
DROP FUNCTION IF EXISTS qtd_por_autor;

DELIMITER $$

CREATE FUNCTION qtd_por_autor(id_autorp INT(10))
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE quantidade_livros INT;
    SELECT COUNT(id_livro) INTO quantidade_livros FROM livros WHERE id_autor = id_autorp;
    RETURN quantidade_livros;

END  $$

DELIMITER ;


SELECT(qtd_por_autor(3));

-- Exercicio 3. Crie uma função que recebe duas datas e retorna o total de empréstimos realizados nesse período.
DELIMITER $$

CREATE FUNCTION qtd_emprestimos(data_inicio DATE, data_fim DATE)
RETURNS INT
READS SQL DATA
BEGIN

	DECLARE quantidade_emprestimos INT;

    SELECT COUNT(*) INTO quantidade_emprestimos FROM emprestimos
    WHERE data_emprestimo BETWEEN data_inicio AND data_fim;

    RETURN quantidade_emprestimos;

END $$

DELIMITER ;

SELECT qtd_emprestimos('2024-07-01', '2024-08-05');

-- Exercicio 4. Crie uma função que retorna a média de dias em que os livros foram emprestados.

DELIMITER $$

CREATE FUNCTION media_dias_emprestimo()
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN

    DECLARE media_dias DECIMAL(10,2);

    SELECT AVG(DATEDIFF(data_devolucao, data_emprestimo))
    INTO media_dias
    FROM emprestimos;

    RETURN media_dias;

END $$

DELIMITER ;

SELECT media_dias_emprestimo();

-- Exercício 5 — Crie uma função que verifique disponibilidade do livro a partir do id_livro e retorne:
-- •	"Disponível", quando houver exemplares no estoque; 
-- •	"Indisponível", quando o estoque for igual a zero.

DELIMITER $$

CREATE FUNCTION disponibilidade_livro(id_livrop INT)
RETURNS VARCHAR(30)
READS SQL DATA
BEGIN

DECLARE livro_disponivel INT;
SELECT COUNT(*) INTO livro_disponivel FROM emprestimos WHERE id_livro = id_livrop 
AND data_devolucao > CURDATE();

IF livro_disponivel > 0 THEN 
	RETURN 'Livro indisponível';
ELSE
	RETURN "Livro disponível";
END IF;

END $$

DELIMITER ;

SELECT disponibilidade_livro(1)









