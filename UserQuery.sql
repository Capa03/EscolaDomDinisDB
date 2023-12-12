-- Criação de um login
CREATE LOGIN EscolaLogin
WITH PASSWORD = 'SenhaSegura';

-- Criação de um utilizador associado ao login
CREATE USER EscolaUser
FOR LOGIN EscolaLogin;

-- Concessão de permissões ao utilizador
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Escola TO EscolaUser;