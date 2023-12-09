CREATE DATABASE EscolaDomDinis;
go USE EscolaDomDinis;
go;

-- Path: CreateTables.sql

CREATE TABLE Aluno (
    idAluno INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) ,
    dataNascimento DATETIME,
    morada VARCHAR(50),
    contacto VARCHAR(9),
    email VARCHAR(50),
);

CREATE TABLE Professor (
    idProfessor INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) ,
    dataNascimento DATETIME,
    morada VARCHAR(50),
    contacto VARCHAR(9),
    email VARCHAR(50),
);
USE EscolaDomDinis;
go 

CREATE TABLE Curso (
    idCurso INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) ,
    descricao VARCHAR(50),
 idCurso INT PRIMARY KEY IDENTITY(1,1),
 nome VARCHAR(100),
 edicao INT
);

CREATE TABLE Turma (
 idTurma INT PRIMARY KEY IDENTITY(1,1),
 idCurso INT,
 FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Disciplina (
    idDisciplina INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) ,
    idProfessor INT FOREIGN KEY REFERENCES Professor(idProfessor),
);

CREATE TABLE Inscricao (
    idInscricao INT IDENTITY(1,1) PRIMARY KEY,
    idAluno INT FOREIGN KEY REFERENCES Aluno(idAluno),
    idCurso INT FOREIGN KEY REFERENCES Curso(idCurso),
    dataInscricao DATETIME ,
 idDisciplina INT PRIMARY KEY IDENTITY(1,1),
 nome VARCHAR(100),
 idCurso INT,
 FOREIGN KEY (idCurso) REFERENCES Curso(idCurso)
);

CREATE TABLE Aluno (
 idAluno INT PRIMARY KEY IDENTITY(1,1),
 idTurma INT,
 nome VARCHAR(100),
 email VARCHAR(100),
 contacto VARCHAR(20)
 FOREIGN KEY (idTurma) REFERENCES Turma(idTurma)
);


CREATE TABLE Questionario (
 idQuestionario INT PRIMARY KEY IDENTITY(1,1),
 pergunta VARCHAR(255),
 idDisciplina INT,
 idDocente INT,
 FOREIGN KEY (idDisciplina) REFERENCES Disciplina(idDisciplina),
 FOREIGN KEY (idDocente) REFERENCES Docente(idDocente)
);

CREATE TABLE Resposta (
 idResposta INT PRIMARY KEY IDENTITY(1,1),
 texto VARCHAR(255),
 idAluno INT,
 idQuestionario INT,
 FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno),
 FOREIGN KEY (idQuestionario) REFERENCES Questionario(idQuestionario)
);

CREATE TABLE Nota (
    idNota INT IDENTITY(1,1) PRIMARY KEY,
    idAluno INT FOREIGN KEY REFERENCES Aluno(idAluno),
    idDisciplina INT FOREIGN KEY REFERENCES Disciplina(idDisciplina),
    nota INT,
CREATE TABLE Avaliacao (
 idAvaliacao INT PRIMARY KEY IDENTITY(1,1),
 idAluno INT,
 idDisciplina INT,
 nota INT,
 FOREIGN KEY (idAluno) REFERENCES Aluno(idAluno),
 FOREIGN KEY (idDisciplina) REFERENCES Disciplina(idDisciplina)
);
