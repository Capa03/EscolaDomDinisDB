-- Alteração do método de preenchimento
ALTER INDEX ALL ON Escola.Aluno
REBUILD WITH (PAD_INDEX = ON);