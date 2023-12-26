

CREATE PROCEDURE usp_InsertAluno
    @Nome VARCHAR(100),
    @Contacto VARCHAR(20),
    @Email VARCHAR(100),
    @IdTurma INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Turma WHERE IdTurma = @IdTurma)
    BEGIN
        INSERT INTO Aluno (Nome, Contacto, Email, IdTurma)
        VALUES (@Nome, @Contacto, @Email, @IdTurma);
        PRINT 'Aluno inserido com sucesso!';
    END
    ELSE
    BEGIN
        PRINT 'Erro: A Turma especificada não existe!';
    END
END;

CREATE PROCEDURE Escola.usp_InsertCurso
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

CREATE PROCEDURE Escola.usp_InsertTurma
    @idCurso INT
AS
BEGIN
    -- Verificar se o curso existe
    IF NOT EXISTS (SELECT 1 FROM Escola.Curso WHERE idCurso = @idCurso)
    BEGIN
        PRINT 'Erro: O Curso especificado não existe!';
        RETURN;
    END

    -- Inserindo a nova turma
    INSERT INTO Escola.Turma (idCurso)
    VALUES (@idCurso);

    -- Opcional: Retornar o ID da turma recém-criada
    DECLARE @idTurma INT;
    SELECT @idTurma = SCOPE_IDENTITY();
    PRINT 'Turma inserida com sucesso. ID da Turma: ' + CAST(@idTurma AS VARCHAR);
END;

CREATE PROCEDURE Escola.usp_InsertDocente
    @nome VARCHAR(100),
    @morada VARCHAR(100)
AS
BEGIN
    -- Inserindo o novo docente na tabela Docente
    INSERT INTO Escola.Docente (nome, morada)
    VALUES (@nome, @morada);

    -- Opcional: Retornar o ID do docente recém-criado
    DECLARE @idDocente INT;
    SELECT @idDocente = SCOPE_IDENTITY();
    PRINT 'Docente inserido com sucesso. ID do Docente: ' + CAST(@idDocente AS VARCHAR);
END;

CREATE PROCEDURE Escola.usp_InsertResposta
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
        ROLLBACK; -- Desfaz a transação devido a um erro
    END
    ELSE
    BEGIN
        PRINT 'Avaliação inserida com sucesso!';
    END
END;
