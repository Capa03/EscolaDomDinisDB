CREATE TRIGGER Escola.trg_AfterUpdateAluno
ON Escola.Aluno
AFTER UPDATE
AS
BEGIN
    IF UPDATE(IdTurma) -- Verifica se a coluna IdTurma foi atualizada
    BEGIN
        -- Inserir informações na tabela de histórico
        INSERT INTO Escola.HistoricoMudancaTurma (IdAluno, IdTurmaAntiga, IdTurmaNova, DataMudanca)
        SELECT 
            i.IdAluno, 
            d.IdTurma AS IdTurmaAntiga, 
            i.IdTurma AS IdTurmaNova, 
            GETDATE()
        FROM inserted i
        INNER JOIN deleted d ON i.IdAluno = d.IdAluno
        WHERE i.IdTurma <> d.IdTurma; -- Inserir apenas se o IdTurma foi realmente alterado
    END
END;