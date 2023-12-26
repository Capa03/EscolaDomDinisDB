

CREATE PROCEDURE InsertAluno
    @Nome VARCHAR(100),
    @Contacto VARCHAR(20),
    @Email VARCHAR(100),
    @IdTurma INT
AS
BEGIN
    IF EXISTS (SELECT 1
    FROM Turma
    WHERE IdTurma = @IdTurma)
    BEGIN
        INSERT INTO Aluno
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


CREATE PROCEDURE SPInsertTurma
    @idCurso INT,
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
