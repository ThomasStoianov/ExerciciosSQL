USE biblioteca;

-- PROCEDURE
-- 1. Crie um stored procedure que insira um novo autor na tabela Autores

DELIMITER $$

CREATE PROCEDURE inserir_autores(
IN id_autorp INT,
IN nomep VARCHAR(255),
data_nascimentop DATE)
BEGIN

   INSERT INTO autores (id_autor, nome, data_nascimento) VALUES (id_autorp, nomep, data_nascimentop);

END $$

DELIMITER ;

call inserir_autores(12, 'Dieguinho', '1997-06-26');

-- Crie uma stored procedure para atualizar a data de devolução de um empréstimo já registrado.
DELIMITER $$
CREATE PROCEDURE AtualizarData(
IN p_id INT,
IN p_novaData DATE
)
BEGIN

UPDATE emprestimos SET data_devolucao = p_novaData WHERE id_emprestimo = p_id;

END $$

DELIMITER ;

CALL AtualizarData(2, '2026-09-05');














