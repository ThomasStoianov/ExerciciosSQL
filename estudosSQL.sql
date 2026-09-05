CREATE DATABASE escola;
USE escola;

CREATE TABLE alunos (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(100),
    idade INT
);

INSERT INTO alunos VALUES
(1, 'João', 18),
(2, 'Maria', 19),
(3, 'Pedro', 20),
(4, 'Ana', 18),
(5, 'Carlos', 21);

CREATE TABLE cursos (
    id_curso INT PRIMARY KEY,
    nome_curso VARCHAR(100)
);

INSERT INTO cursos VALUES
(1, 'Engenharia de Software'),
(2, 'Ciência de Dados'),
(3, 'Análise e Desenvolvimento de Sistemas');

CREATE TABLE matriculas (
    id_matricula INT PRIMARY KEY,
    id_aluno INT,
    id_curso INT,
    nota DECIMAL(4,2),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

INSERT INTO matriculas VALUES
(1, 1, 1, 8.5),
(2, 1, 2, 7.0),
(3, 2, 1, 9.0),
(4, 3, 3, 6.5),
(5, 4, 2, 8.0),
(6, 5, 1, 7.5);









