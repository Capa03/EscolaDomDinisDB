-- Criação do trigger
CREATE TRIGGER Escola.trg_AfterInsertAluno
ON Escola.Aluno
AFTER INSERT
AS
BEGIN
    -- Inserir informações na tabela de histórico
    INSERT INTO Escola.HistoricoInsercaoAluno (Nome, Contacto, Email, IdTurma, DataInsercao)
    SELECT Nome, Contacto, Email, IdTurma, GETDATE()
    FROM inserted;
END;