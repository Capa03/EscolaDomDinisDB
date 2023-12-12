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

-- Move a tabela existente para o novo schema
ALTER SCHEMA Escola TRANSFER dbo.Curso;
ALTER SCHEMA Escola TRANSFER dbo.Turma;
ALTER SCHEMA Escola TRANSFER dbo.Avaliacao;
ALTER SCHEMA Escola TRANSFER dbo.Resposta;
ALTER SCHEMA Escola TRANSFER dbo.Aluno;
ALTER SCHEMA Escola TRANSFER dbo.Disciplina;
ALTER SCHEMA Escola TRANSFER dbo.Docente;
ALTER SCHEMA Escola TRANSFER dbo.Questionario;

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



