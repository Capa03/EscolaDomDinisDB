CREATE DATABASE EscolaDomDinis

-- Criação do esquema
CREATE SCHEMA Escola 

-- Criação de um login
CREATE LOGIN DocenteLogin
WITH PASSWORD = 'estig';

-- Criação de um utilizador associado ao login
CREATE USER Docente
FOR LOGIN DocenteLogin;

-- Concessão de permissões ao utilizador
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Escola TO Docente;


-- Criação de um login
CREATE LOGIN AlunoLogin
WITH PASSWORD = 'estig';

-- Criação de um utilizador associado ao login
CREATE USER Aluno
FOR LOGIN AlunoLogin;

-- Concessão de permissões ao utilizador
GRANT SELECT ON SCHEMA::Escola TO Aluno;


-- Criação dos filegroups
ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP1;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP2;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP3;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP4;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP5;

ALTER DATABASE EscolaDomDinis
ADD FILEGROUP FILEGROUP6;

-- Adição de ficheiros às filegroups
ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'Primario1', FILENAME = 'E:\FILEGROUP1.ndf')
TO FILEGROUP FILEGROUP1;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'FILEGROUP2', FILENAME = 'F:\FILEGROUP2.ndf')
TO FILEGROUP FILEGROUP2;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'FILEGROUP3', FILENAME = 'G:\FILEGROUP3.ndf')
TO FILEGROUP FILEGROUP3;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'FILEGROUP4', FILENAME = 'H:\FILEGROUP4.ndf')
TO FILEGROUP FILEGROUP4;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'FILEGROUP5', FILENAME = 'I:\FILEGROUP5.ndf')
TO FILEGROUP FILEGROUP5;

ALTER DATABASE EscolaDomDinis
ADD FILE
    (NAME = 'FILEGROUP6', FILENAME = 'J:\FILEGROUP6.ndf')
TO FILEGROUP FILEGROUP6;

-- Criar Tabelas

USE EscolaDomDinis;
go 

CREATE TABLE Escola.Curso (
 idCurso INT PRIMARY KEY IDENTITY(1,1),
 nome VARCHAR(100),
) ON FILEGROUP1;

CREATE TABLE Escola.Turma (
 idTurma INT PRIMARY KEY IDENTITY(1,1),
 idCurso INT,
 FOREIGN KEY (idCurso) REFERENCES Escola.Curso(idCurso)
)ON FILEGROUP2;

CREATE TABLE Escola.Disciplina (
    idDisciplina INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) ,
    idCurso INT FOREIGN KEY REFERENCES Escola.Curso(idCurso),
)ON FILEGROUP3;


CREATE TABLE Escola.Aluno (
 idAluno INT PRIMARY KEY IDENTITY(1,1),
 idTurma INT,
 nome VARCHAR(100),
 email VARCHAR(100),
 contacto VARCHAR(20)
 FOREIGN KEY (idTurma) REFERENCES Escola.Turma(idTurma)
)ON FILEGROUP4;

CREATE TABLE Escola.Docente (
 idDocente INT PRIMARY KEY IDENTITY(1,1),
 nome VARCHAR(100),
 morada VARCHAR(100),
)ON FILEGROUP5;


CREATE TABLE Escola.Questionario (
 idQuestionario INT PRIMARY KEY IDENTITY(1,1),
 pergunta VARCHAR(255),
 idDisciplina INT,
 idDocente INT,
 FOREIGN KEY (idDisciplina) REFERENCES Escola.Disciplina(idDisciplina),
 FOREIGN KEY (idDocente) REFERENCES Escola.Docente(idDocente)
)ON FILEGROUP6;

CREATE TABLE Escola.Resposta (
 idResposta INT PRIMARY KEY IDENTITY(1,1),
 texto VARCHAR(255),
 idAluno INT,
 idQuestionario INT,
 FOREIGN KEY (idAluno) REFERENCES Escola.Aluno(idAluno),
 FOREIGN KEY (idQuestionario) REFERENCES Escola.Questionario(idQuestionario)
)ON FILEGROUP1;

CREATE TABLE Escola.Avaliacao (
 idAvaliacao INT PRIMARY KEY IDENTITY(1,1),
 idAluno INT,
 idDisciplina INT,
 nota INT,
 FOREIGN KEY (idAluno) REFERENCES Escola.Aluno(idAluno),
 FOREIGN KEY (idDisciplina) REFERENCES Escola.Disciplina(idDisciplina)
)ON FILEGROUP2;


-- Ver tabelas nos filegroups

USE EscolaDomDinis;
GO

SELECT 
    t.name AS TableName,
    i.name AS IndexName,
    fg.name AS FilegroupName
FROM sys.tables t
INNER JOIN sys.indexes i ON t.object_id = i.object_id
INNER JOIN sys.filegroups fg ON i.data_space_id = fg.data_space_id;



-- Switch to the Docente user
EXECUTE AS USER = 'Docente';

-- Your SQL statements here, executed as Docente

-- Switch back to the original user (probably dbo or another admin user)
REVERT;

-- Switch to the Aluno user
EXECUTE AS USER = 'Aluno';

-- Your SQL statements here, executed as Aluno

-- Switch back to the original user (probably dbo or another admin user)
REVERT;





