CREATE DATABASE EscolaDomDinis;
go
USE EscolaDomDinis;
go 

CREATE TABLE Aluno (
 Numero_aluno INT PRIMARY KEY,
 Numero_turma INT,
 Nome_aluno VARCHAR(100),
 Email VARCHAR(100),
 Contato VARCHAR(20)
);

CREATE TABLE Curso (
 Numero_curso INT PRIMARY KEY,
 Nome VARCHAR(100),
 Numero_edicao INT
);

CREATE TABLE Turma (
 Numero_turma INT PRIMARY KEY,
 Numero_curso INT,
 FOREIGN KEY (Numero_curso) REFERENCES Curso(Numero_curso)
);

CREATE TABLE Disciplina (
 Numero_disciplina INT PRIMARY KEY,
 Nome_disciplina VARCHAR(100),
 Numero_curso INT,
 FOREIGN KEY (Numero_curso) REFERENCES Curso(Numero_curso)
);

CREATE TABLE Docente (
 Numero_docente INT PRIMARY KEY,
 Nome_docente VARCHAR(100),
 Endereço VARCHAR(100)
);


CREATE TABLE Questionario (
 Numero_questionario INT PRIMARY KEY,
 Numero_pergunta INT,
 Perguntas VARCHAR(255),
 Numero_disciplina INT,
 Numero_docente INT,
 FOREIGN KEY (Numero_disciplina) REFERENCES Disciplina(Numero_disciplina),
 FOREIGN KEY (Numero_docente) REFERENCES Docente(Numero_docente)
);

CREATE TABLE Resposta (
 Numero_resposta INT PRIMARY KEY,
 Texto VARCHAR(255),
 Numero_aluno INT,
 Numero_questionario INT,
 FOREIGN KEY (Numero_aluno) REFERENCES Aluno(Numero_aluno),
 FOREIGN KEY (Numero_questionario) REFERENCES Questionario(Numero_questionario)
);

CREATE TABLE Avaliacao (
 Nummero_avaliacao INT PRIMARY KEY,
 Numero_aluno INT,
 Numero_disciplina INT,
 Nota_avaliacao INT,
 FOREIGN KEY (Numero_aluno) REFERENCES Aluno(Numero_aluno),
 FOREIGN KEY (Numero_disciplina) REFERENCES Disciplina(Numero_disciplina)
);
