USE veterinaria;

-- EXERCICIO 1. Crie uma stored procedure que adicione um novo veterinário na tabela Veterinarios.
DELIMITER $$
CREATE PROCEDURE AdicionarVeterinario(
IN p_id_veterinario INT,
IN p_nome Varchar(255),
IN p_especialidade VARCHAR(255),
IN p_telefone VARCHAR(255)
)
BEGIN

INSERT INTO veterinarios (id_veterinario, nome, especialidade, telefone) 
VALUES (p_id_veterinario, p_nome, p_especialidade, p_telefone);

END $$

DELIMITER ;

CALL AdicionarVeterinario(5, "Thomás", "Cardiologia", "53469-3466");	

-- EXERCICIO 2. Crie uma stored procedure para atualizar os dados de um cliente, como nome, endereço e telefone.
DELIMITER $$

CREATE PROCEDURE AtualizarCliente(
IN p_id_cliente INT,
IN p_nome Varchar(255),
IN p_endereco Varchar(255),
IN p_telefone VARCHAR(255)
)
BEGIN

UPDATE clientes
SET 
    nome = p_nome,
    endereco = p_endereco,
    telefone = p_telefone
WHERE id_cliente = p_id_cliente;

END $$

DELIMITER ;

CALL AtualizarCliente(3, "Lucas", "Avenida Paulista", "63496-2646")

-- EXERCICIO 3. Crie uma stored procedure que registre um novo atendimento de um pet, verificando 
-- se o veterinário e o pet existem.
DELIMITER $$

CREATE PROCEDURE NovoAtendimento(
IN p_id_atendimento INT,
IN p_id_pet INT,
IN p_id_veterinario INT,
IN p_data_atendimento DATE,
IN p_descricao Varchar(255)
)
BEGIN

DECLARE existe_pet INT;
DECLARE existe_veterinario INT;

SELECT COUNT(*) INTO existe_pet FROM pets WHERE id_pet = p_id_pet;
SELECT COUNT(*) INTO existe_veterinario FROM veterinarios WHERE id_veterinario = p_id_veterinario;

IF existe_pet > 0 AND existe_veterinario > 0 THEN
	INSERT INTO atendimentos (id_atendimento, id_pet, id_veterinario, data_atendimento, descricao)
    VALUES (p_id_atendimento, p_id_pet, p_id_veterinario, p_data_atendimento, p_descricao);
ELSE
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Veterinário ou Pet não existem';

END IF;

END $$

DELIMITER ;

CALL NovoAtendimento(6, 135, 4, "2026-09-05", "Consulta cotidiana");

-- EXERCÍCIO 4. Crie uma stored procedure que adicione um novo pet na tabela Pets, verificando
-- antes se o cliente informado existe.
DELIMITER $$

CREATE PROCEDURE AdicionarPet(
IN p_id_pet INT,
IN p_nome VARCHAR(255),
IN p_tipo VARCHAR(255),
IN p_raca VARCHAR(255),
IN p_data_nascimento DATE,
IN p_id_cliente INT,
IN p_idade INT
)
BEGIN

DECLARE cliente INT;
SELECT COUNT(*) INTO cliente FROM clientes WHERE id_cliente = p_id_cliente;

IF cliente > 0 THEN
	INSERT INTO pets (id_pet, nome, tipo, raca, data_nascimento, id_cliente, idade)
    VALUES (p_id_pet, p_nome, p_tipo, p_raca, p_data_nascimento, p_id_cliente, p_idade);
ELSE
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Cliente não existe';

END IF;

END $$

DELIMITER ;

CALL AdicionarPet(13, "Wayne", "cachorro", "bulldog", "2025-05-09", 5, 1)

-- EXERCÍCIO 5. Crie uma stored procedure que atualize o telefone de um veterinário a partir do seu código.
DELIMITER $$

CREATE PROCEDURE AtualizarTelefone(
IN p_id_veterinario INT,
IN p_telefone VARCHAR(255)
)
BEGIN

UPDATE veterinarios SET telefone = p_telefone WHERE id_veterinario = p_id_veterinario;

END $$

DELIMITER ;

CALL AtualizarTelefone(5, "53255-1364")



