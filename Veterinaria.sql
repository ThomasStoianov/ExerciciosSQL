DROP DATABASE IF EXISTS Veterinaria;
CREATE DATABASE Veterinaria;
USE Veterinaria;

CREATE TABLE Veterinarios 
( id_veterinario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255),
especialidade VARCHAR(255),
telefone VARCHAR(255)
);

CREATE TABLE Clientes 
( id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255),
endereco VARCHAR(255),
telefone VARCHAR(255)

);

CREATE TABLE Pets 
( id_pet INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(255),
tipo VARCHAR(255),
raca VARCHAR(255),
data_nascimento DATE,
id_cliente INT,

FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Atendimentos 
( id_atendimento INT PRIMARY KEY AUTO_INCREMENT,
id_pet INT,
id_veterinario INT,
data_atendimento DATE,
descricao VARCHAR(255),

FOREIGN KEY (id_pet) REFERENCES Pets(id_pet),
FOREIGN KEY (id_veterinario) REFERENCES Veterinarios(id_veterinario)
);

-- Inserir dados 

-- VETERINÁRIOS
INSERT INTO Veterinarios (nome, especialidade, telefone) VALUES ("Gabriel", "Ortopedia", "11 85439-2345" );
INSERT INTO Veterinarios (nome, especialidade, telefone) VALUES ("MIguel", "Cardiologia", "11 85439-2345" );
INSERT INTO Veterinarios (nome, especialidade, telefone) VALUES ("Ronaldo", "Neurologia", "11 85439-2345" );
INSERT INTO Veterinarios (nome, especialidade, telefone) VALUES ("Gustavo", "Clínica de Pequenos Animais", "11 85439-2345" );
INSERT INTO Veterinarios (nome, especialidade, telefone) VALUES ("Bruno", "Medicina de Grandes Animais", "11 85439-2345" );

-- Clientes
INSERT INTO Clientes (nome, endereco, telefone) VALUES ("Arthur", "São Paulo", "11 23589-5231");
INSERT INTO Clientes (nome, endereco, telefone) VALUES ("Thomás", "São Paulo", "11 16849-8432");
INSERT INTO Clientes (nome, endereco, telefone) VALUES ("Felipe", "São Bernardo do Campo", "11 19681-1624");
INSERT INTO Clientes (nome, endereco, telefone) VALUES ("João", "Santo André", "11 35215-1351");
INSERT INTO Clientes (nome, endereco, telefone) VALUES ("Fábio", "São Caetano do Sul", "11 31361-4376");

-- Pets
INSERT INTO Pets (nome, tipo, raca, data_nascimento, id_cliente) VALUES ("BOB", "Cachorro", "Shih-tzu","024-08-11",1);
INSERT INTO Pets (nome, tipo, raca, data_nascimento, id_cliente) VALUES ("Bartolomeu", "Gato", "Persa","2023-03-20",2);
INSERT INTO Pets (nome, tipo, raca, data_nascimento, id_cliente) VALUES ("Derek", "Cachorro", "Rottweiler","2022-09-05",3);
INSERT INTO Pets (nome, tipo, raca, data_nascimento, id_cliente) VALUES ("Thor", "Gato", "Bengal","2025-06-04",4);
INSERT INTO Pets (nome, tipo, raca, data_nascimento, id_cliente) VALUES ("Max","Cachorro", "Bulldog","2020-07-09",5);

-- Atendimentos
INSERT INTO Atendimentos (id_atendimento, id_pet, id_veterinario, data_atendimento, descricao) VALUES (1, 1, 1, '2026-08-01', 'Consulta de rotina');
INSERT INTO Atendimentos (id_atendimento, id_pet, id_veterinario, data_atendimento, descricao) VALUES (2, 2, 2, '2026-08-02', 'Vacinação');
INSERT INTO Atendimentos (id_atendimento, id_pet, id_veterinario, data_atendimento, descricao) VALUES (3, 3, 3, '2026-08-03', 'Problemas digestivos');
INSERT INTO Atendimentos (id_atendimento, id_pet, id_veterinario, data_atendimento, descricao) VALUES (4, 4, 1, '2026-08-04', 'Avaliação de saúde');
INSERT INTO Atendimentos (id_atendimento, id_pet, id_veterinario, data_atendimento, descricao) VALUES (5, 5, 2, '2026-08-05', 'Tratamento de alergia');

-- SELECT
-- Veterinários
SELECT * FROM VETERINARIOS WHERE nome = "Gabriel";	
SELECT * FROM VETERINARIOS WHERE especialidade = "Cardiologia";
SELECT * FROM VETERINARIOS WHERE especialidade = "Neurologia";

-- Clientes
SELECT * FROM CLIENTES WHERE nome = "Thomás";
SELECT * FROM CLIENTES WHERE endereco = "Santo André";
SELECT * FROM CLIENTES WHERE nome = "Felipe";

-- Pets
SELECT * FROM PETS WHERE nome = "BOB";
SELECT * FROM PETS WHERE raca = "gato";
SELECT * FROM PETS WHERE raca = "Rottweiler";

-- Atendimentos
SELECT * FROM ATENDIMENTOS WHERE id_pet = 1;
SELECT * FROM ATENDIMENTOS WHERE id_veterinario = 2;
SELECT * FROM ATENDIMENTOS WHERE id_pet = 5;

DELETE FROM veterinarios WHERE id_veterinario = 5

