
-- Cursor para calcular a média das notas
DECLARE @idAluno INT, @nota INT;
DECLARE nota_cursor CURSOR FOR
    SELECT idAluno, nota
    FROM Escola.Avaliacao;

OPEN nota_cursor;
FETCH NEXT FROM nota_cursor INTO @idAluno, @nota;

DECLARE @total INT = 0, @count INT = 0;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @total = @total + @nota;
    SET @count = @count + 1;
    FETCH NEXT FROM nota_cursor INTO @idAluno, @nota;
END;

CLOSE nota_cursor;
DEALLOCATE nota_cursor;

-- Cálculo da média
DECLARE @media FLOAT = 0;
IF @count > 0
    SET @media = @total / CAST(@count AS FLOAT);

-- Envio de e-mail com a média calculada
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'ProfileName',
    @recipients = 'destinatario@email.com',
    @subject = 'Média das Notas',
    @body = 'A média das notas é ' + CAST(@media AS VARCHAR(10));