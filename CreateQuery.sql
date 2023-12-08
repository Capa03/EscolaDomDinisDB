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

CREATE TABLE Curso (
    idCurso INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) ,
    descricao VARCHAR(50),
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
);

CREATE TABLE Nota (
    idNota INT IDENTITY(1,1) PRIMARY KEY,
    idAluno INT FOREIGN KEY REFERENCES Aluno(idAluno),
    idDisciplina INT FOREIGN KEY REFERENCES Disciplina(idDisciplina),
    nota INT,
);
