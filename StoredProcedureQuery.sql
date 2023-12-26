

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
 VALUES (@idAluno, @idDisciplina, @Nota);
END;

CREATE PROCEDURE Escola.usp_MudarAlunoDeTurma
    @idAluno INT,
    @novoIdTurma INT
AS
BEGIN
    -- Verificar se a nova turma existe
    IF NOT EXISTS (SELECT 1 FROM Escola.Turma WHERE idTurma = @novoIdTurma)
    BEGIN
        PRINT 'Erro: A Turma especificada não existe!';
        RETURN;
    END

    -- Verificar se o aluno existe
    IF NOT EXISTS (SELECT 1 FROM Escola.Aluno WHERE idAluno = @idAluno)
    BEGIN
        PRINT 'Erro: O Aluno especificado não existe!';
        RETURN;
    END

    -- Atualizar a turma do aluno
    UPDATE Escola.Aluno
    SET IdTurma = @novoIdTurma
    WHERE idAluno = @idAluno;

    PRINT 'Aluno movido para a nova turma com sucesso.';
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
