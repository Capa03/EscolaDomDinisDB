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



-- Criar Stored Procedures



CREATE PROCEDURE SPInsertAluno
    @Nome VARCHAR(100),
    @Contacto VARCHAR(20),
    @Email VARCHAR(100),
    @IdTurma INT
AS
BEGIN
    IF EXISTS (SELECT 1
    FROM Escola.Turma
    WHERE IdTurma = @IdTurma)
    BEGIN
        INSERT INTO Escola.Aluno
            (Nome, Contacto, Email, IdTurma)
        VALUES
            (@Nome, @Contacto, @Email, @IdTurma);
        PRINT 'Aluno inserido com sucesso!';
    END
    ELSE
    BEGIN
        PRINT 'Erro: A Turma especificada não existe!';
    END
END;

EXEC SPInsertAluno 'João', '912345678', 'Teste@TESTE.com', 1;


CREATE PROCEDURE SPInsertCurso
    @nome VARCHAR(100)
AS
BEGIN
    -- Inserindo o novo curso na tabela Curso
    INSERT INTO Escola.Curso (nome)
    VALUES (@nome);

    -- Opcional: Você pode querer retornar o ID do curso recém-criado
    DECLARE @idCurso INT;
    SELECT @idCurso = SCOPE_IDENTITY();
    PRINT 'Curso inserido com sucesso. ID do Curso: ' + CAST(@idCurso AS VARCHAR);
END;

---------------------------------------
EXEC SPInsertCurso 'CursoTeste';

CREATE PROCEDURE SPInsertDocente
    @nome VARCHAR(100),
    @morada VARCHAR(100)
AS
BEGIN
    -- Inserindo o novo docente na tabela Docente
    INSERT INTO Escola.Docente (nome, morada)
    VALUES (@nome, @morada);

    -- Opcional: Você pode querer retornar o ID do docente recém-criado
    DECLARE @idDocente INT;
    SELECT @idDocente = SCOPE_IDENTITY();
    PRINT 'Docente inserido com sucesso. ID do Docente: ' + CAST(@idDocente AS VARCHAR);
END;

---------------------------
EXEC SPInsertDocente 'DocenteTeste', 'MoradaTeste';

CREATE PROCEDURE SPInsertResposta
    @texto VARCHAR(255),
    @idAluno INT,
    @idQuestionario INT
AS
BEGIN
    -- Verificar se o aluno e o questionário existem
    IF NOT EXISTS (SELECT 1 FROM Escola.Aluno WHERE idAluno = @idAluno)
    BEGIN
        PRINT 'Erro: O Aluno especificado não existe!';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Escola.Questionario WHERE idQuestionario = @idQuestionario)
    BEGIN
        PRINT 'Erro: O Questionário especificado não existe!';
        RETURN;
    END

    -- Inserindo a nova resposta na tabela Resposta
    INSERT INTO Escola.Resposta (texto, idAluno, idQuestionario)
    VALUES (@texto, @idAluno, @idQuestionario);

    -- Opcional: Retornar o ID da resposta recém-criada
    DECLARE @idResposta INT;
    SELECT @idResposta = SCOPE_IDENTITY();
    PRINT 'Resposta inserida com sucesso. ID da Resposta: ' + CAST(@idResposta AS VARCHAR);
END;

---------------------------------------
EXEC SPInsertResposta 'RespostaTeste', 1, 1;

CREATE PROCEDURE SPInsertTurma
    @idCurso INT
AS
BEGIN
    IF EXISTS (SELECT 1
    FROM Escola.Curso
    WHERE idCurso = @idCurso)
    BEGIN
        INSERT INTO Escola.Turma
            (idCurso)
        VALUES
            (@idCurso);
        PRINT 'Turma inserido com sucesso!';
    END
    ELSE
    BEGIN
        PRINT 'Erro: A Curso especificado não existe!';
    END
END;

---------------------------------------
EXEC SPInsertTurma 1;


CREATE PROCEDURE SPInsertDisciplina
    @Nome VARCHAR(50),
    @idCurso INT
AS
BEGIN
    IF EXISTS (SELECT 1
    FROM Escola.Curso
    WHERE idCurso = @idCurso)
    BEGIN
        INSERT INTO Escola.Disciplina
            (Nome, idCurso)
        VALUES
            (@Nome, @idCurso);
        PRINT 'Disciplina inserida com sucesso!';
    END
    ELSE
    BEGIN
        PRINT 'Erro: A Curso especificado não existe!';
    END
END;

---------------------------------------
EXEC SPInsertDisciplina 'DisciplinaTeste', 1;


CREATE PROCEDURE SPQuestionario
    @Pergunta VARCHAR(255),
    @idDisciplina INT,
    @idDocente INT
AS
BEGIN
    IF EXISTS (SELECT 1
    FROM Escola.Disciplina
    WHERE idDisciplina = @idDisciplina)
    BEGIN
        IF EXISTS (SELECT 1
        FROM Escola.Docente
        WHERE idDocente = @idDocente)
        BEGIN
            INSERT INTO Escola.Questionario
                (Pergunta, idDisciplina, idDocente)
            VALUES
                (@Pergunta, @idDisciplina, @idDocente);
            PRINT 'Questionario inserido com sucesso!';
        END
        ELSE
        BEGIN
            PRINT 'Erro: O Docente especificado não existe!';
        END
    END
    ELSE
    BEGIN
        PRINT 'Erro: A Disciplina especificada não existe!';
    END
END;

---------------------------------------
EXEC SPQuestionario 'QuestionarioTeste', 1, 1;

CREATE PROCEDURE SPAvaliacao
    @idAluno INT,
    @idDisciplina INT,
    @Nota INT
AS
BEGIN
    IF EXISTS (SELECT 1
    FROM Escola.Aluno
    WHERE idAluno = @idAluno)
    BEGIN
        IF EXISTS (SELECT 1
        FROM Escola.Disciplina
        WHERE idDisciplina = @idDisciplina)
        BEGIN
            IF @Nota >= 0 AND @Nota <= 20
            BEGIN
                INSERT INTO Escola.Avaliacao
                    (idAluno, idDisciplina, Nota)
                VALUES
                    (@idAluno, @idDisciplina, @Nota);
                PRINT 'Avaliacao inserida com sucesso!';
            END
            ELSE
            BEGIN
                PRINT 'Erro: A nota deve estar no intervalo de 0 a 20!';
            END
        END
        ELSE
        BEGIN
            PRINT 'Erro: A Disciplina especificada não existe!';
        END
    END
    ELSE
    BEGIN
        PRINT 'Erro: O Aluno especificado não existe!';
    END
END;


---------------------------------------
EXEC SPAvaliacao 1, 1, 20;


CREATE TRIGGER tr_CheckNota
ON Avaliacao
AFTER INSERT
AS
BEGIN
    DECLARE @Nota INT;

    SELECT @Nota = nota
    FROM inserted;

    IF @Nota < 0 OR @Nota > 20
    BEGIN
        PRINT 'Erro: A nota deve estar no intervalo de 0 a 20!';
        ROLLBACK;
    -- Desfaz a transação devido a um erro
    END
    ELSE
    BEGIN
        PRINT 'Avaliação inserida com sucesso!';
    END
END;




