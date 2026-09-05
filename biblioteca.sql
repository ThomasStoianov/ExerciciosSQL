-- 0. Criação e seleção do banco de dados
DROP DATABASE IF EXISTS Biblioteca;
CREATE DATABASE Biblioteca;
USE Biblioteca;
-- 1. Criação da tabela Autores
CREATE TABLE Autores (
 id_autor INT PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 data_nascimento DATE
);
-- 2. Criação da tabela Livros
CREATE TABLE Livros (
 id_livro INT PRIMARY KEY,
 titulo VARCHAR(150) NOT NULL,
 ano_publicacao INT,
 id_autor INT,
 FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
);
-- 3. Criação da tabela Membros
CREATE TABLE Membros (
 id_membro INT PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 data_adesao DATE NOT NULL
);
-- 4. Criação da tabela Emprestimos
CREATE TABLE Emprestimos (
 id_emprestimo INT PRIMARY KEY,
 id_membro INT,
 id_livro INT,
 data_emprestimo DATE NOT NULL,
 data_devolucao DATE,
 FOREIGN KEY (id_membro) REFERENCES Membros(id_membro),
 FOREIGN KEY (id_livro) REFERENCES Livros(id_livro)
);
-- 1. Inserindo 5 Autores
INSERT INTO Autores (id_autor, nome, data_nascimento) VALUES
(1, 'Machado de Assis', '1839-06-21'),
(2, 'Clarice Lispector', '1920-12-10'),
(3, 'George Orwell', '1903-06-25'),
(4, 'J.K. Rowling', '1965-07-31'),
(5, 'J.R.R. Tolkien', '1892-01-03');
-- 2. Inserindo 5 Livros
INSERT INTO Livros (id_livro, titulo, ano_publicacao, id_autor) VALUES
(1, 'Dom Casmurro', 1899, 1),
(2, 'A Hora da Estrela', 1977, 2),
(3, '1984', 1949, 3),
(4, 'A Revolução dos Bichos', 1945, 3),
(5, 'O Hobbit', 1937, 5);
-- Nota: O livro "A Revolução dos Bichos" (ID 4) não será emprestado para
-- podermos testar a consulta de "livros não emprestados".
-- 3. Inserindo 5 Membros
INSERT INTO Membros (id_membro, nome, data_adesao) VALUES
(1, 'Ana Silva', '2023-01-15'),
(2, 'Carlos Oliveira', '2023-03-22'),
(3, 'Mariana Souza', '2023-05-10'),
(4, 'Pedro Santos', '2024-02-01'),
(5, 'Fernanda Lima', '2024-06-12');
-- 4. Inserindo 5 Empréstimos
INSERT INTO Emprestimos (id_emprestimo, id_membro, id_livro,
data_emprestimo, data_devolucao) VALUES
(1, 1, 1, '2024-07-01', '2024-07-15'),
(2, 1, 2, '2024-07-05', '2024-07-18'), 
-- Membro 1 fez >1 empréstimo e devolução em 18-07-2024
(3, 2, 3, '2024-07-10', '2024-07-25'),
(4, 3, 5, '2024-07-12', '2024-07-26'),
(5, 4, 1, '2024-08-01', NULL); -- Empréstimo em andamento (sem devolução ainda)

-- Liste os autores que possuem livros com ano de publicação maior que a
-- média de anos de publicação de todos os livros cadastrados.
SELECT 
    Autores.nome AS autor,
    Livros.titulo,
    Livros.ano_publicacao
FROM Autores
INNER JOIN Livros
    ON Autores.id_autor = Livros.id_autor
WHERE Livros.ano_publicacao > (
    SELECT AVG(ano_publicacao)
    FROM Livros
);

-- Liste os livros que foram emprestados ao menos uma vez.
SELECT DISTINCT
	Livros.titulo AS livro
FROM Emprestimos
INNER JOIN Livros
	ON Emprestimos.id_livro = Livros.id_livro;

-- Consulte os livros que ainda não foram emprestados.
SELECT 
    Livros.titulo AS livro
FROM Livros
LEFT JOIN Emprestimos
    ON Livros.id_livro = Emprestimos.id_livro
WHERE Emprestimos.id_livro IS NULL;


INSERT INTO Autores (id_autor, nome, data_nascimento)
VALUES (10, 'João da Silva', '2010-05-15');

INSERT INTO Autores (id_autor, nome) VALUES (12, "Machado de assis");

INSERT INTO emprestimos (id_membro, id_livro, data_emprestimo)
VALUES (1, 3, '2026-08-27');

INSERT INTO emprestimos (id_membro, id_livro, data_emprestimo)
VALUES (1, 4, '2026-08-27');

SELECT * 
FROM emprestimos
WHERE id_emprestimo = 3;

UPDATE emprestimos
SET data_devolucao = '2024-07-25'
WHERE id_emprestimo = 3;

INSERT INTO membros (id_membro, nome)
VALUES (6, "Diogo Brito");

-- Veterinaria



