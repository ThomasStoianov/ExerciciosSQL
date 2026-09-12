USE biblioteca;

-- BIBLIOTECA 
-- Exercicio 1. Crie uma stored procedure que registre um novo empréstimo, verificando se o membro e 
-- o livro existem. Caso não existam, exiba mensagem de erro

DELIMITER $$

CREATE PROCEDURE novo_emprestimo(
IN p_id_emprestimo INT, 
IN p_id_membro INT, 
IN p_id_livro INT, 
IN p_data_emprestimo DATE, 
IN p_data_devolucao DATE
)
BEGIN
	DECLARE membro INT;
    DECLARE livro INT;
    
    SELECT COUNT(*) INTO membro FROM membros WHERE id_membro = p_id_membro;
    SELECT COUNT(*) INTO livro FROM livros WHERE id_livro = p_id_livro;
    
    IF membro = 0 OR livro = 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ERRO';
    ELSE
		INSERT INTO emprestimos (id_emprestimo, id_membro, id_livro, data_emprestimo, data_devolucao)
        VALUES (p_id_emprestimo, p_id_membro, p_id_livro, p_data_emprestimo, p_data_devolucao);
	END IF;
    
END $$

DELIMITER ;

DROP PROCEDURE novo_emprestimo;

CALL novo_emprestimo(7,3,4, "2026-09-08", "2026-09-21");

-- Exercício 2. Crie uma procedure chamada consulta_emprestimos_membro que receba o ID de um membro 
-- e apresente todos os empréstimos realizados por ele.

DELIMITER $$

CREATE PROCEDURE consulta_emprestimos(IN p_id_membro INT)
BEGIN
	SELECT * FROM emprestimos WHERE id_membro = p_id_membro;
END $$

DELIMITER ;


CALL consulta_emprestimos(3);

-- Exercício 3 . Crie uma procedure chamada livro_mais_emprestado que retorne o título do livro que possui 
-- a maior quantidade de empréstimos.

DELIMITER $$

CREATE PROCEDURE livro_mais_emprestado()
BEGIN
	SELECT livros.titulo, COUNT(*) AS quantidade
    FROM emprestimos
    JOIN livros
        ON emprestimos.id_livro = livros.id_livro
    GROUP BY emprestimos.id_livro
    ORDER BY quantidade DESC
    LIMIT 1;

END $$

DELIMITER ;

DROP PROCEDURE livro_mais_emprestado;

CALL livro_mais_emprestado();

-- CARRO

USE carrosbd;

-- Exercicio 1. Crie uma stored procedure que insira um novo carro na tabela carros
DELIMITER $$

CREATE PROCEDURE inserir_carro(
IN p_id INT,
IN p_marca VARCHAR(255),
IN p_modelo VARCHAR(255),
IN p_ano INT,
IN p_valor INT,
IN p_cor VARCHAR(255),
IN p_numero_Vendas INT
)
BEGIN
	INSERT INTO carros (id, marca, modelo, ano, valor, cor, numero_Vendas)
    VALUES (p_id, p_marca, p_modelo, p_ano, p_valor, p_cor, p_numero_Vendas);
END $$

DELIMITER ;

CALL inserir_carro(22, 'BMW', 'M8 Competition', 2025, 1500000, 'Preto', 12);

-- Exercicio 2. Crie uma stored procedure que atualize o valor de um carro na tabela carros, baseado no ID do carro,
-- e insira o histórico dessa modificação na tabela historico_preco.

DELIMITER $$

CREATE PROCEDURE atualizar_valor(IN p_id INT, IN p_valor INT)
BEGIN
	DECLARE valor_anterior INT;

    SELECT valor INTO valor_anterior FROM carros WHERE id = p_id;

	UPDATE carros SET valor = p_valor WHERE id = p_id;
    
    INSERT INTO historico_preco ( data_modificacao, id_carro, valor_anterior, valor_novo)
    VALUES (CURDATE(), p_id, valor_anterior, p_valor);
END $$

DELIMITER ;

DROP PROCEDURE atualizar_valor;

CALL atualizar_valor(3, 150000);

-- Exercício 3. Crie uma procedure chamada consulta_historico_preco que receba o ID de um carro e apresente
--  todas as alterações de preço registradas para ele.

DELIMITER $$

CREATE PROCEDURE consulta_historico(IN p_id INT)
BEGIN
	SELECT * FROM historico_preco WHERE id_carro = p_id;
END $$

DELIMITER ;

CALL consulta_historico(1);

DROP PROCEDURE consulta_historico;

-- Exercício 4. Crie uma procedure chamada remove_carro que exclua um carro somente quando ele não 
-- possuir registros na tabela historico_preco.

DELIMITER $$

CREATE PROCEDURE remove_carro(IN p_id_carro INT)
BEGIN
	DECLARE carro INT;
    
    SELECT COUNT(*) INTO carro FROM historico_preco WHERE id_carro = p_id_carro;
    
    IF carro > 0 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Não é possível excluir o carro';
    ELSE
		DELETE FROM carros WHERE id = p_id_carro;
	END IF;
END $$

DELIMITER ;

DROP PROCEDURE remove_carro;

CALL remove_carro(5);

DELETE FROM proprietario
WHERE id_carro = 5;

DELETE FROM revisoes
WHERE id_carro = 5;

-- Exercício 5. Crie uma procedure chamada carros_por_faixa_preco que receba um valor
-- mínimo e um valor máximo e apresente os carros pertencentes a essa faixa de preço.

DELIMITER $$

CREATE PROCEDURE carros_por_faixa_preco(p_valor_minimo INT, p_valor_maximo INT)
BEGIN
	SELECT valor FROM CARROS WHERE valor BETWEEN p_valor_minimo AND p_valor_maximo;
END $$

DELIMITER ;

CALL carros_por_faixa_preco(150000, 200000);

DELIMITER ;

-- ACADEMICO
USE bd_academica;

-- Exercicio 1. Crie uma procedure chamada insere_professor que insere um professor na tabela professores e 
-- retorna o ID gerado. (DESAFIO)

DELIMITER $$

CREATE PROCEDURE insere_professor(
IN p_nome VARCHAR(255),
IN p_departamento VARCHAR(255),
IN p_ano_inicio_carreira INT
)
BEGIN 
	INSERT INTO professores (nome, departamento, ano_inicio_carreira)
    VALUES (p_nome, p_departamento, p_ano_inicio_carreira);
    
    SELECT MAX(id) AS "ultimo ID" FROM professores;
    
END $$

DELIMITER ;

DROP PROCEDURE insere_professor;

CALL insere_professor("Gabriel", "história", 2010);

-- Exercicio 2. Crie uma procedure chamada atualiza_disciplina que recebe o ID de uma disciplina e 
-- atualiza o nome dessa disciplina.

DELIMITER $$

CREATE PROCEDURE atualiza_disciplina(IN p_id INT, IN p_nome VARCHAR(255))
BEGIN 
	UPDATE disciplinas SET nome = p_nome WHERE id = p_id;
END $$

DELIMITER ;

CALL atualiza_disciplina(1, "Estrutura de dados");

-- Exercicio 3. Crie uma procedure chamada remove_estudante que remove um estudante da tabela estudantes com 
-- base no ID passado como parâmetro.

set foreign_key_checks = 0;

DELIMITER $$

CREATE PROCEDURE remove_estudante(IN p_id INT)
BEGIN 
	DELETE FROM estudantes WHERE id = p_id;
END $$

DELIMITER ;

CALL remove_estudante(4);

DELETE FROM matriculas WHERE estudante_id = 4;

DELETE FROM matriculas WHERE disciplinas_id = 5;

-- Exercicio 4. Crie uma procedure chamada consulta_professor que retorna o nome e departamento de um professor
-- com base no ID passado.

DELIMITER $$

CREATE PROCEDURE consulta_professor(IN p_id INT)
BEGIN
	SELECT nome, departamento FROM professores WHERE id = p_id;
END $$

DELIMITER ;

CALL consulta_professor(8);

-- Exercicio 5. Crie uma procedure chamada atualiza_nota que atualiza a nota de um 
-- estudante para uma disciplina específica, com base no ID da matrícula.

DELIMITER $$

CREATE PROCEDURE atualiza_nota(
IN p_id INT, 
IN p_nota INT, 
IN p_disciplina VARCHAR(200)
)
BEGIN
	DECLARE id_disciplina INT;
	DECLARE id_matricula INT;
    SELECT id INTO id_disciplina FROM disciplinas WHERE nome = p_disciplina; -- 3
    SELECT id INTO id_matricula FROM matriculas WHERE disciplina_id = id_disciplina AND estudante_id = p_id;
    
	UPDATE notas SET nota = p_nota WHERE matricula_id = id_matricula;
END $$

DELIMITER ;

DROP PROCEDURE atualiza_nota;

CALL atualiza_nota(2, 6, "física geral");

	-- Exercício 6. Crie uma procedure chamada media_disciplina que receba o ID de uma 
	-- disciplina e retorne, por meio de um parâmetro OUT, a média das notas dos estudantes. 
	-- (DESAFIO)

DELIMITER $$

CREATE PROCEDURE media_disciplina(
    IN p_id_disciplina INT,
    OUT p_media DECIMAL(10,2)
)
BEGIN

    SELECT AVG(notas.nota) INTO p_media
    FROM notas
    JOIN matriculas
    ON notas.matricula_id = matriculas.id
    WHERE matriculas.disciplina_id = p_id_disciplina;

END $$

DELIMITER ;

CALL media_disciplina(3, @media);

SELECT @media;

DROP PROCEDURE media_disciplina;

-- Exercício 7. Crie uma procedure chamada remove_professor que remova um professor
-- somente quando ele não estiver associado a nenhuma disciplina.

DELIMITER $$

CREATE PROCEDURE remove_professor(
IN p_id_professor INT
)
BEGIN
	DECLARE professor INT;
    SELECT COUNT(id) INTO professor FROM disciplinas WHERE id = p_id_professor;
    
    IF PROFESSOR > 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Não é possível excluir esse professor";
	ELSE
		DELETE FROM professores WHERE id = p_id_professor;
    END IF;
END $$

DELIMITER ;

DROP PROCEDURE remove_professor;

CALL remove_professor(9)















