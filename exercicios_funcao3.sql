-- CARROS
-- EXERCÍCIO 1: Crie uma função chamada idadeVeiculo que receba o id de um carro e 
-- retorne sua idade em anos, considerando o ano atual e o campo ano.
USE carrosbd;

DELIMITER $$

CREATE FUNCTION idadeVeiculo(p_id_carro INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE ano_carro INT;
    SELECT ano INTO ano_carro FROM carros WHERE id = p_id_carro;
    
    RETURN YEAR(CURDATE()) - ano_carro;
    
END $$

DELIMITER ;

DROP FUNCTION idadeVeiculo;

SELECT idadeVeiculo(15);

-- EXERCÍCIO 2: Crie uma função chamada classificarPrecoCarro que receba o id de um carro e 
-- retorne:
-- Econômico, para valor inferior a R$ 50.000; 
-- Intermediário, para valor entre R$ 50.000 e R$ 100.000; 
-- Alto padrão, para valor superior a R$ 100.000.

DELIMITER $$

CREATE FUNCTION classificarPrecoCarro(p_id_carro INT)
RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
	DECLARE valor_carro INT;
    SELECT valor INTO valor_carro FROM carros WHERE id = p_id_carro;
    
    IF valor_carro < 50000 THEN
		RETURN "Econômico";
	ELSEIF valor_carro >= 50000 AND valor_carro <= 100000 THEN
		RETURN "Intermediário";
    ELSE
		RETURN "Alto padrão";
	END IF;
END $$

DELIMITER ;

SELECT classificarPrecoCarro(4);

-- ACADEMICO
USE bd_academica;

-- EXERCICIO 1: Crie uma função chamada idade_estudante que receba a data de nascimento de 
-- um estudante e retorne a idade.

DELIMITER $$

CREATE FUNCTION idade_estudante(p_id_aluno INT, p_data_nascimento DATE)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE estudante_nascimento DATE;
	SELECT data_nascimento INTO estudante_nascimento FROM estudantes WHERE id = p_id_aluno;
    
    RETURN TIMESTAMPDIFF(YEAR, estudante_nascimento, CURDATE());
END $$

DELIMITER ;

DROP FUNCTION idade_estudante;

SELECT idade_estudante(1, "2001-05-15");

-- -- EXERCICIO 2: Crie uma função chamada total_estudantes_disciplina que receba o ID de 
-- uma disciplina e retorne o número de estudantes matriculados nela.

DELIMITER $$

CREATE FUNCTION total_estudantes_disciplina(p_id_disciplina INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE quantidade INT;

    SELECT COUNT(*) INTO quantidade
    FROM disciplinas d
    INNER JOIN estudantes e
        ON d.id = e.curso_id
    WHERE d.id = p_id_disciplina;

    RETURN quantidade;
END $$

DELIMITER ;

DROP FUNCTION total_estudantes_disciplina;

SELECT total_estudantes_disciplina(1);

-- -- EXERCICIO 3: Crie uma função chamada nota_maxima que retorne a maior nota 
-- registrada na tabela notas

DELIMITER $$

CREATE FUNCTION nota_maxima()
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
	DECLARE nota_maxima DECIMAL(10,2);
	SELECT MAX(nota) INTO nota_maxima FROM notas;
    
    RETURN nota_maxima;
END $$

DELIMITER ;

DROP FUNCTION nota_maxima;

SELECT nota_maxima();

-- -- EXERCICIO 4: Crie uma função chamada disciplina_do_curso que receba o ID de um 
-- curso e retorne o nome da disciplina associada.

DELIMITER $$

CREATE FUNCTION disciplina_do_curso(p_id_curso INT)
RETURNS VARCHAR(255)
READS SQL DATA
BEGIN
	DECLARE curso VARCHAR(30);
    SELECT nome INTO curso FROM disciplinas 
    WHERE id = p_id_curso;
    
    RETURN curso;
END $$

DELIMITER ;

SELECT disciplina_do_curso(4);

-- -- EXERCICIO 5: Crie uma função chamada media_notas_curso que receba o ID de um curso e
-- retorne a média das notas dos estudantes matriculados nesse curso.

DELIMITER $$

CREATE FUNCTION media_notas_curso(p_id_curso INT)
RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
	DECLARE media_nota DECIMAL(10, 2);
    
    SELECT AVG(n.nota) INTO media_nota 
    FROM notas n 
    INNER JOIN matriculas m
    ON n.matricula_id = m.id
    INNER JOIN disciplinas d 
    ON m.disciplina_id = d.id
    INNER JOIN cursos c
    ON d.curso_id = c.id
    WHERE d.id = p_id_curso;
    
    RETURN media_nota;
    
END $$

DELIMITER ;

DROP FUNCTION media_notas_curso;

SELECT media_notas_curso(3);

-- BIBLIOTECA

USE biblioteca;

-- EXERCÍCIO 1: Crie uma função chamada tempoAssociacaoMembro que receba o id_membro e 
-- retorne há quantos anos o membro está cadastrado na biblioteca, considerando o 
-- campo data_adesao.

DELIMITER $$

CREATE FUNCTION tempoAssociacaoMembro(p_id_membro INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE data_adesao_membro  DATE;
    SELECT data_adesao INTO data_adesao_membro FROM membros WHERE id_membro = p_id_membro;
    
    RETURN TIMESTAMPDIFF(YEAR, data_adesao_membro, CURDATE());
    
END $$

DELIMITER ;

DROP FUNCTION tempoAssociacaoMembro;

SELECT tempoAssociacaoMembro(3);

-- EXERCÍCIO 2: Crie uma função chamada quantidadeEmprestimosMembro que receba 
-- o id_membro e retorne a quantidade total de empréstimos realizados por esse membro.

DELIMITER $$

CREATE FUNCTION quantidadeEmprestimosMembro(p_id_membro INT)
RETURNS INT
READS SQL DATA
BEGIN
	DECLARE quantidade INT;
    SELECT COUNT(*) INTO quantidade FROM emprestimos
    WHERE id_membro = p_id_membro;
    
    RETURN quantidade;
END $$

DELIMITER ;

DROP FUNCTION quantidadeEmprestimosMembro;

SELECT quantidadeEmprestimosMembro(3);

-- EXERCÍCIO 3: Crie uma função chamada classificarLivroPorAno que receba o id_livro e retorne:
-- Clássico, se publicado há mais de 30 anos; 
-- Intermediário, se publicado entre 10 e 30 anos; 
-- Recente, se publicado há menos de 10 anos. 

DELIMITER $$

CREATE FUNCTION classificarLivroPorAno(p_id_livro INT)
RETURNS VARCHAR(50)
READS SQL DATA
BEGIN 
	DECLARE ano_livro INT;
    
    SELECT ano_publicacao INTO ano_livro FROM livros 
    WHERE id_livro = p_id_livro;
    
    IF YEAR(CURDATE()) - ano_livro > 30 THEN
        RETURN "Clássico";
    ELSEIF YEAR(CURDATE()) - ano_livro >= 10 THEN 
        RETURN "Intermediário";
    ELSE
        RETURN "Recente";
    END IF;
    
END $$

DELIMITER ;

DROP FUNCTION classificarLivroPorAno;

SELECT classificarLivroPorAno(4)






