

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
