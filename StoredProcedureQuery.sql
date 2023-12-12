
-- Stored Procedure
CREATE PROCEDURE Escola.CalcularMedia
AS
BEGIN
    SELECT AVG(nota) AS Media
    FROM Escola.Avaliacao;
END;

-- Trigger
CREATE TRIGGER Escola.AtualizarMedia
ON Escola.Avaliacao
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    EXEC Escola.CalcularMedia;
END;



-- Agendamento da atualização de estatísticas
USE msdb;

EXEC sp_add_job
    @job_name = 'AtualizarEstatisticasJob',
    @enabled = 1;

EXEC sp_add_jobstep
    @job_name = 'AtualizarEstatisticasJob',
    @step_name = 'AtualizarEstatisticasStep',
    @subsystem = 'TSQL',
    @command = 'UPDATE STATISTICS EscolaDomDinis;';

EXEC sp_add_schedule
    @schedule_name = 'Semanalmente',
    @freq_type = 8,  -- Semanalmente
    @freq_interval = 1,  -- Todas as semanas (domingo)
    @enabled = 1;

EXEC sp_attach_schedule
    @job_name = 'AtualizarEstatisticasJob',
    @schedule_name = 'Semanalmente';

-- Agendamento da execução do job semanalmente
EXEC sp_add_jobserver
    @job_name = 'AtualizarEstatisticasJob',
    @server_name = 'NomeDoServidor';


